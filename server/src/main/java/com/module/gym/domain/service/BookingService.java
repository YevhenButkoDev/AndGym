package com.module.gym.domain.service;

import java.math.*;
import java.time.*;
import java.time.temporal.*;
import java.util.*;

import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;

import com.module.gym.domain.entity.*;
import com.module.gym.domain.repository.*;
import com.stripe.exception.*;
import com.stripe.model.*;

import lombok.*;

@Component
@RequiredArgsConstructor
public class BookingService {
    private static final int EXPIRATION_MINUTES = 5;

    private final StripeService stripeService;
    private final BookingRepository bookingRepository;
    private final GymPodRepository gymPodRepository;
    private final AuthService authService;

    @Transactional
    public void rejectPendingBookings() {
        bookingRepository.rejectPendingBookings(Instant.now().minus(EXPIRATION_MINUTES, ChronoUnit.MINUTES));
    }

    public List<Booking> getUserBookings() {
        var currentUser = authService.getCurrentUser();
        return bookingRepository.findAllBookingsByAccountIdAndStartTimeAfter(currentUser.getId(), Instant.now());
    }

    public Map<String, List<Integer>> getBookedSections(Long podId) {
        var gymPod = gymPodRepository.findById(podId);
        if (gymPod.isEmpty()) {
            throw new IllegalArgumentException("Pod id " + podId + " not found");
        }
        var allBookingsForPod = bookingRepository.findAllByGymPodIdAndStartTimeAfterAndStatusIn(
            podId, Instant.now(), List.of(Booking.BookingStatus.PENDING.getStatus(), Booking.BookingStatus.CONFIRMED.getStatus())
        );

        return getBookedSectionsMap(allBookingsForPod, gymPod.get());
    }

    @Transactional
    public String createBooking(
        Long podId,
        LocalDate start,
        Integer startSessionIndex,
        Integer sessions
    ) throws StripeException {
        var gymPod = gymPodRepository.findById(podId);
        if (gymPod.isEmpty()) {
            throw new IllegalArgumentException("Pod id " + podId + " not found");
        }
        var startDateTime = start.atStartOfDay().plusMinutes(startSessionIndex * gymPod.get().getSessionDuration());
        var startInstant = startDateTime.toInstant(ZoneOffset.UTC);

        if (startInstant.isBefore(Instant.now())) {
            throw new IllegalArgumentException("Start time " + startInstant + " is not valid");
        }

        var endInstant = startDateTime.plusMinutes(sessions * gymPod.get().getSessionDuration()).toInstant(ZoneOffset.UTC);
        var intersections = bookingRepository.findBookingsIntersection(podId, startInstant, endInstant);
        if (intersections != 0) {
            throw new IllegalArgumentException("Another booking intersects with yours");
        }

        var account = authService.getCurrentUser();
        Booking booking = new Booking();
        booking.setGymPod(gymPod.get());
        booking.setAccount(account);
        booking.setStartTime(startInstant);
        booking.setEndTime(endInstant);
        booking.setSessions(sessions);
        booking.setStatus(Booking.BookingStatus.PENDING.getStatus());
        booking.setCreatedAt(Instant.now());
        bookingRepository.save(booking);

        var chargeAmount = gymPod.get().getPrice().multiply(BigDecimal.valueOf(sessions)).longValue();
        var paymentIntend = stripeService.createPaymentIntend(
            chargeAmount,
            "USD", // TODO add currency to gym pod
            booking.getId()
        );
        return paymentIntend.getClientSecret();
    }

    @Transactional
    public void confirmBooking(Long bookingId, Payment payment) {
        var optional = bookingRepository.findById(bookingId);
        if (optional.isEmpty()) {
            throw new IllegalArgumentException("Booking id " + bookingId + " not found");
        }
        var booking = optional.get();
        booking.setPayment(payment);
        booking.setStatus(Booking.BookingStatus.CONFIRMED.getStatus());
        bookingRepository.save(booking);
    }

    public PaymentIntent bookSection() {
        try {
            return stripeService.createPaymentIntend(2000L, "USD",1L);
        } catch (StripeException e) {
            throw new RuntimeException(e);
        }
    }

    private static Map<String, List<Integer>> getBookedSectionsMap(List<Booking> allBookingsForPod, GymPod gymPod) {
        Map<String, List<Integer>> result = new HashMap<>();

        for (var booking : allBookingsForPod) {
            var dateTime = LocalDateTime.ofInstant(booking.getStartTime(), ZoneOffset.UTC);
            var date = dateTime.toLocalDate().toString();

            var indexes = result.containsKey(date) ? result.get(date) : new ArrayList<Integer>();
            var minutes = dateTime.getHour() * 60 + dateTime.getMinute();
            int startIndex = (int) (minutes / gymPod.getSessionDuration());

            for (int i = 0; i < booking.getSessions(); i++) {
                indexes.add(startIndex + i);
            }
            result.put(date, indexes);
        }
        return result;
    }

}

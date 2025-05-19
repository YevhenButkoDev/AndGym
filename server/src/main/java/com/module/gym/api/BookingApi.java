package com.module.gym.api;

import java.time.*;
import java.util.*;

import org.springframework.security.access.prepost.*;
import org.springframework.web.bind.annotation.*;

import com.module.gym.api.request.*;
import com.module.gym.api.response.booking.*;
import com.module.gym.domain.service.*;
import com.module.gym.infrastructure.util.*;
import com.stripe.exception.*;

import lombok.*;

@RestController
@RequestMapping("/api/booking")
@RequiredArgsConstructor
public class BookingApi {

    private final BookingService bookingService;

    @PostMapping
    @PreAuthorize("isAuthenticated()")
    public BookingCreateResponse createBooking(@RequestBody BookingCreateRequest request) throws StripeException {
        return new BookingCreateResponse(
                bookingService.createBooking(
                request.podId(),
                TimeFormatterUtil.formatDate(request.start()),
                request.startSessionIndex(),
                request.sessions()
            )
        );
    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping("/pod/{podId}")
    public Map<String, List<Integer>> getBookedSections(@PathVariable Long podId) {
        return bookingService.getBookedSections(podId);
    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping
    public List<BookingRepresentation> getUserBookings() {
        return bookingService.getUserBookings().stream()
            .map(b -> new BookingRepresentation(b.getId(), formatTime(b.getStartTime(), b.getEndTime()), b.getStatus()))
            .toList();
    }

    private String formatTime(Instant start, Instant end) {
        return "%s - %s".formatted(start.toString(), end.toString());
    }
}

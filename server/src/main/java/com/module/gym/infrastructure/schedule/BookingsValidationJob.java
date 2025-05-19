package com.module.gym.infrastructure.schedule;

import org.springframework.scheduling.annotation.*;
import org.springframework.stereotype.*;

import com.module.gym.domain.service.*;

import lombok.*;

@Component
@RequiredArgsConstructor
public class BookingsValidationJob {

    private final BookingService bookingService;

    @Scheduled(fixedRate = 5 * 60 * 1000, initialDelay = 60 * 1000)
    public void rejectPendingBookings() {
        bookingService.rejectPendingBookings();
    }
}

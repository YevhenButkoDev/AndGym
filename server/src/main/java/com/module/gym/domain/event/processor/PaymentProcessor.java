package com.module.gym.domain.event.processor;

import jakarta.transaction.*;

import org.springframework.context.event.*;
import org.springframework.stereotype.*;

import com.fasterxml.jackson.core.*;
import com.module.gym.domain.entity.*;
import com.module.gym.domain.event.*;
import com.module.gym.domain.service.*;

import lombok.*;
import lombok.extern.slf4j.*;

@Component
@RequiredArgsConstructor
@Slf4j
public class PaymentProcessor {

    private final PaymentService paymentService;
    private final BookingService bookingService;

    @EventListener
    @Transactional
    public void handlePayment(PaymentCreated paymentCreated) {
        var payment = paymentService.getPayment(paymentCreated.paymentId());
        try {
            bookingService.confirmBooking(payment.getMetadataObject().bookingId(), payment);
            paymentService.confirmPayment(payment.getId());
        } catch (JsonProcessingException e) {
            log.info("Failed to process payment {}", paymentCreated.paymentId());
            paymentService.failPayment(payment.getId());
        }
    }
}

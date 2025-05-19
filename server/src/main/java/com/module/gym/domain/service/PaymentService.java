package com.module.gym.domain.service;

import jakarta.transaction.*;

import org.springframework.context.*;
import org.springframework.stereotype.*;

import com.module.gym.domain.entity.*;
import com.module.gym.domain.event.*;
import com.module.gym.domain.repository.*;

import lombok.*;
import lombok.extern.slf4j.*;

@Component
@RequiredArgsConstructor
@Slf4j
public class PaymentService {

    private final PaymentRepository paymentRepository;
    private final ApplicationEventPublisher eventPublisher;

    @Transactional
    public void persistPayment(String externalId, String metadata) {
        var persisted = paymentRepository.findOneByExternalId(externalId);
        if (persisted.isEmpty()) {
            Payment payment = new Payment();
            payment.setExternalId(externalId);
            payment.setMetadata(metadata);
            payment.setStatus(Payment.PaymentStatus.PENDING.getStatus());
            paymentRepository.save(payment);

            eventPublisher.publishEvent(new PaymentCreated(payment.getId()));
        } else {
            log.info("Payment already exists, {}", externalId);
        }
    }

    public void failPayment(Long paymentId) {
        paymentRepository.updateStatusById(paymentId, Payment.PaymentStatus.FAILED.getStatus());
    }

    public void confirmPayment(Long paymentId) {
        paymentRepository.updateStatusById(paymentId, Payment.PaymentStatus.PROCESSED.getStatus());
    }

    public Payment getPayment(Long id) {
        return paymentRepository.findById(id).orElse(null);
    }
}

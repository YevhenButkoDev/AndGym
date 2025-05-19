package com.module.gym.api;

import org.springframework.http.*;
import org.springframework.security.access.prepost.*;
import org.springframework.web.bind.annotation.*;

import com.module.gym.domain.service.*;
import com.module.gym.infrastructure.config.property.*;
import com.stripe.exception.*;
import com.stripe.net.*;
import com.stripe.model.Event;

import lombok.*;
import lombok.extern.slf4j.*;

@RestController
@RequestMapping("/api/stripe")
@RequiredArgsConstructor
@Slf4j
public class StripeApi {

    private final StripeProperties stripeProperties;
    private final PaymentService paymentService;

    @PreAuthorize("permitAll()")
    @PostMapping
    public ResponseEntity<String> handleStripeEvent(
        @RequestBody String payload,
        @RequestHeader("Stripe-Signature") String sigHeader
    ) {

        Event event;

        try {
            event = Webhook.constructEvent(payload, sigHeader, stripeProperties.getWebhookSecret());
        } catch (SignatureVerificationException e) {
            log.info("⚠️  Webhook signature verification failed.");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid signature");
        }

        // Process the event
        if (event.getType().equals("payment_intent.succeeded")) {
            paymentService.persistPayment(event.getId(), event.getData().toJson());
        } else {
            log.info("Unhandled event type: {}", event.getType());
        }

        return ResponseEntity.ok("Event received");
    }
}

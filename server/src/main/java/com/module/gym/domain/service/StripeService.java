package com.module.gym.domain.service;

import static com.module.gym.infrastructure.Constants.BOOKING_ID_PARAMETER;

import org.springframework.stereotype.*;

import com.module.gym.infrastructure.config.property.*;
import com.stripe.*;
import com.stripe.exception.*;
import com.stripe.model.*;
import com.stripe.param.*;

import lombok.*;

@Component
@RequiredArgsConstructor
public class StripeService {

    private final StripeProperties stripeProperties;

    public PaymentIntent createPaymentIntend(Long amount, String currency, Long bookingId) throws StripeException {
        Stripe.apiKey = stripeProperties.getApiKey();

        PaymentIntentCreateParams params =
            PaymentIntentCreateParams.builder()
                .setAmount(amount)
                .setCurrency(currency)
                .putMetadata(BOOKING_ID_PARAMETER, bookingId.toString())
                .setAutomaticPaymentMethods(
                    PaymentIntentCreateParams.AutomaticPaymentMethods.builder()
                        .setEnabled(true)
                        .build())
                .build();

        return PaymentIntent.create(params);
    }
}

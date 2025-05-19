package com.module.gym.infrastructure.config.property;

import org.springframework.boot.context.properties.*;
import org.springframework.stereotype.*;

import lombok.*;

@Component
@ConfigurationProperties(prefix = "stripe")
@Getter
@Setter
public class StripeProperties {
    private String apiKey;
    private String webhookSecret;
}

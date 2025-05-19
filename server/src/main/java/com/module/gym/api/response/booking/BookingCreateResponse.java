package com.module.gym.api.response.booking;

import lombok.*;

@Builder
public record BookingCreateResponse(String clientSecret) {
}

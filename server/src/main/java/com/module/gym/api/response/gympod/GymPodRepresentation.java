package com.module.gym.api.response.gympod;

import java.math.*;

import lombok.*;

@Builder
public class GymPodRepresentation {
    public Long id;
    public String location;
    public BigDecimal price;
}

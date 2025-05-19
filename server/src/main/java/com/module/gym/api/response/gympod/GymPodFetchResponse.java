package com.module.gym.api.response.gympod;

import java.util.*;

import lombok.*;

@Builder
public class GymPodFetchResponse {
    public final List<GymPodRepresentation> pods;
}


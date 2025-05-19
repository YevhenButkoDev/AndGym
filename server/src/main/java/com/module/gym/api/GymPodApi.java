package com.module.gym.api;

import org.springframework.security.access.prepost.*;
import org.springframework.web.bind.annotation.*;

import com.module.gym.api.response.gympod.*;
import com.module.gym.domain.service.*;

import lombok.*;

@RestController
@RequestMapping("/api/gym-pod")
@RequiredArgsConstructor
public class GymPodApi {

    private final GymPodService gymPodService;

    @PreAuthorize("isAuthenticated()")
    @GetMapping
    public GymPodFetchResponse fetchAllPods() {
        return GymPodFetchResponse.builder()
            .pods(gymPodService.findAll().stream()
                    .map(pod -> GymPodRepresentation.builder()
                        .id(pod.getId())
                        .location(pod.getLocation())
                        .price(pod.getPrice())
                        .build())
                    .toList())
            .build();
    }
}

package com.module.gym.domain.service;

import java.util.*;

import org.springframework.stereotype.*;

import com.module.gym.domain.entity.*;
import com.module.gym.domain.repository.*;

import lombok.*;

@Component
@RequiredArgsConstructor
public class GymPodService {

    private final GymPodRepository gymPodRepository;

    public List<GymPod> findAll() {
        return gymPodRepository.findAll();
    }
}

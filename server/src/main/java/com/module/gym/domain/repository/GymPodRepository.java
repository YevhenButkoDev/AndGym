package com.module.gym.domain.repository;

import org.springframework.data.jpa.repository.*;

import com.module.gym.domain.entity.*;

public interface GymPodRepository extends JpaRepository<GymPod, Long> {
}

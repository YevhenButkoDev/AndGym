package com.module.gym.domain.entity;

import jakarta.persistence.*;
import java.math.*;
import java.util.*;

import lombok.*;

@Getter
@Setter
@Entity
@Table(name = "gym_pod")
public class GymPod {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "location")
    private String location;

    @Column(name = "price", precision = 10, scale = 2)
    private BigDecimal price;

    @OneToMany(mappedBy = "gymPod")
    private Set<GymPodImage> gymPodImages = new LinkedHashSet<>();

    public Long getSessionDuration() {
        return 30L;
    }
}
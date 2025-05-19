package com.module.gym.domain.entity;

import jakarta.persistence.*;

import lombok.*;

@Getter
@Setter
@Entity
@Table(name = "gym_pod_images")
public class GymPodImage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "gym_pod_id", nullable = false)
    private GymPod gymPod;

    @Column(name = "url", length = 500)
    private String url;

}
package com.module.gym.domain.entity;

import jakarta.persistence.*;
import java.time.*;

import lombok.*;

@Getter
@Setter
@Entity
@Table(name = "booking")
public class Booking {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "gym_pod_id", nullable = false)
    private GymPod gymPod;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "account_id", nullable = false)
    private Account account;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "payment_id")
    private Payment payment;

    @Column(name = "start_time")
    private Instant startTime;

    @Column(name = "end_time")
    private Instant endTime;

    @Column(name = "sessions")
    private Integer sessions;

    @Column(name = "status")
    private Integer status;

    @Column(name = "created_at")
    private Instant createdAt;

    @Getter
    public enum BookingStatus {
        PENDING(1),
        CONFIRMED(2),
        REJECTED(3);

        private final Integer status;

        BookingStatus(Integer i) {
            status = i;
        }
    }
}
package com.module.gym.domain.entity;

import jakarta.persistence.*;
import java.util.*;

import lombok.*;

@Getter
@Setter
@Entity
@Table(name = "account")
public class Account {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "email", nullable = false)
    private String email;

    @Column(name = "name")
    private String name;

    @ManyToMany
    @JoinTable(name = "account_authority",
        joinColumns = @JoinColumn(name = "account_id"),
        inverseJoinColumns = @JoinColumn(name = "authority_id"))
    private Set<Authority> authorities = new LinkedHashSet<>();

    @OneToMany(mappedBy = "account")
    private Set<Booking> bookings = new LinkedHashSet<>();

}
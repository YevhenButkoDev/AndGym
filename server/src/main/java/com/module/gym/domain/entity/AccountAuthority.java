package com.module.gym.domain.entity;

import jakarta.persistence.*;

import lombok.*;

@Getter
@Setter
@Entity
@Table(name = "account_authority")
public class AccountAuthority {
    @EmbeddedId
    private AccountAuthorityId id;

    @MapsId("accountId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "account_id", nullable = false)
    private Account account;

    @MapsId("authorityId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "authority_id", nullable = false)
    private Authority authority;

}
package com.module.gym.domain.entity;

import jakarta.persistence.*;
import java.util.*;

import org.hibernate.*;

import lombok.*;

@Getter
@Setter
@Embeddable
public class AccountAuthorityId implements java.io.Serializable {
    private static final long serialVersionUID = 3870582051593080853L;
    @Column(name = "account_id", nullable = false)
    private Long accountId;

    @Column(name = "authority_id", nullable = false)
    private Long authorityId;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) {
            return false;
        }
        AccountAuthorityId entity = (AccountAuthorityId) o;
        return Objects.equals(this.accountId, entity.accountId) &&
            Objects.equals(this.authorityId, entity.authorityId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(accountId, authorityId);
    }

}
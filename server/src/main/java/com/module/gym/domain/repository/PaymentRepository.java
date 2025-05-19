package com.module.gym.domain.repository;

import jakarta.transaction.*;
import java.util.*;

import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.*;
import org.springframework.stereotype.*;

import com.module.gym.domain.entity.*;

@Repository
public interface PaymentRepository extends JpaRepository<Payment, Long> {

    Optional<Payment> findOneByExternalId(String id);

    @Modifying
    @Transactional
    @Query("UPDATE Payment p SET p.status = :status WHERE p.id = :id")
    void updateStatusById(@Param("id") Long id, @Param("status") int status);
}

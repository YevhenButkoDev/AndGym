package com.module.gym.domain.service;

import org.springframework.stereotype.*;

import com.module.gym.domain.entity.*;
import com.module.gym.domain.repository.*;

import lombok.*;

@Component
@RequiredArgsConstructor
public class AccountService {

    private final AccountRepository accountRepository;

    public void register(String email, String name) {
        if (accountRepository.findByEmail(email).isPresent()) {
            throw new IllegalArgumentException("Email already exists");
        }

        var accountEntity = new Account();
        accountEntity.setEmail(email);
        accountEntity.setName(name);
        accountRepository.save(accountEntity);
    }
}

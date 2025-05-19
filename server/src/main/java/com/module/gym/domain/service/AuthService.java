package com.module.gym.domain.service;

import org.springframework.security.core.context.*;
import org.springframework.stereotype.*;

import com.google.firebase.auth.*;
import com.module.gym.domain.entity.*;
import com.module.gym.domain.repository.*;

import lombok.*;

@Component
@RequiredArgsConstructor
public class AuthService {

    private final AccountRepository accountRepository;

    Account getCurrentUser() {
        var authentication = (FirebaseToken) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return accountRepository
            .findByEmail(authentication.getEmail())
            .orElseThrow(() -> new IllegalArgumentException("User not found"));
    }
}

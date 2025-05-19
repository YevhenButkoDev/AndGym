package com.module.gym.api;

import java.util.*;

import org.springframework.security.access.prepost.*;
import org.springframework.web.bind.annotation.*;

import com.module.gym.api.request.*;
import com.module.gym.api.response.booking.*;
import com.module.gym.domain.service.*;

import lombok.*;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class AccountApi {

    private final BookingService bookingService;
    private final AccountService accountService;

    @PreAuthorize("isAuthenticated()")
    @GetMapping("/secure-data")
    public Map<String, Object> getSecureData() {
        return Map.of("message", "Access granted");
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping("/book-section")
    public BookingCreateResponse bookSection() {
        var pi = bookingService.bookSection();
        return BookingCreateResponse.builder()
            .clientSecret(pi.getClientSecret())
            .build();
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping("/register")
    public void register(@RequestBody AccountRegisterRequest request) {
        accountService.register(request.email(), request.name());
    }
}

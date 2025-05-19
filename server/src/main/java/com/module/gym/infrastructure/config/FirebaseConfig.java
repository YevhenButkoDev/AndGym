package com.module.gym.infrastructure.config;

import jakarta.annotation.*;
import java.io.*;

import org.springframework.context.annotation.*;

import com.google.auth.oauth2.*;
import com.google.firebase.*;

@Configuration
public class FirebaseConfig {

    @PostConstruct
    public void init() throws IOException {
        FirebaseOptions options = FirebaseOptions.builder()
            .setCredentials(GoogleCredentials.getApplicationDefault())
            .build();

        if (FirebaseApp.getApps().isEmpty()) {
            FirebaseApp.initializeApp(options);
        }
    }
}

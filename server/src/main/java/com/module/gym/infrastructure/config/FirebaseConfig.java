package com.module.gym.infrastructure.config;

import jakarta.annotation.*;
import java.io.*;
import java.util.*;

import org.springframework.context.annotation.*;

import com.google.auth.oauth2.*;
import com.google.firebase.*;

@Configuration
public class FirebaseConfig {

    @PostConstruct
    public void init() throws IOException {
        String base64Creds = System.getenv("FIREBASE_CREDENTIALS_BASE64");
        if (base64Creds == null) {
            throw new IllegalStateException("FIREBASE_CREDENTIALS_BASE64 env variable is not set");
        }

        byte[] decoded = Base64.getDecoder().decode(base64Creds);
        ByteArrayInputStream credentialsStream = new ByteArrayInputStream(decoded);

        FirebaseOptions options = FirebaseOptions.builder()
            .setCredentials(GoogleCredentials.fromStream(credentialsStream))
            .build();

        if (FirebaseApp.getApps().isEmpty()) {
            FirebaseApp.initializeApp(options);
        }
    }
}

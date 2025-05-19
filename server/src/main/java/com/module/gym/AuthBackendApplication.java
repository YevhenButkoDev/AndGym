package com.module.gym;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.*;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.*;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.filter.*;

import com.fasterxml.jackson.databind.*;

import liquibase.integration.spring.*;

@SpringBootApplication
@EnableScheduling
@EnableConfigurationProperties
public class AuthBackendApplication {

    public static void main(String[] args) {
        SpringApplication.run(AuthBackendApplication.class, args);
    }

}


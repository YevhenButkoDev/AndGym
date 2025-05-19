package com.module.gym.api.request;

public record AccountRegisterRequest(
    String email,
    String name
) {
}

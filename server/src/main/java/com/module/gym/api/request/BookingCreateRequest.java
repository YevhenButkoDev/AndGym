package com.module.gym.api.request;

public record BookingCreateRequest(
    Long podId,
    String start,
    Integer startSessionIndex,
    Integer sessions
) { }

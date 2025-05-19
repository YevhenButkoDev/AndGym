package com.module.gym.domain.entity;

import static com.module.gym.infrastructure.Constants.BOOKING_ID_PARAMETER;

import jakarta.persistence.*;

import java.util.*;

import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;

import lombok.*;

@Getter
@Setter
@Entity
@Table(name = "payment")
public class Payment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "external_id")
    private String externalId;

    @Column(name = "metadata", columnDefinition = "jsonb")
    private String metadata;

    @Column(name = "status")
    private Integer status;

    private final static ObjectMapper objectMapper = new ObjectMapper();

    public PaymentMetadata getMetadataObject() throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(metadata);

        JsonNode metadataNode = root.path("object").path("metadata");

        Map<String, String> parsedMeta = mapper.convertValue(metadataNode, Map.class);
        var bookingId = Long.parseLong(parsedMeta.get(BOOKING_ID_PARAMETER));
        return new PaymentMetadata(bookingId);
    }

    public record PaymentMetadata(Long bookingId) { }

    @Getter
    public enum PaymentStatus {
        PENDING(1),
        PROCESSED(2),
        REJECTED(3),
        FAILED(4);

        private final Integer status;

        PaymentStatus(Integer i) {
            status = i;
        }
    }
}
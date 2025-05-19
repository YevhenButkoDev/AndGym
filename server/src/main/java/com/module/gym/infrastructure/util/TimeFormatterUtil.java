package com.module.gym.infrastructure.util;

import java.time.*;
import java.time.format.*;

public class TimeFormatterUtil {

    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");

    public static LocalDate formatDate(String dateString) {
        if (dateString.contains(".")) {
            dateString = dateString.substring(0, dateString.indexOf('.') + 4); // Keep 3 digits
        }
        LocalDateTime dateTime = LocalDateTime.parse(dateString, formatter);
        return dateTime.toLocalDate();
    }
}

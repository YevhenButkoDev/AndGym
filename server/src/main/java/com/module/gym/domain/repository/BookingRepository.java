package com.module.gym.domain.repository;

import jakarta.transaction.*;
import java.time.*;
import java.util.*;

import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.*;

import com.module.gym.domain.entity.*;

public interface BookingRepository extends JpaRepository<Booking, Long> {

    @Query("""
        SELECT count(b)
        FROM Booking b
        WHERE
            b.gymPod.id = :id AND
            b.status IN (1, 2) AND
            ((b.startTime >= :start AND b.startTime < :end) OR (b.endTime > :start AND b.endTime <= :end))
    """)
    Long findBookingsIntersection(
        @Param("id") Long gymPodId,
        @Param("start") Instant start,
        @Param("end") Instant end
    );

    List<Booking> findAllByGymPodIdAndStartTimeAfterAndStatusIn(Long id, Instant before, List<Integer> statuses);

    @Modifying
    @Transactional
    @Query("UPDATE Booking b SET b.status = 3 WHERE b.createdAt < :threshold AND b.status = 1")
    void rejectPendingBookings(@Param("threshold") Instant threshold);

    List<Booking> findAllBookingsByAccountIdAndStartTimeAfter(Long accountId, Instant start);
}

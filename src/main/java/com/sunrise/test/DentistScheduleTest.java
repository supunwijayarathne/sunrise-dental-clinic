package com.sunrise.test;

import static org.junit.jupiter.api.Assertions.*;

import java.time.LocalTime;

import org.junit.jupiter.api.Test;

import com.sunrise.model.DentistSchedule;

public class DentistScheduleTest {

    @Test
    public void testDentistSchedule() {

        DentistSchedule schedule = new DentistSchedule();

        schedule.setScheduleId(1);
        schedule.setDentistId(1);
        schedule.setDayOfWeek("Monday");
        schedule.setStartTime(LocalTime.of(9, 0));
        schedule.setEndTime(LocalTime.of(17, 0));
        schedule.setSlotDuration(30);
        schedule.setActive(true);

        assertEquals(1, schedule.getScheduleId());
        assertEquals(1, schedule.getDentistId());
        assertEquals("Monday", schedule.getDayOfWeek());
        assertEquals(LocalTime.of(9, 0), schedule.getStartTime());
        assertEquals(LocalTime.of(17, 0), schedule.getEndTime());
        assertEquals(30, schedule.getSlotDuration());
        assertTrue(schedule.isActive());
    }
}
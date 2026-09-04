package com.sunrise.test.service;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.sunrise.model.DentistSchedule;
import com.sunrise.service.DentistScheduleService;

class DentistScheduleServiceTest {

    private DentistScheduleService dentistScheduleService;

    @BeforeEach
    void setUp() {
        dentistScheduleService = new DentistScheduleService();
    }

    // =========================================================
    // GET SCHEDULES BY DENTIST
    // =========================================================

    @Test
    void getSchedulesByDentistShouldReturnEmptyListForInvalidId() {

        List<DentistSchedule> result =
                dentistScheduleService.getSchedulesByDentist(0);

        assertNotNull(result);
        assertTrue(result.isEmpty());
    }

    @Test
    void getSchedulesByDentistShouldReturnEmptyListForNegativeId() {

        List<DentistSchedule> result =
                dentistScheduleService.getSchedulesByDentist(-1);

        assertNotNull(result);
        assertTrue(result.isEmpty());
    }


    // =========================================================
    // GET SCHEDULES BY DENTIST AND DAY
    // =========================================================

    @Test
    void getSchedulesByDentistAndDayShouldReturnEmptyListForInvalidDentistId() {

        List<DentistSchedule> result =
                dentistScheduleService.getSchedulesByDentistAndDay(
                        0,
                        "MONDAY"
                );

        assertNotNull(result);
        assertTrue(result.isEmpty());
    }

    @Test
    void getSchedulesByDentistAndDayShouldHandleBlankDay() {

        List<DentistSchedule> result =
                dentistScheduleService.getSchedulesByDentistAndDay(
                        0,
                        ""
                );

        assertNotNull(result);
        assertTrue(result.isEmpty());
    }

    @Test
    void getSchedulesByDentistAndDayShouldHandleNullDay() {

        List<DentistSchedule> result =
                dentistScheduleService.getSchedulesByDentistAndDay(
                        0,
                        null
                );

        assertNotNull(result);
        assertTrue(result.isEmpty());
    }


    // =========================================================
    // REPLACE DENTIST SCHEDULE
    // =========================================================

    @Test
    void replaceDentistScheduleShouldRejectInvalidDentistId() {

        boolean result =
                dentistScheduleService.replaceDentistSchedule(
                        0,
                        new ArrayList<>()
                );

        assertFalse(result);
    }

    @Test
    void replaceDentistScheduleShouldRejectNegativeDentistId() {

        boolean result =
                dentistScheduleService.replaceDentistSchedule(
                        -1,
                        new ArrayList<>()
                );

        assertFalse(result);
    }

    @Test
    void replaceDentistScheduleShouldRejectNullScheduleList() {

        boolean result =
                dentistScheduleService.replaceDentistSchedule(
                        1,
                        null
                );

        assertFalse(result);
    }

    @Test
    void replaceDentistScheduleShouldRejectNullSchedule() {

        List<DentistSchedule> schedules =
                new ArrayList<>();

        schedules.add(null);

        boolean result =
                dentistScheduleService.replaceDentistSchedule(
                        1,
                        schedules
                );

        assertFalse(result);
    }

    @Test
    void replaceDentistScheduleShouldRejectMissingDay() {

        DentistSchedule schedule =
                new DentistSchedule();

        schedule.setStartTime(LocalTime.of(9, 0));
        schedule.setEndTime(LocalTime.of(17, 0));
        schedule.setSlotDuration(30);

        List<DentistSchedule> schedules =
                new ArrayList<>();

        schedules.add(schedule);

        boolean result =
                dentistScheduleService.replaceDentistSchedule(
                        1,
                        schedules
                );

        assertFalse(result);
    }

    @Test
    void replaceDentistScheduleShouldRejectMissingStartTime() {

        DentistSchedule schedule =
                new DentistSchedule();

        schedule.setDayOfWeek("MONDAY");
        schedule.setEndTime(LocalTime.of(17, 0));
        schedule.setSlotDuration(30);

        List<DentistSchedule> schedules =
                new ArrayList<>();

        schedules.add(schedule);

        boolean result =
                dentistScheduleService.replaceDentistSchedule(
                        1,
                        schedules
                );

        assertFalse(result);
    }

    @Test
    void replaceDentistScheduleShouldRejectMissingEndTime() {

        DentistSchedule schedule =
                new DentistSchedule();

        schedule.setDayOfWeek("MONDAY");
        schedule.setStartTime(LocalTime.of(9, 0));
        schedule.setSlotDuration(30);

        List<DentistSchedule> schedules =
                new ArrayList<>();

        schedules.add(schedule);

        boolean result =
                dentistScheduleService.replaceDentistSchedule(
                        1,
                        schedules
                );

        assertFalse(result);
    }

    @Test
    void replaceDentistScheduleShouldRejectInvalidTimeRange() {

        DentistSchedule schedule =
                new DentistSchedule();

        schedule.setDayOfWeek("MONDAY");
        schedule.setStartTime(LocalTime.of(17, 0));
        schedule.setEndTime(LocalTime.of(9, 0));
        schedule.setSlotDuration(30);

        List<DentistSchedule> schedules =
                new ArrayList<>();

        schedules.add(schedule);

        boolean result =
                dentistScheduleService.replaceDentistSchedule(
                        1,
                        schedules
                );

        assertFalse(result);
    }

    @Test
    void replaceDentistScheduleShouldRejectEqualStartAndEndTime() {

        DentistSchedule schedule =
                new DentistSchedule();

        schedule.setDayOfWeek("MONDAY");
        schedule.setStartTime(LocalTime.of(9, 0));
        schedule.setEndTime(LocalTime.of(9, 0));
        schedule.setSlotDuration(30);

        List<DentistSchedule> schedules =
                new ArrayList<>();

        schedules.add(schedule);

        boolean result =
                dentistScheduleService.replaceDentistSchedule(
                        1,
                        schedules
                );

        assertFalse(result);
    }

    @Test
    void replaceDentistScheduleShouldRejectInvalidSlotDuration() {

        DentistSchedule schedule =
                new DentistSchedule();

        schedule.setDayOfWeek("MONDAY");
        schedule.setStartTime(LocalTime.of(9, 0));
        schedule.setEndTime(LocalTime.of(17, 0));
        schedule.setSlotDuration(0);

        List<DentistSchedule> schedules =
                new ArrayList<>();

        schedules.add(schedule);

        boolean result =
                dentistScheduleService.replaceDentistSchedule(
                        1,
                        schedules
                );

        assertFalse(result);
    }

    @Test
    void replaceDentistScheduleShouldRejectNegativeSlotDuration() {

        DentistSchedule schedule =
                new DentistSchedule();

        schedule.setDayOfWeek("MONDAY");
        schedule.setStartTime(LocalTime.of(9, 0));
        schedule.setEndTime(LocalTime.of(17, 0));
        schedule.setSlotDuration(-30);

        List<DentistSchedule> schedules =
                new ArrayList<>();

        schedules.add(schedule);

        boolean result =
                dentistScheduleService.replaceDentistSchedule(
                        1,
                        schedules
                );

        assertFalse(result);
    }

    @Test
    void replaceDentistScheduleShouldRejectBlankDay() {

        DentistSchedule schedule =
                new DentistSchedule();

        schedule.setDayOfWeek("   ");
        schedule.setStartTime(LocalTime.of(9, 0));
        schedule.setEndTime(LocalTime.of(17, 0));
        schedule.setSlotDuration(30);

        List<DentistSchedule> schedules =
                new ArrayList<>();

        schedules.add(schedule);

        boolean result =
                dentistScheduleService.replaceDentistSchedule(
                        1,
                        schedules
                );

        assertFalse(result);
    }
}
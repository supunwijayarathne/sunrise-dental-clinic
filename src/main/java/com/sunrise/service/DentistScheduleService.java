package com.sunrise.service;

import java.time.LocalTime;
import java.util.List;

import com.sunrise.dao.DentistScheduleDAO;
import com.sunrise.model.DentistSchedule;

public class DentistScheduleService {

    private final DentistScheduleDAO dentistScheduleDAO;


    // =========================================================
    // CONSTRUCTOR
    // =========================================================

    public DentistScheduleService() {

        dentistScheduleDAO = new DentistScheduleDAO();
    }


    // =========================================================
    // GET SCHEDULES BY DENTIST
    // =========================================================

    public List<DentistSchedule> getSchedulesByDentist(
            int dentistId) {

        if (dentistId <= 0) {
            return List.of();
        }

        return dentistScheduleDAO.getSchedulesByDentist(
                dentistId
        );
    }


    // =========================================================
    // GET SCHEDULES BY DENTIST AND DAY
    // =========================================================

    public List<DentistSchedule> getSchedulesByDentistAndDay(
            int dentistId,
            String day) {

        if (dentistId <= 0) {
            return List.of();
        }

        if (day == null || day.trim().isEmpty()) {
            return getSchedulesByDentist(dentistId);
        }

        return dentistScheduleDAO.getSchedulesByDentistAndDay(
                dentistId,
                day.trim().toUpperCase()
        );
    }


    // =========================================================
    // REPLACE DENTIST SCHEDULE
    // =========================================================

    public boolean replaceDentistSchedule(
            int dentistId,
            List<DentistSchedule> schedules) {

        // -----------------------------------------------------
        // Validate dentist ID
        // -----------------------------------------------------

        if (dentistId <= 0) {
            return false;
        }


        // -----------------------------------------------------
        // Validate schedule list
        // -----------------------------------------------------

        if (schedules == null) {
            return false;
        }


        // -----------------------------------------------------
        // Validate every schedule
        // -----------------------------------------------------

        for (DentistSchedule schedule : schedules) {

            if (schedule == null) {
                return false;
            }


            // Make sure the schedule belongs to the dentist
            schedule.setDentistId(dentistId);


            // Validate day
            if (schedule.getDayOfWeek() == null
                    || schedule.getDayOfWeek()
                               .trim()
                               .isEmpty()) {

                return false;
            }


            // Validate times
            LocalTime start =
                    schedule.getStartTime();

            LocalTime end =
                    schedule.getEndTime();

            if (start == null || end == null) {
                return false;
            }


            if (!end.isAfter(start)) {
                return false;
            }


            // Validate slot duration
            if (schedule.getSlotDuration() <= 0) {
                return false;
            }


            // Clean day
            schedule.setDayOfWeek(
                    schedule.getDayOfWeek()
                            .trim()
                            .toUpperCase()
            );


            // Schedule being saved is active
            schedule.setActive(true);
        }


        // -----------------------------------------------------
        // Save schedules
        // -----------------------------------------------------

        return dentistScheduleDAO.replaceDentistSchedule(
                dentistId,
                schedules
        );
    }
}
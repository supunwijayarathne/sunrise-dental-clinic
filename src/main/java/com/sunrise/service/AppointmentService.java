package com.sunrise.service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.sunrise.dao.AppointmentDAO;
import com.sunrise.dao.DentistScheduleDAO;
import com.sunrise.model.Appointment;
import com.sunrise.model.DentistSchedule;

/**
 * Service layer for appointment operations.
 *
 * Responsibilities:
 * - Appointment validation
 * - Appointment conflict checking
 * - Appointment number generation
 * - Available-slot calculation
 * - Delegating persistence to DAO classes
 *
 * Architecture:
 * API -> Service -> DAO -> Database
 */
public class AppointmentService {

    private final AppointmentDAO appointmentDAO;
    private final DentistScheduleDAO scheduleDAO;

    public AppointmentService() {

        appointmentDAO =
                new AppointmentDAO();

        scheduleDAO =
                new DentistScheduleDAO();
    }

    // =========================================================
    // GET ALL APPOINTMENTS
    // =========================================================

    public List<Appointment> getAllAppointments() {

        return appointmentDAO.getAllAppointments();
    }

    // =========================================================
    // GET APPOINTMENT BY ID
    // =========================================================

    public Appointment getAppointmentById(
            int appointmentId) {

        if (appointmentId <= 0) {
            return null;
        }

        return appointmentDAO.getAppointmentById(
                appointmentId
        );
    }

    // =========================================================
    // SEARCH APPOINTMENTS
    // =========================================================

    public List<Appointment> searchAppointments(
            String keyword) {

        if (keyword == null) {
            keyword = "";
        }

        return appointmentDAO.searchAppointments(
                keyword.trim()
        );
    }

    // =========================================================
    // GET APPOINTMENTS BY PATIENT
    // =========================================================

    public List<Appointment> getAppointmentsByPatient(
            int patientId) {

        if (patientId <= 0) {
            return List.of();
        }

        return appointmentDAO.getAppointmentsByPatient(
                patientId
        );
    }

    // =========================================================
    // GET APPOINTMENTS BY DENTIST
    // =========================================================

    public List<Appointment> getAppointmentsByDentist(
            int dentistId) {

        if (dentistId <= 0) {
            return List.of();
        }

        return appointmentDAO.getAppointmentsByDentist(
                dentistId
        );
    }

    // =========================================================
    // GET TODAY'S APPOINTMENTS
    // =========================================================

    public List<Appointment> getTodayAppointments() {

        return appointmentDAO.getTodayAppointments();
    }

    // =========================================================
    // GENERATE APPOINTMENT NUMBER
    // =========================================================

    public String generateAppointmentNumber() {

        return appointmentDAO.generateNextAppointmentNumber();
    }

    // =========================================================
    // CHECK DENTIST AVAILABILITY
    // =========================================================

    public boolean isDentistAvailable(
            int dentistId,
            LocalDate appointmentDate,
            LocalTime appointmentTime,
            int appointmentId) {

        if (dentistId <= 0
                || appointmentDate == null
                || appointmentTime == null) {

            return false;
        }

        return appointmentDAO.isDentistAvailable(
                dentistId,
                appointmentDate,
                appointmentTime,
                appointmentId
        );
    }

    // =========================================================
    // CHECK PATIENT AVAILABILITY
    // =========================================================

    public boolean isPatientAvailable(
            int patientId,
            LocalDate appointmentDate,
            LocalTime appointmentTime,
            int appointmentId) {

        if (patientId <= 0
                || appointmentDate == null
                || appointmentTime == null) {

            return false;
        }

        return appointmentDAO.isPatientAvailable(
                patientId,
                appointmentDate,
                appointmentTime,
                appointmentId
        );
    }

    // =========================================================
    // GET BOOKED TIMES
    // =========================================================

    public List<LocalTime> getBookedTimes(
            int dentistId,
            LocalDate appointmentDate,
            int appointmentId) {

        if (dentistId <= 0
                || appointmentDate == null) {

            return List.of();
        }

        return appointmentDAO.getBookedTimes(
                dentistId,
                appointmentDate,
                appointmentId
        );
    }

    // =========================================================
    // GET DENTIST SCHEDULE
    // =========================================================

    public List<DentistSchedule>
    getSchedulesByDentistAndDay(
            int dentistId,
            String day) {

        if (dentistId <= 0
                || day == null
                || day.trim().isEmpty()) {

            return List.of();
        }

        return scheduleDAO
                .getSchedulesByDentistAndDay(
                        dentistId,
                        day.trim().toUpperCase()
                );
    }

    // =========================================================
    // GET AVAILABLE SLOTS
    // =========================================================

    public List<LocalTime> getAvailableSlots(
            int dentistId,
            LocalDate date) {

        if (dentistId <= 0
                || date == null) {

            return List.of();
        }

        // -----------------------------------------------------
        // Get day name
        // -----------------------------------------------------

        String day =
                date.getDayOfWeek()
                    .name();

        // -----------------------------------------------------
        // Get dentist schedule
        // -----------------------------------------------------

        List<DentistSchedule> schedules =
                scheduleDAO
                        .getSchedulesByDentistAndDay(
                                dentistId,
                                day
                        );

        // -----------------------------------------------------
        // Get already booked times
        // -----------------------------------------------------

        List<LocalTime> booked =
                appointmentDAO.getBookedTimes(
                        dentistId,
                        date,
                        0
                );

        Set<LocalTime> busy =
                new HashSet<>(booked);

        // -----------------------------------------------------
        // Calculate available slots
        // -----------------------------------------------------

        List<LocalTime> available =
                new java.util.ArrayList<>();

        for (DentistSchedule schedule :
                schedules) {

            if (schedule == null
                    || schedule.getStartTime() == null
                    || schedule.getEndTime() == null) {

                continue;
            }

            int duration =
                    schedule.getSlotDuration();

            if (duration <= 0) {
                duration = 30;
            }

            for (
                LocalTime time =
                        schedule.getStartTime();

                time.isBefore(
                        schedule.getEndTime()
                );

                time =
                        time.plusMinutes(duration)
            ) {

                LocalTime end =
                        time.plusMinutes(duration);

                // Do not create a slot that goes
                // beyond the dentist's schedule.
                if (end.isAfter(
                        schedule.getEndTime()
                )) {

                    break;
                }

                if (!busy.contains(time)) {

                    available.add(time);
                }
            }
        }

        return available;
    }

    // =========================================================
    // CREATE APPOINTMENT
    // =========================================================

    public boolean createAppointment(
            Appointment appointment) {

        if (appointment == null) {
            return false;
        }

        // -----------------------------------------------------
        // Required IDs
        // -----------------------------------------------------

        if (appointment.getPatientId() <= 0
                || appointment.getDentistId() <= 0
                || appointment.getTreatmentId() <= 0) {

            return false;
        }

        // -----------------------------------------------------
        // Required date/time
        // -----------------------------------------------------

        if (appointment.getAppointmentDate() == null
                || appointment.getAppointmentTime() == null) {

            return false;
        }

        // -----------------------------------------------------
        // Required creator
        // -----------------------------------------------------

        if (appointment.getCreatedBy() <= 0) {
            return false;
        }

        // -----------------------------------------------------
        // Status
        // -----------------------------------------------------

        if (appointment.getStatus() == null
                || appointment.getStatus().trim().isEmpty()) {

            appointment.setStatus(
                    "SCHEDULED"
            );

        } else {

            appointment.setStatus(
                    appointment.getStatus()
                            .trim()
                            .toUpperCase()
            );
        }

        // -----------------------------------------------------
        // Notes
        // -----------------------------------------------------

        if (appointment.getNotes() != null) {

            appointment.setNotes(
                    appointment.getNotes().trim()
            );
        }

        // -----------------------------------------------------
        // Generate appointment number
        // -----------------------------------------------------

        if (appointment.getAppointmentNumber() == null
                || appointment.getAppointmentNumber()
                        .trim()
                        .isEmpty()) {

            appointment.setAppointmentNumber(
                    generateAppointmentNumber()
            );
        }

        // -----------------------------------------------------
        // Dentist conflict
        // -----------------------------------------------------

        if (!isDentistAvailable(
                appointment.getDentistId(),
                appointment.getAppointmentDate(),
                appointment.getAppointmentTime(),
                0
        )) {

            return false;
        }

        // -----------------------------------------------------
        // Patient conflict
        // -----------------------------------------------------

        if (!isPatientAvailable(
                appointment.getPatientId(),
                appointment.getAppointmentDate(),
                appointment.getAppointmentTime(),
                0
        )) {

            return false;
        }

        // -----------------------------------------------------
        // Persist
        // -----------------------------------------------------

        return appointmentDAO.addAppointment(
                appointment
        );
    }

    // =========================================================
    // UPDATE APPOINTMENT
    // =========================================================

    public boolean updateAppointment(
            Appointment appointment) {

        if (appointment == null
                || appointment.getAppointmentId() <= 0) {

            return false;
        }

        if (appointment.getPatientId() <= 0
                || appointment.getDentistId() <= 0
                || appointment.getTreatmentId() <= 0) {

            return false;
        }

        if (appointment.getAppointmentDate() == null
                || appointment.getAppointmentTime() == null) {

            return false;
        }

        if (appointment.getStatus() == null
                || appointment.getStatus().trim().isEmpty()) {

            appointment.setStatus(
                    "SCHEDULED"
            );

        } else {

            appointment.setStatus(
                    appointment.getStatus()
                            .trim()
                            .toUpperCase()
            );
        }

        if (appointment.getNotes() != null) {

            appointment.setNotes(
                    appointment.getNotes().trim()
            );
        }

        // -----------------------------------------------------
        // Dentist conflict
        //
        // Exclude current appointment ID.
        // -----------------------------------------------------

        if (!isDentistAvailable(
                appointment.getDentistId(),
                appointment.getAppointmentDate(),
                appointment.getAppointmentTime(),
                appointment.getAppointmentId()
        )) {

            return false;
        }

        // -----------------------------------------------------
        // Patient conflict
        // -----------------------------------------------------

        if (!isPatientAvailable(
                appointment.getPatientId(),
                appointment.getAppointmentDate(),
                appointment.getAppointmentTime(),
                appointment.getAppointmentId()
        )) {

            return false;
        }

        // -----------------------------------------------------
        // Update
        // -----------------------------------------------------

        return appointmentDAO.updateAppointment(
                appointment
        );
    }

    // =========================================================
    // UPDATE APPOINTMENT STATUS / NOTES
    // =========================================================

    public boolean patchAppointment(
            Appointment appointment) {

        if (appointment == null
                || appointment.getAppointmentId() <= 0) {

            return false;
        }

        if (appointment.getStatus() != null) {

            appointment.setStatus(
                    appointment.getStatus()
                            .trim()
                            .toUpperCase()
            );
        }

        if (appointment.getNotes() != null) {

            appointment.setNotes(
                    appointment.getNotes().trim()
            );
        }

        return appointmentDAO.updateAppointment(
                appointment
        );
    }
}
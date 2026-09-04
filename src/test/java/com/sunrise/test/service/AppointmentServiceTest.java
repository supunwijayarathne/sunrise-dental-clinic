package com.sunrise.test.service;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.sunrise.model.Appointment;
import com.sunrise.service.AppointmentService;

class AppointmentServiceTest {

    private AppointmentService appointmentService;

    @BeforeEach
    void setUp() {
        appointmentService = new AppointmentService();
    }

    // =========================================================
    // GET BY ID
    // =========================================================

    @Test
    void getAppointmentByIdShouldReturnNullForInvalidId() {

        assertNull(
                appointmentService.getAppointmentById(0)
        );
    }

    @Test
    void getAppointmentByIdShouldReturnNullForNegativeId() {

        assertNull(
                appointmentService.getAppointmentById(-1)
        );
    }

    // =========================================================
    // SEARCH
    // =========================================================

    @Test
    void searchAppointmentsShouldHandleNullKeyword() {

        assertNotNull(
                appointmentService.searchAppointments(null)
        );
    }

    @Test
    void searchAppointmentsShouldHandleBlankKeyword() {

        assertNotNull(
                appointmentService.searchAppointments("   ")
        );
    }

    // =========================================================
    // PATIENT APPOINTMENTS
    // =========================================================

    @Test
    void getAppointmentsByPatientShouldRejectInvalidId() {

        List<Appointment> result =
                appointmentService.getAppointmentsByPatient(0);

        assertNotNull(result);
        assertTrue(result.isEmpty());
    }

    // =========================================================
    // DENTIST APPOINTMENTS
    // =========================================================

    @Test
    void getAppointmentsByDentistShouldRejectInvalidId() {

        List<Appointment> result =
                appointmentService.getAppointmentsByDentist(0);

        assertNotNull(result);
        assertTrue(result.isEmpty());
    }

    // =========================================================
    // DENTIST AVAILABILITY
    // =========================================================

    @Test
    void dentistAvailabilityShouldRejectInvalidDentistId() {

        assertFalse(
                appointmentService.isDentistAvailable(
                        0,
                        LocalDate.now(),
                        LocalTime.of(10, 0),
                        0
                )
        );
    }

    @Test
    void dentistAvailabilityShouldRejectMissingDate() {

        assertFalse(
                appointmentService.isDentistAvailable(
                        1,
                        null,
                        LocalTime.of(10, 0),
                        0
                )
        );
    }

    @Test
    void dentistAvailabilityShouldRejectMissingTime() {

        assertFalse(
                appointmentService.isDentistAvailable(
                        1,
                        LocalDate.now(),
                        null,
                        0
                )
        );
    }

    // =========================================================
    // PATIENT AVAILABILITY
    // =========================================================

    @Test
    void patientAvailabilityShouldRejectInvalidPatientId() {

        assertFalse(
                appointmentService.isPatientAvailable(
                        0,
                        LocalDate.now(),
                        LocalTime.of(10, 0),
                        0
                )
        );
    }

    @Test
    void patientAvailabilityShouldRejectMissingDate() {

        assertFalse(
                appointmentService.isPatientAvailable(
                        1,
                        null,
                        LocalTime.of(10, 0),
                        0
                )
        );
    }

    @Test
    void patientAvailabilityShouldRejectMissingTime() {

        assertFalse(
                appointmentService.isPatientAvailable(
                        1,
                        LocalDate.now(),
                        null,
                        0
                )
        );
    }

    // =========================================================
    // BOOKED TIMES
    // =========================================================

    @Test
    void getBookedTimesShouldRejectInvalidDentistId() {

        List<LocalTime> result =
                appointmentService.getBookedTimes(
                        0,
                        LocalDate.now(),
                        0
                );

        assertNotNull(result);
        assertTrue(result.isEmpty());
    }

    @Test
    void getBookedTimesShouldRejectMissingDate() {

        List<LocalTime> result =
                appointmentService.getBookedTimes(
                        1,
                        null,
                        0
                );

        assertNotNull(result);
        assertTrue(result.isEmpty());
    }

    // =========================================================
    // DENTIST SCHEDULE
    // =========================================================

    @Test
    void getScheduleShouldRejectInvalidDentistId() {

        List<?> result =
                appointmentService.getSchedulesByDentistAndDay(
                        0,
                        "MONDAY"
                );

        assertNotNull(result);
        assertTrue(result.isEmpty());
    }

    @Test
    void getScheduleShouldRejectMissingDay() {

        List<?> result =
                appointmentService.getSchedulesByDentistAndDay(
                        1,
                        ""
                );

        assertNotNull(result);
        assertTrue(result.isEmpty());
    }

    // =========================================================
    // AVAILABLE SLOTS
    // =========================================================

    @Test
    void getAvailableSlotsShouldRejectInvalidDentistId() {

        List<LocalTime> result =
                appointmentService.getAvailableSlots(
                        0,
                        LocalDate.now()
                );

        assertNotNull(result);
        assertTrue(result.isEmpty());
    }

    @Test
    void getAvailableSlotsShouldRejectMissingDate() {

        List<LocalTime> result =
                appointmentService.getAvailableSlots(
                        1,
                        null
                );

        assertNotNull(result);
        assertTrue(result.isEmpty());
    }

    // =========================================================
    // CREATE
    // =========================================================

    @Test
    void createAppointmentShouldRejectNullAppointment() {

        assertFalse(
                appointmentService.createAppointment(null)
        );
    }

    @Test
    void createAppointmentShouldRejectInvalidPatientId() {

        Appointment appointment =
                new Appointment();

        appointment.setPatientId(0);
        appointment.setDentistId(1);
        appointment.setTreatmentId(1);
        appointment.setAppointmentDate(
                LocalDate.now().plusDays(1)
        );
        appointment.setAppointmentTime(
                LocalTime.of(10, 0)
        );
        appointment.setCreatedBy(1);

        assertFalse(
                appointmentService.createAppointment(
                        appointment
                )
        );
    }

    @Test
    void createAppointmentShouldRejectInvalidDentistId() {

        Appointment appointment =
                new Appointment();

        appointment.setPatientId(1);
        appointment.setDentistId(0);
        appointment.setTreatmentId(1);
        appointment.setAppointmentDate(
                LocalDate.now().plusDays(1)
        );
        appointment.setAppointmentTime(
                LocalTime.of(10, 0)
        );
        appointment.setCreatedBy(1);

        assertFalse(
                appointmentService.createAppointment(
                        appointment
                )
        );
    }

    @Test
    void createAppointmentShouldRejectInvalidTreatmentId() {

        Appointment appointment =
                new Appointment();

        appointment.setPatientId(1);
        appointment.setDentistId(1);
        appointment.setTreatmentId(0);
        appointment.setAppointmentDate(
                LocalDate.now().plusDays(1)
        );
        appointment.setAppointmentTime(
                LocalTime.of(10, 0)
        );
        appointment.setCreatedBy(1);

        assertFalse(
                appointmentService.createAppointment(
                        appointment
                )
        );
    }

    @Test
    void createAppointmentShouldRejectMissingDate() {

        Appointment appointment =
                new Appointment();

        appointment.setPatientId(1);
        appointment.setDentistId(1);
        appointment.setTreatmentId(1);
        appointment.setAppointmentDate(null);
        appointment.setAppointmentTime(
                LocalTime.of(10, 0)
        );
        appointment.setCreatedBy(1);

        assertFalse(
                appointmentService.createAppointment(
                        appointment
                )
        );
    }

    @Test
    void createAppointmentShouldRejectMissingTime() {

        Appointment appointment =
                new Appointment();

        appointment.setPatientId(1);
        appointment.setDentistId(1);
        appointment.setTreatmentId(1);
        appointment.setAppointmentDate(
                LocalDate.now().plusDays(1)
        );
        appointment.setAppointmentTime(null);
        appointment.setCreatedBy(1);

        assertFalse(
                appointmentService.createAppointment(
                        appointment
                )
        );
    }

    @Test
    void createAppointmentShouldRejectInvalidCreator() {

        Appointment appointment =
                new Appointment();

        appointment.setPatientId(1);
        appointment.setDentistId(1);
        appointment.setTreatmentId(1);
        appointment.setAppointmentDate(
                LocalDate.now().plusDays(1)
        );
        appointment.setAppointmentTime(
                LocalTime.of(10, 0)
        );
        appointment.setCreatedBy(0);

        assertFalse(
                appointmentService.createAppointment(
                        appointment
                )
        );
    }

    // =========================================================
    // UPDATE
    // =========================================================

    @Test
    void updateAppointmentShouldRejectNullAppointment() {

        assertFalse(
                appointmentService.updateAppointment(null)
        );
    }

    @Test
    void updateAppointmentShouldRejectInvalidAppointmentId() {

        Appointment appointment =
                new Appointment();

        appointment.setAppointmentId(0);

        assertFalse(
                appointmentService.updateAppointment(
                        appointment
                )
        );
    }

    @Test
    void updateAppointmentShouldRejectInvalidPatientId() {

        Appointment appointment =
                new Appointment();

        appointment.setAppointmentId(1);
        appointment.setPatientId(0);
        appointment.setDentistId(1);
        appointment.setTreatmentId(1);
        appointment.setAppointmentDate(
                LocalDate.now().plusDays(1)
        );
        appointment.setAppointmentTime(
                LocalTime.of(10, 0)
        );

        assertFalse(
                appointmentService.updateAppointment(
                        appointment
                )
        );
    }

    @Test
    void updateAppointmentShouldRejectInvalidDentistId() {

        Appointment appointment =
                new Appointment();

        appointment.setAppointmentId(1);
        appointment.setPatientId(1);
        appointment.setDentistId(0);
        appointment.setTreatmentId(1);
        appointment.setAppointmentDate(
                LocalDate.now().plusDays(1)
        );
        appointment.setAppointmentTime(
                LocalTime.of(10, 0)
        );

        assertFalse(
                appointmentService.updateAppointment(
                        appointment
                )
        );
    }

    @Test
    void updateAppointmentShouldRejectInvalidTreatmentId() {

        Appointment appointment =
                new Appointment();

        appointment.setAppointmentId(1);
        appointment.setPatientId(1);
        appointment.setDentistId(1);
        appointment.setTreatmentId(0);
        appointment.setAppointmentDate(
                LocalDate.now().plusDays(1)
        );
        appointment.setAppointmentTime(
                LocalTime.of(10, 0)
        );

        assertFalse(
                appointmentService.updateAppointment(
                        appointment
                )
        );
    }

    // =========================================================
    // PATCH
    // =========================================================

    @Test
    void patchAppointmentShouldRejectNullAppointment() {

        assertFalse(
                appointmentService.patchAppointment(null)
        );
    }

    @Test
    void patchAppointmentShouldRejectInvalidAppointmentId() {

        Appointment appointment =
                new Appointment();

        appointment.setAppointmentId(0);

        assertFalse(
                appointmentService.patchAppointment(
                        appointment
                )
        );
    }
}
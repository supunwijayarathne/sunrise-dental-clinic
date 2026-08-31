package com.sunrise.test;

import static org.junit.jupiter.api.Assertions.*;

import java.time.LocalDate;
import java.time.LocalTime;

import org.junit.jupiter.api.Test;

import com.sunrise.model.Appointment;

public class AppointmentTest {

    @Test
    public void testAppointmentDetails() {

        Appointment appointment = new Appointment();

        appointment.setAppointmentId(1);
        appointment.setAppointmentNumber("APT-001");
        appointment.setPatientId(1);
        appointment.setDentistId(1);
        appointment.setTreatmentId(1);
        appointment.setAppointmentDate(
                LocalDate.of(2026, 9, 10)
        );
        appointment.setAppointmentTime(
                LocalTime.of(10, 0)
        );
        appointment.setStatus("SCHEDULED");
        appointment.setNotes("Regular appointment");

        assertEquals(1, appointment.getAppointmentId());
        assertEquals("APT-001", appointment.getAppointmentNumber());
        assertEquals(1, appointment.getPatientId());
        assertEquals(1, appointment.getDentistId());
        assertEquals(1, appointment.getTreatmentId());
        assertEquals(
                LocalDate.of(2026, 9, 10),
                appointment.getAppointmentDate()
        );
        assertEquals(
                LocalTime.of(10, 0),
                appointment.getAppointmentTime()
        );
        assertEquals("SCHEDULED", appointment.getStatus());
        assertEquals(
                "Regular appointment",
                appointment.getNotes()
        );
    }
    @Test
    public void testAppointmentStatusUpdate() {

        Appointment appointment = new Appointment();

        appointment.setStatus("SCHEDULED");

        assertEquals(
                "SCHEDULED",
                appointment.getStatus()
        );

        appointment.setStatus("COMPLETED");

        assertEquals(
                "COMPLETED",
                appointment.getStatus()
        );

        appointment.setStatus("CANCELLED");

        assertEquals(
                "CANCELLED",
                appointment.getStatus()
        );
    }
}
package com.sunrise.test.integration;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

import java.time.LocalDate;
import java.time.LocalTime;

import org.junit.jupiter.api.Test;

import com.sunrise.model.Appointment;
import com.sunrise.model.Dentist;
import com.sunrise.model.Patient;
import com.sunrise.model.Treatment;
import com.sunrise.service.EmailService;

/**
 * Safe service tests: blank recipient addresses prevent external SMTP traffic.
 * SMTP delivery itself should be verified separately with a controlled test mailbox.
 */
public class EmailServiceTest {
    @Test
    void bookingEmailServiceHandlesMissingRecipients() {
        Patient patient = new Patient(); patient.setEmail("");
        Dentist dentist = new Dentist(); dentist.setEmail("");
        Treatment treatment = new Treatment(); treatment.setTreatmentName("Dental Cleaning");
        Appointment appointment = new Appointment("APT-SERVICE-TEST",1,1,1,LocalDate.now().plusDays(1),LocalTime.of(10,0),"SCHEDULED","Test",1);
        assertDoesNotThrow(() -> EmailService.sendAppointmentCreatedEmails(appointment,patient,dentist,treatment));
    }

    @Test
    void cancellationEmailServiceHandlesMissingRecipients() {
        Patient patient = new Patient(); patient.setEmail(null);
        Dentist dentist = new Dentist(); dentist.setEmail(null);
        Treatment treatment = new Treatment(); treatment.setTreatmentName("Dental Cleaning");
        Appointment appointment = new Appointment("APT-SERVICE-CANCEL",1,1,1,LocalDate.now().plusDays(1),LocalTime.of(10,0),"CANCELLED","Test",1);
        assertDoesNotThrow(() -> EmailService.sendAppointmentCancelledEmails(appointment,patient,dentist,treatment));
    }
}

package com.sunrise.test;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

import com.sunrise.model.Patient;

public class PatientTest {

    @Test
    public void testPatientCreation() {

        Patient patient = new Patient();

        patient.setPatientId(1);
        patient.setPatientCode("PAT-001");
        patient.setName("Test Patient");
        patient.setAddress("Kurunegala");
        patient.setContactNumber("0771234567");
        patient.setEmail("test@example.com");

        assertEquals(1, patient.getPatientId());
        assertEquals("PAT-001", patient.getPatientCode());
        assertEquals("Test Patient", patient.getName());
        assertEquals("Kurunegala", patient.getAddress());
        assertEquals("0771234567", patient.getContactNumber());
        assertEquals("test@example.com", patient.getEmail());
    }
    @Test
    public void testPatientNameUpdate() {

        Patient patient = new Patient();

        patient.setName("John Silva");

        assertEquals("John Silva", patient.getName());

        patient.setName("Kamal Perera");

        assertEquals("Kamal Perera", patient.getName());
    }
}
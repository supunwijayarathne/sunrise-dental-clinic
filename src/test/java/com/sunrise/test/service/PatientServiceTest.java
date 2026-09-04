package com.sunrise.test.service;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.sunrise.model.Patient;
import com.sunrise.service.PatientService;

class PatientServiceTest {

    private PatientService patientService;

    @BeforeEach
    void setUp() {
        patientService = new PatientService();
    }

    // =========================================================
    // CREATE PATIENT TESTS
    // =========================================================

    @Test
    void createPatientShouldRejectNullPatient() {

        boolean result =
                patientService.createPatient(null);

        assertFalse(result);
    }

    @Test
    void createPatientShouldRejectMissingPatientCode() {

        Patient patient = new Patient();

        patient.setPatientCode("");
        patient.setName("Test Patient");
        patient.setAddress("Test Address");
        patient.setContactNumber("0771234567");

        boolean result =
                patientService.createPatient(patient);

        assertFalse(result);
    }

    @Test
    void createPatientShouldRejectMissingPatientName() {

        Patient patient = new Patient();

        patient.setPatientCode("TEST-SERVICE-001");
        patient.setName("");
        patient.setAddress("Test Address");
        patient.setContactNumber("0771234567");

        boolean result =
                patientService.createPatient(patient);

        assertFalse(result);
    }

    @Test
    void createPatientShouldRejectMissingAddress() {

        Patient patient = new Patient();

        patient.setPatientCode("TEST-SERVICE-002");
        patient.setName("Test Patient");
        patient.setAddress("");
        patient.setContactNumber("0771234567");

        boolean result =
                patientService.createPatient(patient);

        assertFalse(result);
    }

    @Test
    void createPatientShouldRejectMissingContactNumber() {

        Patient patient = new Patient();

        patient.setPatientCode("TEST-SERVICE-003");
        patient.setName("Test Patient");
        patient.setAddress("Test Address");
        patient.setContactNumber("");

        boolean result =
                patientService.createPatient(patient);

        assertFalse(result);
    }

    // =========================================================
    // UPDATE PATIENT TESTS
    // =========================================================

    @Test
    void updatePatientShouldRejectNullPatient() {

        boolean result =
                patientService.updatePatient(null);

        assertFalse(result);
    }

    @Test
    void updatePatientShouldRejectInvalidPatientId() {

        Patient patient = new Patient();

        patient.setPatientId(0);
        patient.setName("Test Patient");
        patient.setAddress("Test Address");
        patient.setContactNumber("0771234567");

        boolean result =
                patientService.updatePatient(patient);

        assertFalse(result);
    }

    @Test
    void updatePatientShouldRejectMissingName() {

        Patient patient = new Patient();

        patient.setPatientId(1);
        patient.setName("");
        patient.setAddress("Test Address");
        patient.setContactNumber("0771234567");

        boolean result =
                patientService.updatePatient(patient);

        assertFalse(result);
    }

    @Test
    void updatePatientShouldRejectMissingAddress() {

        Patient patient = new Patient();

        patient.setPatientId(1);
        patient.setName("Test Patient");
        patient.setAddress("");
        patient.setContactNumber("0771234567");

        boolean result =
                patientService.updatePatient(patient);

        assertFalse(result);
    }

    @Test
    void updatePatientShouldRejectMissingContactNumber() {

        Patient patient = new Patient();

        patient.setPatientId(1);
        patient.setName("Test Patient");
        patient.setAddress("Test Address");
        patient.setContactNumber("");

        boolean result =
                patientService.updatePatient(patient);

        assertFalse(result);
    }

    // =========================================================
    // GET PATIENT BY ID TESTS
    // =========================================================

    @Test
    void getPatientByIdShouldRejectInvalidId() {

        Patient result =
                patientService.getPatientById(0);

        assertTrue(result == null);
    }

    @Test
    void getPatientByIdShouldRejectNegativeId() {

        Patient result =
                patientService.getPatientById(-1);

        assertTrue(result == null);
    }
}
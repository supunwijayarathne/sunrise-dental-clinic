package com.sunrise.service;

import java.util.List;

import com.sunrise.dao.PatientDAO;
import com.sunrise.model.Patient;

public class PatientService {

    private final PatientDAO patientDAO;

    // =========================================================
    // CONSTRUCTOR
    // =========================================================

    public PatientService() {
        patientDAO = new PatientDAO();
    }


    // =========================================================
    // GET ALL PATIENTS
    // =========================================================

    public List<Patient> getAllPatients() {

        return patientDAO.getAllPatients();
    }


    // =========================================================
    // GET PATIENT BY ID
    // =========================================================

    public Patient getPatientById(int patientId) {

        if (patientId <= 0) {
            return null;
        }

        return patientDAO.getPatientById(patientId);
    }


    // =========================================================
    // SEARCH PATIENTS
    // =========================================================

    public List<Patient> searchPatients(String keyword) {

        if (keyword == null || keyword.trim().isEmpty()) {
            return patientDAO.getAllPatients();
        }

        return patientDAO.searchPatients(
                keyword.trim()
        );
    }


    // =========================================================
    // CREATE PATIENT
    // =========================================================

    public boolean createPatient(Patient patient) {

        if (patient == null) {
            return false;
        }

        // -----------------------------
        // Required fields
        // -----------------------------

        if (isBlank(patient.getPatientCode())) {
            return false;
        }

        if (isBlank(patient.getName())) {
            return false;
        }

        if (isBlank(patient.getAddress())) {
            return false;
        }

        if (isBlank(patient.getContactNumber())) {
            return false;
        }

        // -----------------------------
        // Clean input
        // -----------------------------

        patient.setPatientCode(
                patient.getPatientCode().trim()
        );

        patient.setName(
                patient.getName().trim()
        );

        patient.setAddress(
                patient.getAddress().trim()
        );

        patient.setContactNumber(
                patient.getContactNumber().trim()
        );

        if (patient.getEmail() != null) {

            patient.setEmail(
                    patient.getEmail().trim()
            );

            if (patient.getEmail().isEmpty()) {
                patient.setEmail(null);
            }
        }

        // -----------------------------
        // Save
        // -----------------------------

        return patientDAO.addPatient(patient);
    }


    // =========================================================
    // UPDATE PATIENT
    // =========================================================

    public boolean updatePatient(Patient patient) {

        if (patient == null) {
            return false;
        }

        if (patient.getPatientId() <= 0) {
            return false;
        }

        // -----------------------------
        // Required fields
        // -----------------------------

        if (isBlank(patient.getName())) {
            return false;
        }

        if (isBlank(patient.getAddress())) {
            return false;
        }

        if (isBlank(patient.getContactNumber())) {
            return false;
        }

        // -----------------------------
        // Clean input
        // -----------------------------

        patient.setName(
                patient.getName().trim()
        );

        patient.setAddress(
                patient.getAddress().trim()
        );

        patient.setContactNumber(
                patient.getContactNumber().trim()
        );

        if (patient.getEmail() != null) {

            patient.setEmail(
                    patient.getEmail().trim()
            );

            if (patient.getEmail().isEmpty()) {
                patient.setEmail(null);
            }
        }

        // -----------------------------
        // Save
        // -----------------------------

        return patientDAO.updatePatient(patient);
    }


    // =========================================================
    // VALIDATION HELPER
    // =========================================================

    private boolean isBlank(String value) {

        return value == null
                || value.trim().isEmpty();
    }
}
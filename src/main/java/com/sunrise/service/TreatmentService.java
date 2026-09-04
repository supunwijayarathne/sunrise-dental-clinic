package com.sunrise.service;

import java.util.List;

import com.sunrise.dao.TreatmentDAO;
import com.sunrise.model.Treatment;

public class TreatmentService {

    private final TreatmentDAO treatmentDAO;


    // =========================================================
    // CONSTRUCTOR
    // =========================================================

    public TreatmentService() {

        treatmentDAO = new TreatmentDAO();
    }


    // =========================================================
    // GET ALL TREATMENTS
    // =========================================================

    public List<Treatment> getAllTreatments() {

        return treatmentDAO.getAllTreatments();
    }


    // =========================================================
    // GET TREATMENT BY ID
    // =========================================================

    public Treatment getTreatmentById(int treatmentId) {

        if (treatmentId <= 0) {
            return null;
        }

        return treatmentDAO.getTreatmentById(treatmentId);
    }


    // =========================================================
    // SEARCH TREATMENTS
    // =========================================================

    public List<Treatment> searchTreatments(String keyword) {

        if (keyword == null || keyword.trim().isEmpty()) {

            return treatmentDAO.getAllTreatments();
        }

        return treatmentDAO.searchTreatments(
                keyword.trim()
        );
    }


    // =========================================================
    // GET ACTIVE TREATMENTS
    // =========================================================

    public List<Treatment> getActiveTreatments() {

        return treatmentDAO.getActiveTreatments();
    }


    // =========================================================
    // CREATE TREATMENT
    // =========================================================

    public boolean createTreatment(Treatment treatment) {

        if (treatment == null) {
            return false;
        }


        // -----------------------------------------------------
        // Required fields
        // -----------------------------------------------------

        if (isBlank(treatment.getTreatmentName())) {
            return false;
        }


        // -----------------------------------------------------
        // Treatment fee validation
        // -----------------------------------------------------

        if (treatment.getTreatmentFee() < 0) {
            return false;
        }


        // -----------------------------------------------------
        // Clean treatment name
        // -----------------------------------------------------

        treatment.setTreatmentName(
                treatment.getTreatmentName().trim()
        );


        // -----------------------------------------------------
        // Clean description
        // -----------------------------------------------------

        if (treatment.getDescription() != null) {

            treatment.setDescription(
                    treatment.getDescription().trim()
            );

            if (treatment.getDescription().isEmpty()) {
                treatment.setDescription(null);
            }
        }


        // -----------------------------------------------------
        // Save
        // -----------------------------------------------------

        return treatmentDAO.addTreatment(treatment);
    }


    // =========================================================
    // UPDATE TREATMENT
    // =========================================================

    public boolean updateTreatment(Treatment treatment) {

        if (treatment == null) {
            return false;
        }


        // -----------------------------------------------------
        // Validate ID
        // -----------------------------------------------------

        if (treatment.getTreatmentId() <= 0) {
            return false;
        }


        // -----------------------------------------------------
        // Required fields
        // -----------------------------------------------------

        if (isBlank(treatment.getTreatmentName())) {
            return false;
        }


        // -----------------------------------------------------
        // Treatment fee validation
        // -----------------------------------------------------

        if (treatment.getTreatmentFee() < 0) {
            return false;
        }


        // -----------------------------------------------------
        // Clean treatment name
        // -----------------------------------------------------

        treatment.setTreatmentName(
                treatment.getTreatmentName().trim()
        );


        // -----------------------------------------------------
        // Clean description
        // -----------------------------------------------------

        if (treatment.getDescription() != null) {

            treatment.setDescription(
                    treatment.getDescription().trim()
            );

            if (treatment.getDescription().isEmpty()) {
                treatment.setDescription(null);
            }
        }


        // -----------------------------------------------------
        // Update
        // -----------------------------------------------------

        return treatmentDAO.updateTreatment(treatment);
    }


    // =========================================================
    // VALIDATION HELPER
    // =========================================================

    private boolean isBlank(String value) {

        return value == null
                || value.trim().isEmpty();
    }
}
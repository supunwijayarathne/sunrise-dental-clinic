package com.sunrise.service;

import java.util.List;

import com.sunrise.dao.DentistDAO;
import com.sunrise.model.Dentist;

public class DentistService {

    private final DentistDAO dentistDAO;


    // =========================================================
    // CONSTRUCTOR
    // =========================================================

    public DentistService() {

        dentistDAO = new DentistDAO();
    }


    // =========================================================
    // GET ALL DENTISTS
    // =========================================================

    public List<Dentist> getAllDentists() {

        return dentistDAO.getAllDentists();
    }


    // =========================================================
    // GET DENTIST BY ID
    // =========================================================

    public Dentist getDentistById(int dentistId) {

        if (dentistId <= 0) {
            return null;
        }

        return dentistDAO.getDentistById(dentistId);
    }


    // =========================================================
    // SEARCH DENTISTS
    // =========================================================

    public List<Dentist> searchDentists(String keyword) {

        if (keyword == null || keyword.trim().isEmpty()) {

            return dentistDAO.getAllDentists();
        }

        return dentistDAO.searchDentists(
                keyword.trim()
        );
    }


    // =========================================================
    // GET ACTIVE DENTISTS
    // =========================================================

    public List<Dentist> getActiveDentists() {

        return dentistDAO.getActiveDentists();
    }


    // =========================================================
    // CREATE DENTIST
    // =========================================================

    public boolean createDentist(Dentist dentist) {

        if (dentist == null) {
            return false;
        }


        // -----------------------------------------------------
        // Required fields
        // -----------------------------------------------------

        if (isBlank(dentist.getDentistName())) {
            return false;
        }

        if (isBlank(dentist.getSpecialization())) {
            return false;
        }


        // -----------------------------------------------------
        // Consultation fee validation
        // -----------------------------------------------------

        if (dentist.getConsultationFee() < 0) {
            return false;
        }


        // -----------------------------------------------------
        // Clean text values
        // -----------------------------------------------------

        dentist.setDentistName(
                dentist.getDentistName().trim()
        );

        dentist.setSpecialization(
                dentist.getSpecialization().trim()
        );


        if (dentist.getPhoneNumber() != null) {

            dentist.setPhoneNumber(
                    dentist.getPhoneNumber().trim()
            );

            if (dentist.getPhoneNumber().isEmpty()) {
                dentist.setPhoneNumber(null);
            }
        }


        if (dentist.getEmail() != null) {

            dentist.setEmail(
                    dentist.getEmail().trim()
            );

            if (dentist.getEmail().isEmpty()) {
                dentist.setEmail(null);
            }
        }


        // -----------------------------------------------------
        // Save
        // -----------------------------------------------------

        return dentistDAO.addDentist(dentist);
    }


    // =========================================================
    // UPDATE DENTIST
    // =========================================================

    public boolean updateDentist(Dentist dentist) {

        if (dentist == null) {
            return false;
        }


        // -----------------------------------------------------
        // Validate ID
        // -----------------------------------------------------

        if (dentist.getDentistId() <= 0) {
            return false;
        }


        // -----------------------------------------------------
        // Required fields
        // -----------------------------------------------------

        if (isBlank(dentist.getDentistName())) {
            return false;
        }

        if (isBlank(dentist.getSpecialization())) {
            return false;
        }


        // -----------------------------------------------------
        // Consultation fee validation
        // -----------------------------------------------------

        if (dentist.getConsultationFee() < 0) {
            return false;
        }


        // -----------------------------------------------------
        // Clean text values
        // -----------------------------------------------------

        dentist.setDentistName(
                dentist.getDentistName().trim()
        );

        dentist.setSpecialization(
                dentist.getSpecialization().trim()
        );


        if (dentist.getPhoneNumber() != null) {

            dentist.setPhoneNumber(
                    dentist.getPhoneNumber().trim()
            );

            if (dentist.getPhoneNumber().isEmpty()) {
                dentist.setPhoneNumber(null);
            }
        }


        if (dentist.getEmail() != null) {

            dentist.setEmail(
                    dentist.getEmail().trim()
            );

            if (dentist.getEmail().isEmpty()) {
                dentist.setEmail(null);
            }
        }


        // -----------------------------------------------------
        // Update
        // -----------------------------------------------------

        return dentistDAO.updateDentist(dentist);
    }


    // =========================================================
    // VALIDATION HELPER
    // =========================================================

    private boolean isBlank(String value) {

        return value == null
                || value.trim().isEmpty();
    }
}
package com.sunrise.test.service;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.sunrise.model.Dentist;
import com.sunrise.service.DentistService;

class DentistServiceTest {

    private DentistService dentistService;

    @BeforeEach
    void setUp() {
        dentistService = new DentistService();
    }

    // =========================================================
    // GET DENTIST BY ID
    // =========================================================

    @Test
    void getDentistByIdShouldReturnNullForInvalidId() {

        Dentist result =
                dentistService.getDentistById(0);

        assertNull(result);
    }

    @Test
    void getDentistByIdShouldReturnNullForNegativeId() {

        Dentist result =
                dentistService.getDentistById(-1);

        assertNull(result);
    }


    // =========================================================
    // SEARCH DENTISTS
    // =========================================================

    @Test
    void searchDentistsShouldHandleNullKeyword() {

        List<Dentist> result =
                dentistService.searchDentists(null);

        assertNotNull(result);
    }

    @Test
    void searchDentistsShouldHandleBlankKeyword() {

        List<Dentist> result =
                dentistService.searchDentists("   ");

        assertNotNull(result);
    }


    // =========================================================
    // CREATE DENTIST
    // =========================================================

    @Test
    void createDentistShouldRejectNullDentist() {

        boolean result =
                dentistService.createDentist(null);

        assertFalse(result);
    }

    @Test
    void createDentistShouldRejectMissingDentistName() {

        Dentist dentist = new Dentist();

        dentist.setDentistName("");
        dentist.setSpecialization("General Dentistry");
        dentist.setConsultationFee(2500);

        boolean result =
                dentistService.createDentist(dentist);

        assertFalse(result);
    }

    @Test
    void createDentistShouldRejectMissingSpecialization() {

        Dentist dentist = new Dentist();

        dentist.setDentistName("Test Dentist");
        dentist.setSpecialization("");
        dentist.setConsultationFee(2500);

        boolean result =
                dentistService.createDentist(dentist);

        assertFalse(result);
    }

    @Test
    void createDentistShouldRejectNegativeConsultationFee() {

        Dentist dentist = new Dentist();

        dentist.setDentistName("Test Dentist");
        dentist.setSpecialization("General Dentistry");
        dentist.setConsultationFee(-100);

        boolean result =
                dentistService.createDentist(dentist);

        assertFalse(result);
    }


    // =========================================================
    // UPDATE DENTIST
    // =========================================================

    @Test
    void updateDentistShouldRejectNullDentist() {

        boolean result =
                dentistService.updateDentist(null);

        assertFalse(result);
    }

    @Test
    void updateDentistShouldRejectInvalidDentistId() {

        Dentist dentist = new Dentist();

        dentist.setDentistId(0);
        dentist.setDentistName("Test Dentist");
        dentist.setSpecialization("General Dentistry");
        dentist.setConsultationFee(2500);

        boolean result =
                dentistService.updateDentist(dentist);

        assertFalse(result);
    }

    @Test
    void updateDentistShouldRejectMissingDentistName() {

        Dentist dentist = new Dentist();

        dentist.setDentistId(1);
        dentist.setDentistName("");
        dentist.setSpecialization("General Dentistry");
        dentist.setConsultationFee(2500);

        boolean result =
                dentistService.updateDentist(dentist);

        assertFalse(result);
    }

    @Test
    void updateDentistShouldRejectMissingSpecialization() {

        Dentist dentist = new Dentist();

        dentist.setDentistId(1);
        dentist.setDentistName("Test Dentist");
        dentist.setSpecialization("");
        dentist.setConsultationFee(2500);

        boolean result =
                dentistService.updateDentist(dentist);

        assertFalse(result);
    }

    @Test
    void updateDentistShouldRejectNegativeConsultationFee() {

        Dentist dentist = new Dentist();

        dentist.setDentistId(1);
        dentist.setDentistName("Test Dentist");
        dentist.setSpecialization("General Dentistry");
        dentist.setConsultationFee(-100);

        boolean result =
                dentistService.updateDentist(dentist);

        assertFalse(result);
    }


    // =========================================================
    // ACTIVE DENTISTS
    // =========================================================

    @Test
    void getActiveDentistsShouldReturnNonNullList() {

        List<Dentist> result =
                dentistService.getActiveDentists();

        assertNotNull(result);
    }


    // =========================================================
    // ALL DENTISTS
    // =========================================================

    @Test
    void getAllDentistsShouldReturnNonNullList() {

        List<Dentist> result =
                dentistService.getAllDentists();

        assertNotNull(result);
    }
}
package com.sunrise.test.service;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.sunrise.model.Treatment;
import com.sunrise.service.TreatmentService;

class TreatmentServiceTest {

    private TreatmentService treatmentService;

    @BeforeEach
    void setUp() {
        treatmentService = new TreatmentService();
    }

    // =========================================================
    // GET TREATMENT BY ID
    // =========================================================

    @Test
    void getTreatmentByIdShouldReturnNullForInvalidId() {

        Treatment result =
                treatmentService.getTreatmentById(0);

        assertNull(result);
    }

    @Test
    void getTreatmentByIdShouldReturnNullForNegativeId() {

        Treatment result =
                treatmentService.getTreatmentById(-1);

        assertNull(result);
    }


    // =========================================================
    // SEARCH TREATMENTS
    // =========================================================

    @Test
    void searchTreatmentsShouldHandleNullKeyword() {

        List<Treatment> result =
                treatmentService.searchTreatments(null);

        assertNotNull(result);
    }

    @Test
    void searchTreatmentsShouldHandleBlankKeyword() {

        List<Treatment> result =
                treatmentService.searchTreatments("   ");

        assertNotNull(result);
    }


    // =========================================================
    // CREATE TREATMENT
    // =========================================================

    @Test
    void createTreatmentShouldRejectNullTreatment() {

        boolean result =
                treatmentService.createTreatment(null);

        assertFalse(result);
    }

    @Test
    void createTreatmentShouldRejectMissingTreatmentName() {

        Treatment treatment = new Treatment();

        treatment.setTreatmentName("");
        treatment.setTreatmentFee(2500);

        boolean result =
                treatmentService.createTreatment(treatment);

        assertFalse(result);
    }

    @Test
    void createTreatmentShouldRejectNegativeTreatmentFee() {

        Treatment treatment = new Treatment();

        treatment.setTreatmentName("Test Treatment");
        treatment.setTreatmentFee(-100);

        boolean result =
                treatmentService.createTreatment(treatment);

        assertFalse(result);
    }


    // =========================================================
    // UPDATE TREATMENT
    // =========================================================

    @Test
    void updateTreatmentShouldRejectNullTreatment() {

        boolean result =
                treatmentService.updateTreatment(null);

        assertFalse(result);
    }

    @Test
    void updateTreatmentShouldRejectInvalidTreatmentId() {

        Treatment treatment = new Treatment();

        treatment.setTreatmentId(0);
        treatment.setTreatmentName("Test Treatment");
        treatment.setTreatmentFee(2500);

        boolean result =
                treatmentService.updateTreatment(treatment);

        assertFalse(result);
    }

    @Test
    void updateTreatmentShouldRejectMissingTreatmentName() {

        Treatment treatment = new Treatment();

        treatment.setTreatmentId(1);
        treatment.setTreatmentName("");
        treatment.setTreatmentFee(2500);

        boolean result =
                treatmentService.updateTreatment(treatment);

        assertFalse(result);
    }

    @Test
    void updateTreatmentShouldRejectNegativeTreatmentFee() {

        Treatment treatment = new Treatment();

        treatment.setTreatmentId(1);
        treatment.setTreatmentName("Test Treatment");
        treatment.setTreatmentFee(-100);

        boolean result =
                treatmentService.updateTreatment(treatment);

        assertFalse(result);
    }


    // =========================================================
    // GET ALL TREATMENTS
    // =========================================================

    @Test
    void getAllTreatmentsShouldReturnNonNullList() {

        List<Treatment> result =
                treatmentService.getAllTreatments();

        assertNotNull(result);
    }


    // =========================================================
    // GET ACTIVE TREATMENTS
    // =========================================================

    @Test
    void getActiveTreatmentsShouldReturnNonNullList() {

        List<Treatment> result =
                treatmentService.getActiveTreatments();

        assertNotNull(result);
    }
}
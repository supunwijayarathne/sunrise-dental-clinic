package com.sunrise.test;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import com.sunrise.model.Treatment;

public class TreatmentTest {

    @Test
    public void testTreatmentCreation() {

        Treatment treatment = new Treatment();

        treatment.setTreatmentId(1);
        treatment.setTreatmentName("Dental Cleaning");
        treatment.setDescription("Professional dental cleaning");
        treatment.setTreatmentFee(5000.00);
        treatment.setActive(true);

        assertEquals(1, treatment.getTreatmentId());
        assertEquals("Dental Cleaning", treatment.getTreatmentName());
        assertEquals(
                "Professional dental cleaning",
                treatment.getDescription()
        );
        assertEquals(5000.00, treatment.getTreatmentFee());
        assertTrue(treatment.isActive());
    }
}
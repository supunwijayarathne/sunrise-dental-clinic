package com.sunrise.test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import com.sunrise.model.Dentist;

public class DentistTest {

    @Test
    public void testDentistCreation() {

        Dentist dentist = new Dentist();

        dentist.setDentistId(1);
        dentist.setDentistName("Dr. Test Dentist");
        dentist.setSpecialization("General Dentistry");
        dentist.setConsultationFee(2500.00);
        dentist.setPhoneNumber("0771234567");
        dentist.setEmail("dentist@example.com");
        dentist.setActive(true);

        assertEquals(1, dentist.getDentistId());
        assertEquals("Dr. Test Dentist", dentist.getDentistName());
        assertEquals("General Dentistry", dentist.getSpecialization());
        assertEquals(2500.00, dentist.getConsultationFee());
        assertEquals("0771234567", dentist.getPhoneNumber());
        assertEquals("dentist@example.com", dentist.getEmail());
        assertTrue(dentist.isActive());
    }
    @Test
    public void testDentistFeeAndStatus() {

        Dentist dentist = new Dentist();

        dentist.setConsultationFee(3000.00);
        dentist.setActive(false);

        assertEquals(3000.00, dentist.getConsultationFee());
        assertFalse(dentist.isActive());

        dentist.setActive(true);

        assertTrue(dentist.isActive());
    }
}
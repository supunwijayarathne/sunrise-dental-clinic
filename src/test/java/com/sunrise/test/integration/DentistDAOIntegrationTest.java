package com.sunrise.test.integration;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;
import org.junit.jupiter.api.*;
import com.sunrise.dao.DentistDAO;
import com.sunrise.model.Dentist;

public class DentistDAOIntegrationTest {
    private final DentistDAO dao = new DentistDAO();
    private int id;
    private String name;

    @BeforeEach void setUp() throws Exception {
        DatabaseTestSupport.requireDatabase();
        name = DatabaseTestSupport.unique("Test Dentist");
        Dentist d = new Dentist(); d.setDentistName(name); d.setSpecialization("General Dentistry");
        d.setConsultationFee(2500); d.setPhoneNumber("0711111111"); d.setEmail(name.replace(" ", "").toLowerCase()+"@example.com"); d.setActive(true);
        assertTrue(dao.addDentist(d));
        id = DatabaseTestSupport.queryInt("SELECT dentist_id FROM dentists WHERE dentist_name = ?", name);
    }

    @AfterEach void tearDown() throws Exception { DatabaseTestSupport.execute("DELETE FROM dentist_schedules WHERE dentist_id = ?", id); DatabaseTestSupport.execute("DELETE FROM dentists WHERE dentist_id = ?", id); }

    @Test void addGetAllAndGetById() {
        Dentist d = dao.getDentistById(id); assertNotNull(d); assertEquals(name, d.getDentistName()); assertEquals(2500, d.getConsultationFee());
        assertTrue(dao.getAllDentists().stream().anyMatch(x -> x.getDentistId() == id));
    }

    @Test void updateDentist() {
        Dentist d = dao.getDentistById(id); d.setSpecialization("Orthodontics"); d.setConsultationFee(3500); d.setPhoneNumber("0722222222"); d.setEmail("updated.dentist@example.com"); d.setActive(false);
        assertTrue(dao.updateDentist(d));
        Dentist updated = dao.getDentistById(id); assertEquals("Orthodontics", updated.getSpecialization()); assertEquals(3500, updated.getConsultationFee()); assertFalse(updated.isActive());
    }

    @Test void searchDentists() {
        List<Dentist> result = dao.searchDentists(name.substring(0, Math.min(8, name.length())));
        assertTrue(result.stream().anyMatch(x -> x.getDentistId() == id));
    }

    @Test void activeDentistsIncludesActiveRecord() { assertTrue(dao.getActiveDentists().stream().anyMatch(x -> x.getDentistId() == id)); }

    @Test void missingDentistReturnsNull() { assertNull(dao.getDentistById(Integer.MAX_VALUE)); }
}

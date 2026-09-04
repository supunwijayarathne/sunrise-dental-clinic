package com.sunrise.test.integration;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import org.junit.jupiter.api.*;

import com.sunrise.dao.PatientDAO;
import com.sunrise.model.Patient;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class PatientDAOIntegrationTest {
    private final PatientDAO dao = new PatientDAO();
    private String code;
    private int id;

    @BeforeEach
    void setUp() throws Exception {
        DatabaseTestSupport.requireDatabase();
        code = DatabaseTestSupport.unique("TST-PAT");
        Patient p = patient(code, "Test Patient " + code);
        assertTrue(dao.addPatient(p));
        id = DatabaseTestSupport.queryInt("SELECT patient_id FROM patients WHERE patient_code = ?", code);
        assertTrue(id > 0);
    }

    @AfterEach
    void tearDown() throws Exception {
        DatabaseTestSupport.execute("DELETE FROM patients WHERE patient_id = ?", id);
    }

    @Test @Order(1)
    void addAndFindPatient() {
        Patient p = dao.getPatientById(id);
        assertNotNull(p);
        assertEquals(code, p.getPatientCode());
        assertTrue(p.getName().startsWith("Test Patient"));
    }

    @Test @Order(2)
    void getAllPatientsContainsInsertedPatient() {
        assertTrue(dao.getAllPatients().stream().anyMatch(p -> code.equals(p.getPatientCode())));
    }

    @Test @Order(3)
    void updatePatient() {
        Patient p = dao.getPatientById(id);
        p.setName("Updated Patient");
        p.setAddress("Updated Address");
        p.setContactNumber("0710000000");
        p.setEmail("updated.patient@example.com");
        assertTrue(dao.updatePatient(p));
        Patient updated = dao.getPatientById(id);
        assertEquals("Updated Patient", updated.getName());
        assertEquals("Updated Address", updated.getAddress());
        assertEquals("0710000000", updated.getContactNumber());
        assertEquals("updated.patient@example.com", updated.getEmail());
    }

    @Test @Order(4)
    void searchPatientsFindsByCodeAndName() {
        List<Patient> byCode = dao.searchPatients(code);
        assertTrue(byCode.stream().anyMatch(p -> code.equals(p.getPatientCode())));
        List<Patient> byName = dao.searchPatients("Test Patient");
        assertTrue(byName.stream().anyMatch(p -> code.equals(p.getPatientCode())));
    }

    @Test @Order(5)
    void missingPatientReturnsNull() {
        assertNull(dao.getPatientById(Integer.MAX_VALUE));
    }

    private static Patient patient(String code, String name) {
        Patient p = new Patient();
        p.setPatientCode(code); p.setName(name); p.setAddress("Test Address");
        p.setContactNumber("0700000000"); p.setEmail("test.patient@example.com");
        return p;
    }
}

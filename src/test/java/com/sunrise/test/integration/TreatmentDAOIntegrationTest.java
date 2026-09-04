package com.sunrise.test.integration;

import static org.junit.jupiter.api.Assertions.*;
import java.util.List;
import org.junit.jupiter.api.*;
import com.sunrise.dao.TreatmentDAO;
import com.sunrise.model.Treatment;

public class TreatmentDAOIntegrationTest {
    private final TreatmentDAO dao = new TreatmentDAO();
    private int id; private String name;

    @BeforeEach void setUp() throws Exception {
        DatabaseTestSupport.requireDatabase(); name = DatabaseTestSupport.unique("Test Treatment");
        Treatment t = new Treatment(); t.setTreatmentName(name); t.setDescription("Integration test treatment"); t.setTreatmentFee(5000); t.setActive(true);
        assertTrue(dao.addTreatment(t)); id = DatabaseTestSupport.queryInt("SELECT treatment_id FROM treatments WHERE treatment_name = ?", name);
    }
    @AfterEach void tearDown() throws Exception { DatabaseTestSupport.execute("DELETE FROM treatments WHERE treatment_id = ?", id); }

    @Test void addGetAllAndGetById() { Treatment t=dao.getTreatmentById(id); assertNotNull(t); assertEquals(name,t.getTreatmentName()); assertEquals(5000,t.getTreatmentFee()); assertTrue(dao.getAllTreatments().stream().anyMatch(x->x.getTreatmentId()==id)); }
    @Test void updateTreatment() { Treatment t=dao.getTreatmentById(id); t.setDescription("Updated description"); t.setTreatmentFee(6500); t.setActive(false); assertTrue(dao.updateTreatment(t)); Treatment u=dao.getTreatmentById(id); assertEquals("Updated description",u.getDescription()); assertEquals(6500,u.getTreatmentFee()); assertFalse(u.isActive()); }
    @Test void searchTreatments() { List<Treatment> r=dao.searchTreatments(name.substring(0,Math.min(8,name.length()))); assertTrue(r.stream().anyMatch(x->x.getTreatmentId()==id)); }
    @Test void activeTreatmentsIncludesActiveRecord() { assertTrue(dao.getActiveTreatments().stream().anyMatch(x->x.getTreatmentId()==id)); }
    @Test void missingTreatmentReturnsNull() { assertNull(dao.getTreatmentById(Integer.MAX_VALUE)); }
}

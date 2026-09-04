package com.sunrise.test.integration;

import static org.junit.jupiter.api.Assertions.*;
import java.util.List;
import org.junit.jupiter.api.*;
import com.sunrise.dao.UserDAO;
import com.sunrise.model.User;

public class UserDAOIntegrationTest {
    private final UserDAO dao = new UserDAO();
    private int id; private String username;

    @BeforeEach void setUp() throws Exception {
        DatabaseTestSupport.requireDatabase(); username=DatabaseTestSupport.unique("testuser");
        User u=user(username); assertTrue(dao.addUser(u)); id=DatabaseTestSupport.queryInt("SELECT user_id FROM users WHERE username = ?", username); assertTrue(id>0);
    }
    @AfterEach void tearDown() throws Exception { DatabaseTestSupport.execute("DELETE FROM users WHERE user_id = ?", id); }

    @Test void loginValidAndInvalidCredentials() { User ok=dao.login(username,"test-password"); assertNotNull(ok); assertEquals(id,ok.getUserId()); assertNull(dao.login(username,"wrong-password")); }
    @Test void addAndGetUsers() { assertNotNull(dao.getUserById(id)); assertTrue(dao.getAllUsers().stream().anyMatch(x->x.getUserId()==id)); }
    @Test void updateUser() { User u=dao.getUserById(id); u.setFullName("Updated User"); u.setEmail("updated.user@example.com"); u.setPhone("0733333333"); u.setAddress("Updated Address"); u.setPosition("Updated Position"); u.setRole("ADMIN"); assertTrue(dao.updateUser(u)); User x=dao.getUserById(id); assertEquals("Updated User",x.getFullName()); assertEquals("ADMIN",x.getRole()); }
    @Test void updateReceptionistForcesRole() { User u=dao.getUserById(id); assertTrue(dao.updateReceptionist(u)); assertEquals("RECEPTIONIST",dao.getUserById(id).getRole()); }
    @Test void addReceptionistForcesRole() throws Exception { String un=DatabaseTestSupport.unique("receptionist"); User u=user(un); assertTrue(dao.addReceptionist(u)); int rid=DatabaseTestSupport.queryInt("SELECT user_id FROM users WHERE username=?",un); try { assertEquals("RECEPTIONIST",dao.getUserById(rid).getRole()); assertTrue(dao.getAllReceptionists().stream().anyMatch(x->x.getUserId()==rid)); } finally { DatabaseTestSupport.execute("DELETE FROM users WHERE user_id=?",rid); } }
    @Test void usernameExistsAndCount() { assertTrue(dao.usernameExists(username)); assertFalse(dao.usernameExists(username+"-missing")); assertTrue(dao.getReceptionistCount()>=0); }
    @Test void statusAndFirstLoginUpdates() { assertTrue(dao.updateStatus(id,false)); assertNull(dao.login(username,"test-password")); assertTrue(dao.updateStatus(id,true)); assertNotNull(dao.login(username,"test-password")); assertTrue(dao.markFirstLoginCompleted(id)); assertFalse(dao.getUserById(id).isFirstLogin()); }
    @Test void missingUserReturnsNull() { assertNull(dao.getUserById(Integer.MAX_VALUE)); }

    private static User user(String username) { User u=new User(); u.setFullName("Test User"); u.setEmail(username+"@example.com"); u.setPhone("0700000000"); u.setAddress("Test Address"); u.setPosition("Receptionist"); u.setUsername(username); u.setPasswordHash("test-password"); u.setRole("RECEPTIONIST"); u.setActive(true); u.setFirstLogin(true); return u; }
}

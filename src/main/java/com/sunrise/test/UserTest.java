package com.sunrise.test;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import com.sunrise.model.User;

public class UserTest {

    @Test
    public void testUserDetails() {

        User user = new User();

        user.setUserId(1);
        user.setFullName("Test Admin");
        user.setEmail("admin@test.com");
        user.setUsername("admin");
        user.setRole("ADMIN");
        user.setActive(true);

        assertEquals(1, user.getUserId());
        assertEquals("Test Admin", user.getFullName());
        assertEquals("admin@test.com", user.getEmail());
        assertEquals("admin", user.getUsername());
        assertEquals("ADMIN", user.getRole());
        assertTrue(user.isActive());
    }
}
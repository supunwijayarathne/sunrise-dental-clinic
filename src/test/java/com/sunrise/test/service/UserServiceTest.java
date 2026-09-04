package com.sunrise.test.service;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.sunrise.model.User;
import com.sunrise.service.UserService;

class UserServiceTest {

    private UserService userService;

    @BeforeEach
    void setUp() {
        userService = new UserService();
    }

    // =========================================================
    // GET USER BY ID
    // =========================================================

    @Test
    void getUserByIdShouldReturnNullForInvalidId() {

        User result =
                userService.getUserById(0);

        assertNull(result);
    }

    @Test
    void getUserByIdShouldReturnNullForNegativeId() {

        User result =
                userService.getUserById(-1);

        assertNull(result);
    }


    // =========================================================
    // USERNAME EXISTS
    // =========================================================

    @Test
    void usernameExistsShouldReturnFalseForNullUsername() {

        boolean result =
                userService.usernameExists(null);

        assertFalse(result);
    }

    @Test
    void usernameExistsShouldReturnFalseForBlankUsername() {

        boolean result =
                userService.usernameExists("   ");

        assertFalse(result);
    }


    // =========================================================
    // CREATE USER
    // =========================================================

    @Test
    void createUserShouldRejectNullUser() {

        boolean result =
                userService.createUser(null);

        assertFalse(result);
    }

    @Test
    void createUserShouldRejectMissingFullName() {

        User user = new User();

        user.setFullName("");
        user.setUsername("testuser");
        user.setPasswordHash("password");

        boolean result =
                userService.createUser(user);

        assertFalse(result);
    }

    @Test
    void createUserShouldRejectMissingUsername() {

        User user = new User();

        user.setFullName("Test User");
        user.setUsername("");
        user.setPasswordHash("password");

        boolean result =
                userService.createUser(user);

        assertFalse(result);
    }

    @Test
    void createUserShouldRejectMissingPassword() {

        User user = new User();

        user.setFullName("Test User");
        user.setUsername("testuser");
        user.setPasswordHash("");

        boolean result =
                userService.createUser(user);

        assertFalse(result);
    }


    // =========================================================
    // UPDATE USER
    // =========================================================

    @Test
    void updateUserShouldRejectNullUser() {

        boolean result =
                userService.updateUser(null);

        assertFalse(result);
    }

    @Test
    void updateUserShouldRejectInvalidUserId() {

        User user = new User();

        user.setUserId(0);
        user.setFullName("Test User");

        boolean result =
                userService.updateUser(user);

        assertFalse(result);
    }

    @Test
    void updateUserShouldRejectMissingFullName() {

        User user = new User();

        user.setUserId(1);
        user.setFullName("");

        boolean result =
                userService.updateUser(user);

        assertFalse(result);
    }


    // =========================================================
    // UPDATE USER STATUS
    // =========================================================

    @Test
    void updateStatusShouldRejectInvalidUserId() {

        boolean result =
                userService.updateStatus(
                        0,
                        true
                );

        assertFalse(result);
    }

    @Test
    void updateStatusShouldRejectNegativeUserId() {

        boolean result =
                userService.updateStatus(
                        -1,
                        false
                );

        assertFalse(result);
    }


    // =========================================================
    // GET ALL USERS
    // =========================================================

    @Test
    void getAllUsersShouldReturnNonNullList() {

        List<User> result =
                userService.getAllUsers();

        assertNotNull(result);
    }


    // =========================================================
    // GET RECEPTIONISTS
    // =========================================================

    @Test
    void getAllReceptionistsShouldReturnNonNullList() {

        List<User> result =
                userService.getAllReceptionists();

        assertNotNull(result);
    }
}
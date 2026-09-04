package com.sunrise.test.service;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.sunrise.model.User;
import com.sunrise.service.AuthService;

class AuthServiceTest {

    private AuthService authService;

    @BeforeEach
    void setUp() {
        authService = new AuthService();
    }

    // =========================================================
    // LOGIN VALIDATION TESTS
    // =========================================================

    @Test
    void loginShouldRejectNullUsername() {

        User result =
                authService.login(
                        null,
                        "password123"
                );

        assertNull(result);
    }

    @Test
    void loginShouldRejectEmptyUsername() {

        User result =
                authService.login(
                        "",
                        "password123"
                );

        assertNull(result);
    }

    @Test
    void loginShouldRejectBlankUsername() {

        User result =
                authService.login(
                        "   ",
                        "password123"
                );

        assertNull(result);
    }

    @Test
    void loginShouldRejectNullPassword() {

        User result =
                authService.login(
                        "admin",
                        null
                );

        assertNull(result);
    }

    @Test
    void loginShouldRejectEmptyPassword() {

        User result =
                authService.login(
                        "admin",
                        ""
                );

        assertNull(result);
    }

    // =========================================================
    // ACTIVE USER TESTS
    // =========================================================

    @Test
    void isActiveShouldReturnFalseForNullUser() {

        boolean result =
                authService.isActive(null);

        assertFalse(result);
    }

    @Test
    void isActiveShouldReturnTrueForActiveUser() {

        User user = new User();

        user.setActive(true);

        boolean result =
                authService.isActive(user);

        assertTrue(result);
    }

    @Test
    void isActiveShouldReturnFalseForInactiveUser() {

        User user = new User();

        user.setActive(false);

        boolean result =
                authService.isActive(user);

        assertFalse(result);
    }

    // =========================================================
    // GET USER BY ID TESTS
    // =========================================================

    @Test
    void getUserByIdShouldReturnNullForZeroId() {

        User result =
                authService.getUserById(0);

        assertNull(result);
    }

    @Test
    void getUserByIdShouldReturnNullForNegativeId() {

        User result =
                authService.getUserById(-1);

        assertNull(result);
    }
}
package com.sunrise.service;

import com.sunrise.dao.UserDAO;
import com.sunrise.model.User;

/**
 * Service layer for authentication operations.
 *
 * Architecture:
 * API -> Service -> DAO -> Database
 */
public class AuthService {

    private final UserDAO userDAO;

    public AuthService() {
        userDAO = new UserDAO();
    }

    // =========================================================
    // LOGIN
    // =========================================================

    public User login(
            String username,
            String password) {

        // -----------------------------------------------------
        // Validate username
        // -----------------------------------------------------

        if (username == null
                || username.trim().isEmpty()) {

            return null;
        }

        // -----------------------------------------------------
        // Validate password
        // -----------------------------------------------------

        if (password == null
                || password.isEmpty()) {

            return null;
        }

        // -----------------------------------------------------
        // Clean username
        // -----------------------------------------------------

        username =
                username.trim();

        // -----------------------------------------------------
        // Authenticate through DAO
        // -----------------------------------------------------

        return userDAO.login(
                username,
                password
        );
    }

    // =========================================================
    // CHECK USER ACTIVE
    // =========================================================

    public boolean isActive(User user) {

        if (user == null) {
            return false;
        }

        return user.isActive();
    }

    // =========================================================
    // GET USER BY ID
    // =========================================================

    public User getUserById(int userId) {

        if (userId <= 0) {
            return null;
        }

        return userDAO.getUserById(
                userId
        );
    }
}
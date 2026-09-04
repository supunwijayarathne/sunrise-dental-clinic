package com.sunrise.service;

import java.util.List;

import com.sunrise.dao.UserDAO;
import com.sunrise.model.User;

/**
 * Service layer for user management.
 *
 * Architecture:
 * API -> Service -> DAO -> Database
 */
public class UserService {

    private final UserDAO userDAO;

    public UserService() {
        userDAO = new UserDAO();
    }

    // =========================================================
    // GET ALL USERS
    // =========================================================

    public List<User> getAllUsers() {

        return userDAO.getAllUsers();
    }

    // =========================================================
    // GET ALL RECEPTIONISTS
    // =========================================================

    public List<User> getAllReceptionists() {

        return userDAO.getAllReceptionists();
    }

    // =========================================================
    // GET USER BY ID
    // =========================================================

    public User getUserById(int userId) {

        if (userId <= 0) {
            return null;
        }

        return userDAO.getUserById(userId);
    }

    // =========================================================
    // CHECK USERNAME
    // =========================================================

    public boolean usernameExists(String username) {

        if (username == null
                || username.trim().isEmpty()) {

            return false;
        }

        return userDAO.usernameExists(
                username.trim()
        );
    }

    // =========================================================
    // CREATE USER
    // =========================================================

    public boolean createUser(User user) {

        if (user == null) {
            return false;
        }

        // -----------------------------------------------------
        // Required fields
        // -----------------------------------------------------

        if (user.getFullName() == null
                || user.getFullName().trim().isEmpty()) {

            return false;
        }

        if (user.getUsername() == null
                || user.getUsername().trim().isEmpty()) {

            return false;
        }

        if (user.getPasswordHash() == null
                || user.getPasswordHash().trim().isEmpty()) {

            return false;
        }

        // -----------------------------------------------------
        // Normalise values
        // -----------------------------------------------------

        user.setFullName(
                user.getFullName().trim()
        );

        user.setUsername(
                user.getUsername().trim()
        );

        if (user.getEmail() != null) {
            user.setEmail(
                    user.getEmail().trim()
            );
        }

        if (user.getPhone() != null) {
            user.setPhone(
                    user.getPhone().trim()
            );
        }

        if (user.getAddress() != null) {
            user.setAddress(
                    user.getAddress().trim()
            );
        }

        if (user.getPosition() != null) {
            user.setPosition(
                    user.getPosition().trim()
            );
        }

        // -----------------------------------------------------
        // Default role
        // -----------------------------------------------------

        if (user.getRole() == null
                || user.getRole().trim().isEmpty()) {

            user.setRole("RECEPTIONIST");

        } else {

            user.setRole(
                    user.getRole()
                            .trim()
                            .toUpperCase()
            );
        }

        // -----------------------------------------------------
        // Duplicate username
        // -----------------------------------------------------

        if (userDAO.usernameExists(
                user.getUsername()
        )) {

            return false;
        }

        // -----------------------------------------------------
        // Default account state
        // -----------------------------------------------------

        user.setActive(true);
        user.setFirstLogin(true);

        // -----------------------------------------------------
        // Save
        // -----------------------------------------------------

        return userDAO.addUser(user);
    }

    // =========================================================
    // UPDATE USER
    // =========================================================

    public boolean updateUser(User user) {

        if (user == null
                || user.getUserId() <= 0) {

            return false;
        }

        if (user.getFullName() == null
                || user.getFullName().trim().isEmpty()) {

            return false;
        }

        user.setFullName(
                user.getFullName().trim()
        );

        if (user.getEmail() != null) {
            user.setEmail(
                    user.getEmail().trim()
            );
        }

        if (user.getPhone() != null) {
            user.setPhone(
                    user.getPhone().trim()
            );
        }

        if (user.getAddress() != null) {
            user.setAddress(
                    user.getAddress().trim()
            );
        }

        if (user.getPosition() != null) {
            user.setPosition(
                    user.getPosition().trim()
            );
        }

        if (user.getRole() != null) {

            user.setRole(
                    user.getRole()
                            .trim()
                            .toUpperCase()
            );
        }

        return userDAO.updateUser(user);
    }

    // =========================================================
    // UPDATE USER STATUS
    // =========================================================

    public boolean updateStatus(
            int userId,
            boolean active) {

        if (userId <= 0) {
            return false;
        }

        return userDAO.updateStatus(
                userId,
                active
        );
    }
}
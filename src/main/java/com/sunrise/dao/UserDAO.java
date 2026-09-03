package com.sunrise.dao;

import com.sunrise.model.User;
import com.sunrise.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // =========================================================
    // LOGIN
    // =========================================================

    public User login(String username, String password) {

        String sql =
                "SELECT * FROM users " +
                "WHERE username = ? " +
                "AND password_hash = ? " +
                "AND active = 1";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return mapUser(rs);
                }
            }

        } catch (Exception e) {

            System.out.println("ERROR DURING LOGIN:");
            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // MARK FIRST LOGIN AS COMPLETED
    // =========================================================

    public boolean markFirstLoginCompleted(int userId) {

        String sql =
                "UPDATE users SET first_login = FALSE WHERE user_id = ?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            return ps.executeUpdate() > 0;

        } catch (ClassNotFoundException | SQLException e) {

            System.out.println("ERROR UPDATING FIRST LOGIN:");
            e.printStackTrace();

            return false;
        }
    }


    // =========================================================
    // ADD RECEPTIONIST
    // =========================================================

    public boolean addUser(User user) {

        String sql =
                "INSERT INTO users " +
                "(full_name, email, phone, address, position, " +
                "username, password_hash, role, active, first_login) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getPosition());
            ps.setString(6, user.getUsername());
            ps.setString(7, user.getPasswordHash());
            ps.setString(8, user.getRole());
            ps.setBoolean(9, user.isActive());
            ps.setBoolean(10, user.isFirstLogin());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("ERROR ADDING USER:");
            e.printStackTrace();
        }
        return false;
    }

    public boolean addReceptionist(User user) {
        user.setRole("RECEPTIONIST");
        return addUser(user);
    }

    // =========================================================
    // GET ALL USERS
    // =========================================================

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY user_id DESC";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) users.add(mapUser(rs));
        } catch (Exception e) {
            System.out.println("ERROR LOADING USERS:");
            e.printStackTrace();
        }
        return users;
    }

    public List<User> getAllReceptionists() {
        List<User> receptionists = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = 'RECEPTIONIST' ORDER BY user_id DESC";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) receptionists.add(mapUser(rs));
        } catch (Exception e) {
            System.out.println("ERROR LOADING RECEPTIONISTS:");
            e.printStackTrace();
        }
        return receptionists;
    }


    // =========================================================
    // GET USER BY ID
    // =========================================================

    public User getUserById(int userId) {

        String sql =
                "SELECT * FROM users " +
                "WHERE user_id = ?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    return mapUser(rs);
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR FINDING USER:"
            );

            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // UPDATE USER
    // =========================================================

    public boolean updateUser(User user) {

        String sql =
                "UPDATE users SET full_name = ?, email = ?, " +
                "phone = ?, address = ?, position = ?, role = ? " +
                "WHERE user_id = ?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getPosition());
            ps.setString(6, user.getRole());
            ps.setInt(7, user.getUserId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("ERROR UPDATING USER:");
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateReceptionist(User user) {
        user.setRole("RECEPTIONIST");
        return updateUser(user);
    }


    // =========================================================
    // ACTIVATE / DEACTIVATE
    // =========================================================

    public boolean updateStatus(
            int userId,
            boolean active) {

        String sql =
                "UPDATE users SET active = ? " +
                "WHERE user_id = ?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setBoolean(1, active);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "ERROR UPDATING STATUS:"
            );

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // CHECK USERNAME
    // =========================================================

    public boolean usernameExists(String username) {

        String sql =
                "SELECT user_id FROM users " +
                "WHERE username = ?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {

                return rs.next();
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR CHECKING USERNAME:"
            );

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // COUNT RECEPTIONISTS
    // =========================================================

    public int getReceptionistCount() {

        String sql =
                "SELECT COUNT(*) FROM users " +
                "WHERE role = 'RECEPTIONIST' " +
                "AND active = 1";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            if (rs.next()) {

                return rs.getInt(1);
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR GETTING RECEPTIONIST COUNT:"
            );

            e.printStackTrace();
        }

        return 0;
    }


    // =========================================================
    // MAP USER
    // =========================================================

    private User mapUser(ResultSet rs)
            throws SQLException {

        User user = new User();

        user.setUserId(
                rs.getInt("user_id")
        );

        user.setFullName(
                rs.getString("full_name")
        );

        user.setEmail(
                rs.getString("email")
        );

        user.setPhone(
                rs.getString("phone")
        );

        user.setAddress(
                rs.getString("address")
        );

        user.setPosition(
                rs.getString("position")
        );

        user.setUsername(
                rs.getString("username")
        );

        user.setPasswordHash(
                rs.getString("password_hash")
        );

        user.setRole(
                rs.getString("role")
        );

        user.setActive(
                rs.getBoolean("active")
        );

        // NEW USER GUIDE
        user.setFirstLogin(
                rs.getBoolean("first_login")
        );

        return user;
    }
}
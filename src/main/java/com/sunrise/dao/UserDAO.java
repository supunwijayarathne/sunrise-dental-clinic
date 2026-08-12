package com.sunrise.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.sunrise.model.User;
import com.sunrise.util.DBConnection;

public class UserDAO {

    public User login(String username, String password) {

        User user = null;

        String sql = "SELECT * FROM users "
                + "WHERE username = ? "
                + "AND password_hash = ? "
                + "AND active = TRUE";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement(sql)
        ) {

            st.setString(1, username);
            st.setString(2, password);

            ResultSet rs = st.executeQuery();

            if (rs.next()) {

                user = new User();

                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setUsername(rs.getString("username"));
                user.setPasswordHash(rs.getString("password_hash"));
                user.setRole(rs.getString("role"));
                user.setActive(rs.getBoolean("active"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}
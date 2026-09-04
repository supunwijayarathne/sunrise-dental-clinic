package com.sunrise.test.integration;

import static org.junit.jupiter.api.Assertions.fail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

import com.sunrise.util.DBConnection;

/** Shared helpers for database integration tests. */
public final class DatabaseTestSupport {

    private DatabaseTestSupport() {}

    public static String unique(String prefix) {
        return prefix + "_" + UUID.randomUUID().toString().replace("-", "").substring(0, 10);
    }

    public static Connection connection() throws Exception {
        return DBConnection.getConnection();
    }

    public static int queryInt(String sql, Object... values) throws Exception {
        try (Connection con = connection(); PreparedStatement ps = con.prepareStatement(sql)) {
            bind(ps, values);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return 0;
                return rs.getInt(1);
            }
        }
    }

    public static String queryString(String sql, Object... values) throws Exception {
        try (Connection con = connection(); PreparedStatement ps = con.prepareStatement(sql)) {
            bind(ps, values);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getString(1) : null;
            }
        }
    }

    public static void execute(String sql, Object... values) throws Exception {
        try (Connection con = connection(); PreparedStatement ps = con.prepareStatement(sql)) {
            bind(ps, values);
            ps.executeUpdate();
        }
    }

    public static void requireDatabase() {
        try (Connection con = connection()) {
            if (con == null || con.isClosed()) fail("Sunrise Dental database connection is not available.");
        } catch (Exception e) {
            fail("Cannot connect to sunrise_dental_db. Start MySQL and import the project schema. Cause: " + e.getMessage());
        }
    }

    private static void bind(PreparedStatement ps, Object... values) throws SQLException {
        for (int i = 0; i < values.length; i++) ps.setObject(i + 1, values[i]);
    }
}

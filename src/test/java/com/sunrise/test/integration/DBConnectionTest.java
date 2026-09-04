package com.sunrise.test.integration;

import static org.junit.jupiter.api.Assertions.*;

import java.sql.Connection;
import org.junit.jupiter.api.Test;
import com.sunrise.util.DBConnection;

public class DBConnectionTest {
    @Test
    void databaseConnectionCanBeEstablished() throws Exception {
        try (Connection con = DBConnection.getConnection()) {
            assertNotNull(con);
            assertFalse(con.isClosed());
            assertEquals("sunrise_dental_db", con.getCatalog());
        }
    }
}

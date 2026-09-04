package com.sunrise.test.integration;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;
import com.sunrise.dao.DashboardDAO;
import com.sunrise.model.DashboardStats;

public class DashboardDAOIntegrationTest {
    @Test void dashboardStatsCanBeLoaded() { DatabaseTestSupport.requireDatabase(); DashboardStats s=new DashboardDAO().getDashboardStats(); assertNotNull(s); assertTrue(s.getTotalPatients()>=0); assertTrue(s.getTotalDentists()>=0); assertTrue(s.getTotalAppointments()>=0); assertTrue(s.getTotalBills()>=0); assertTrue(s.getTodayRevenue()>=0); }
}

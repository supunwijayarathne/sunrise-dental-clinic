package com.sunrise.test.integration;

import static org.junit.jupiter.api.Assertions.*;
import java.time.LocalDate;
import org.junit.jupiter.api.Test;
import com.sunrise.dao.ReportDAO;
import com.sunrise.model.ReportStats;

public class ReportDAOIntegrationTest {
    @Test void reportCanBeGeneratedForDateRange() {
        DatabaseTestSupport.requireDatabase();
        String start=LocalDate.now().minusYears(1).toString();
        String end=LocalDate.now().plusDays(1).toString();
        ReportStats s=new ReportDAO().getReportStats(start,end);
        assertNotNull(s);
        assertTrue(s.getTotalBills()>=0); assertTrue(s.getAppointmentBills()>=0); assertTrue(s.getWalkInBills()>=0);
        assertTrue(s.getTotalAppointments()>=0); assertTrue(s.getScheduledAppointments()>=0); assertTrue(s.getCompletedAppointments()>=0);
        assertTrue(s.getCancelledAppointments()>=0); assertTrue(s.getNoShowAppointments()>=0); assertTrue(s.getBilledAppointments()>=0);
        assertTrue(s.getTotalRevenue()>=0); assertNotNull(s.getBills()); assertNotNull(s.getAppointments()); assertNotNull(s.getTreatments());
        assertNotNull(s.getRevenueDates()); assertNotNull(s.getDailyRevenue());
    }

    @Test void emptyFutureRangeProducesValidEmptyOrZeroReport() {
        DatabaseTestSupport.requireDatabase();
        String start=LocalDate.now().plusYears(10).toString(); String end=LocalDate.now().plusYears(10).plusDays(1).toString();
        ReportStats s=new ReportDAO().getReportStats(start,end);
        assertNotNull(s); assertEquals(0,s.getTotalBills()); assertEquals(0,s.getTotalAppointments()); assertEquals(0,s.getTotalRevenue(),0.0001);
    }
}

package com.sunrise.test.service;

import static org.junit.jupiter.api.Assertions.assertThrows;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.sunrise.service.ReportService;

class ReportServiceTest {

    private ReportService reportService;

    @BeforeEach
    void setUp() {
        reportService = new ReportService();
    }

    // =========================================================
    // REPORT DATE VALIDATION
    // =========================================================

    @Test
    void getReportStatsShouldRejectMissingStartDate() {

        assertThrows(
                IllegalArgumentException.class,
                () -> reportService.getReportStats(
                        null,
                        "2026-09-04"
                )
        );
    }

    @Test
    void getReportStatsShouldRejectBlankStartDate() {

        assertThrows(
                IllegalArgumentException.class,
                () -> reportService.getReportStats(
                        "",
                        "2026-09-04"
                )
        );
    }

    @Test
    void getReportStatsShouldRejectMissingEndDate() {

        assertThrows(
                IllegalArgumentException.class,
                () -> reportService.getReportStats(
                        "2026-09-01",
                        null
                )
        );
    }

    @Test
    void getReportStatsShouldRejectBlankEndDate() {

        assertThrows(
                IllegalArgumentException.class,
                () -> reportService.getReportStats(
                        "2026-09-01",
                        ""
                )
        );
    }

    @Test
    void getReportStatsShouldRejectInvalidStartDateFormat() {

        assertThrows(
                IllegalArgumentException.class,
                () -> reportService.getReportStats(
                        "04-09-2026",
                        "2026-09-04"
                )
        );
    }

    @Test
    void getReportStatsShouldRejectInvalidEndDateFormat() {

        assertThrows(
                IllegalArgumentException.class,
                () -> reportService.getReportStats(
                        "2026-09-01",
                        "04-09-2026"
                )
        );
    }

    @Test
    void getReportStatsShouldRejectInvalidDateRange() {

        assertThrows(
                IllegalArgumentException.class,
                () -> reportService.getReportStats(
                        "2026-09-10",
                        "2026-09-01"
                )
        );
    }
}
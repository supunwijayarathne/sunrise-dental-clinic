package com.sunrise.service;

import com.sunrise.dao.ReportDAO;
import com.sunrise.model.ReportStats;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;

/**
 * Service layer for report-related business logic.
 *
 * Responsibilities:
 * - Validate report date ranges
 * - Retrieve report statistics from ReportDAO
 */
public class ReportService {

    private final ReportDAO reportDAO;

    public ReportService() {
        this.reportDAO = new ReportDAO();
    }

    /**
     * Generate report statistics for the given date range.
     *
     * @param startDate report start date in yyyy-MM-dd format
     * @param endDate   report end date in yyyy-MM-dd format
     * @return ReportStats containing report information
     */
    public ReportStats getReportStats(String startDate, String endDate) throws Exception {

        // Validate required values
        if (startDate == null || startDate.trim().isEmpty()) {
            throw new IllegalArgumentException("Start date is required");
        }

        if (endDate == null || endDate.trim().isEmpty()) {
            throw new IllegalArgumentException("End date is required");
        }

        startDate = startDate.trim();
        endDate = endDate.trim();

        // Validate date format
        LocalDate start;
        LocalDate end;

        try {
            start = LocalDate.parse(startDate);
            end = LocalDate.parse(endDate);
        } catch (DateTimeParseException e) {
            throw new IllegalArgumentException(
                    "Dates must be in yyyy-MM-dd format"
            );
        }

        // Validate date range
        if (start.isAfter(end)) {
            throw new IllegalArgumentException(
                    "Start date cannot be after end date"
            );
        }

        // Delegate database operation to DAO
        return reportDAO.getReportStats(startDate, endDate);
    }
}
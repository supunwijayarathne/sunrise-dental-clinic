package com.sunrise.controller;

import java.io.IOException;
import java.time.LocalDate;

import com.sunrise.dao.ReportDAO;
import com.sunrise.model.ReportStats;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/reports")
public class ReportController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ReportDAO reportDAO;

    @Override
    public void init() {
        reportDAO = new ReportDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
    	
    	HttpSession session = request.getSession(false);

        if (session == null ||
            !"Admin".equalsIgnoreCase(
                String.valueOf(session.getAttribute("role")))) {

            response.sendError(
                HttpServletResponse.SC_FORBIDDEN,
                "Access denied"
            );

            return;
        }

        // =====================================================
        // REVENUE
        // =====================================================

        String revenueFilter =
                getFilter(
                        request.getParameter("revenueFilter"),
                        "7D"
                );

        DateRange revenueRange =
                getDateRange(
                        revenueFilter,
                        request,
                        "revenue"
                );

        ReportStats revenueStats =
                reportDAO.getReportStats(
                        revenueRange.start.toString(),
                        revenueRange.end.toString()
                );


        // =====================================================
        // APPOINTMENTS
        // =====================================================

        String appointmentFilter =
                getFilter(
                        request.getParameter("appointmentFilter"),
                        "7D"
                );

        DateRange appointmentRange =
                getDateRange(
                        appointmentFilter,
                        request,
                        "appointment"
                );

        ReportStats appointmentStats =
                reportDAO.getReportStats(
                        appointmentRange.start.toString(),
                        appointmentRange.end.toString()
                );


        // =====================================================
        // TREATMENTS
        // =====================================================

        String treatmentFilter =
                getFilter(
                        request.getParameter("treatmentFilter"),
                        "MONTH"
                );

        DateRange treatmentRange =
                getDateRange(
                        treatmentFilter,
                        request,
                        "treatment"
                );

        ReportStats treatmentStats =
                reportDAO.getReportStats(
                        treatmentRange.start.toString(),
                        treatmentRange.end.toString()
                );


        // =====================================================
        // REVENUE ATTRIBUTES
        // =====================================================

        request.setAttribute(
                "revenueStats",
                revenueStats
        );

        request.setAttribute(
                "revenueFilter",
                revenueFilter
        );

        request.setAttribute(
                "revenueStartDate",
                revenueRange.start.toString()
        );

        request.setAttribute(
                "revenueEndDate",
                revenueRange.end.toString()
        );


        // =====================================================
        // APPOINTMENT ATTRIBUTES
        // =====================================================

        request.setAttribute(
                "appointmentStats",
                appointmentStats
        );

        request.setAttribute(
                "appointmentFilter",
                appointmentFilter
        );

        request.setAttribute(
                "appointmentStartDate",
                appointmentRange.start.toString()
        );

        request.setAttribute(
                "appointmentEndDate",
                appointmentRange.end.toString()
        );


        // =====================================================
        // TREATMENT ATTRIBUTES
        // =====================================================

        request.setAttribute(
                "treatmentStats",
                treatmentStats
        );

        request.setAttribute(
                "treatmentFilter",
                treatmentFilter
        );

        request.setAttribute(
                "treatmentStartDate",
                treatmentRange.start.toString()
        );

        request.setAttribute(
                "treatmentEndDate",
                treatmentRange.end.toString()
        );


        // =====================================================
        // OPEN JSP
        // =====================================================

        request.getRequestDispatcher(
                "/WEB-INF/views/reports/reports.jsp"
        ).forward(
                request,
                response
        );
    }


    // =========================================================
    // GET FILTER
    // =========================================================

    private String getFilter(
            String value,
            String defaultValue) {

        if (
                value == null ||
                value.isBlank()
        ) {

            return defaultValue;
        }

        return value;
    }


    // =========================================================
    // DATE RANGE
    // =========================================================

    private DateRange getDateRange(
            String filter,
            HttpServletRequest request,
            String prefix) {

        LocalDate today =
                LocalDate.now();

        LocalDate start;
        LocalDate end = today;


        switch (filter) {

            case "TODAY":

                start = today;

                break;


            case "7D":

                start =
                        today.minusDays(6);

                break;


            case "MONTH":

                start =
                        today.withDayOfMonth(1);

                break;


            case "3M":

                start =
                        today.minusMonths(2)
                             .withDayOfMonth(1);

                break;


            case "YEAR":

                start =
                        today.withDayOfYear(1);

                break;


            case "CUSTOM":

                String startParam =
                        request.getParameter(
                                prefix + "StartDate"
                        );

                String endParam =
                        request.getParameter(
                                prefix + "EndDate"
                        );


                try {

                    if (
                            startParam != null &&
                            !startParam.isBlank() &&
                            endParam != null &&
                            !endParam.isBlank()
                    ) {

                        start =
                                LocalDate.parse(
                                        startParam
                                );

                        end =
                                LocalDate.parse(
                                        endParam
                                );


                        // Swap if user selected
                        // the dates backwards.

                        if (end.isBefore(start)) {

                            LocalDate temp = start;

                            start = end;

                            end = temp;
                        }

                    } else {

                        start =
                                today.withDayOfMonth(1);
                    }

                } catch (Exception e) {

                    start =
                            today.withDayOfMonth(1);

                    end = today;
                }

                break;


            default:

                start =
                        today.minusDays(6);

                break;
        }


        return new DateRange(
                start,
                end
        );
    }


    // =========================================================
    // DATE RANGE CLASS
    // =========================================================

    private static class DateRange {

        LocalDate start;
        LocalDate end;


        DateRange(
                LocalDate start,
                LocalDate end) {

            this.start = start;
            this.end = end;
        }
    }
}
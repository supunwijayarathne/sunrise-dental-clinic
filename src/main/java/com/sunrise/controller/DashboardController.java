package com.sunrise.controller;

import java.io.IOException;

import com.sunrise.dao.DashboardDAO;
import com.sunrise.model.DashboardStats;
import com.sunrise.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/dashboard")
public class DashboardController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private DashboardDAO dashboardDAO;


    @Override
    public void init() {

        dashboardDAO = new DashboardDAO();
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // =====================================================
        // CHECK SESSION
        // =====================================================

        HttpSession session =
                request.getSession(false);


        if (session == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login"
            );

            return;
        }


        User loggedUser =
                (User) session.getAttribute(
                        "loggedUser"
                );


        if (loggedUser == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login"
            );

            return;
        }


        // =====================================================
        // GET DASHBOARD DATA
        // =====================================================

        DashboardStats stats =
                dashboardDAO.getDashboardStats();


        // =====================================================
        // SEND STATS OBJECT
        // =====================================================

        request.setAttribute(
                "stats",
                stats
        );


        // =====================================================
        // SEND LOGGED USER
        // =====================================================

        request.setAttribute(
                "loggedUser",
                loggedUser
        );


        // =====================================================
        // INDIVIDUAL VALUES FOR JSP
        // =====================================================

        request.setAttribute(
                "totalPatients",
                stats.getTotalPatients()
        );


        request.setAttribute(
                "totalDentists",
                stats.getTotalDentists()
        );


        request.setAttribute(
                "totalTreatments",
                stats.getTotalTreatments()
        );


        request.setAttribute(
                "totalAppointments",
                stats.getTotalAppointments()
        );


        request.setAttribute(
                "scheduledAppointments",
                stats.getScheduledAppointments()
        );


        request.setAttribute(
                "completedAppointments",
                stats.getCompletedAppointments()
        );


        request.setAttribute(
                "cancelledAppointments",
                stats.getCancelledAppointments()
        );


        request.setAttribute(
                "totalBills",
                stats.getTotalBills()
        );


        // =====================================================
        // OPEN DASHBOARD
        // =====================================================

        request.getRequestDispatcher(
                "/WEB-INF/views/dashboard/dashboard.jsp"
        ).forward(
                request,
                response
        );
    }
}
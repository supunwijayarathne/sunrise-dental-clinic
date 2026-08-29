package com.sunrise.controller;

import java.io.IOException;

import com.sunrise.dao.DashboardDAO;
import com.sunrise.dao.UserDAO;
import com.sunrise.model.DashboardStats;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/dashboard")
public class AdminDashboardController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private DashboardDAO dashboardDAO;
    private UserDAO userDAO;


    @Override
    public void init() {

        dashboardDAO = new DashboardDAO();
        userDAO = new UserDAO();
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // =====================================================
        // DASHBOARD STATISTICS
        // =====================================================

        DashboardStats stats =
                dashboardDAO.getDashboardStats();


        // =====================================================
        // ACTIVE RECEPTIONISTS
        // =====================================================

        int receptionistCount =
                userDAO.getReceptionistCount();


        // =====================================================
        // SEND DATA TO JSP
        // =====================================================

        request.setAttribute(
                "stats",
                stats
        );

        request.setAttribute(
                "receptionistCount",
                receptionistCount
        );


        // =====================================================
        // OPEN ADMIN DASHBOARD
        // =====================================================

        request.getRequestDispatcher(
                "/WEB-INF/views/admin/dashboard.jsp"
        ).forward(
                request,
                response
        );
    }
}
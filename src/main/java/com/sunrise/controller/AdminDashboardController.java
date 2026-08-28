package com.sunrise.controller;

import java.io.IOException;

import com.sunrise.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/dashboard")
public class AdminDashboardController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int receptionistCount =
                userDAO.getReceptionistCount();

        request.setAttribute(
                "receptionistCount",
                receptionistCount
        );

        request.getRequestDispatcher(
                "/WEB-INF/views/admin/dashboard.jsp")
                .forward(request, response);
    }
}
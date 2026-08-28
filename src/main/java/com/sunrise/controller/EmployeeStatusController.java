package com.sunrise.controller;

import java.io.IOException;

import com.sunrise.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/employee-status")
public class EmployeeStatusController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int userId = Integer.parseInt(
                    request.getParameter("id")
            );

            String status =
                    request.getParameter("status");

            boolean active =
                    "activate".equalsIgnoreCase(status);

            userDAO.updateStatus(
                    userId,
                    active
            );

        } catch (NumberFormatException e) {

            e.printStackTrace();
        }

        response.sendRedirect(
                request.getContextPath()
                + "/admin/employees"
        );
    }
}
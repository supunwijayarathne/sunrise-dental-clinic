package com.sunrise.controller;

import java.io.IOException;

import com.sunrise.dao.UserDAO;
import com.sunrise.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/employees")
public class EmployeeController extends HttpServlet {

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

        String action =
                request.getParameter("action");

        if ("view".equals(action)) {

            viewEmployee(request, response);

        } else {

            listEmployees(request, response);
        }
    }


    private void listEmployees(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute(
                "employees",
                userDAO.getAllReceptionists()
        );

        request.getRequestDispatcher(
                "/WEB-INF/views/admin/employees.jsp")
                .forward(request, response);
    }


    private void viewEmployee(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int id = Integer.parseInt(
                    request.getParameter("id")
            );

            User employee =
                    userDAO.getUserById(id);

            if (employee == null ||
                !"RECEPTIONIST".equalsIgnoreCase(
                        employee.getRole())) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/employees"
                );

                return;
            }

            request.setAttribute(
                    "employee",
                    employee
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/employee-details.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/employees"
            );
        }
    }
}
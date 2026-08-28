package com.sunrise.controller;

import java.io.IOException;

import com.sunrise.dao.UserDAO;
import com.sunrise.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/edit-employee")
public class EditEmployeeController extends HttpServlet {

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
                    "/WEB-INF/views/admin/edit-employee.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/employees"
            );
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int userId = Integer.parseInt(
                    request.getParameter("userId")
            );

            String fullName =
                    request.getParameter("fullName");

            String email =
                    request.getParameter("email");

            String phone =
                    request.getParameter("phone");

            String address =
                    request.getParameter("address");

            String position =
                    request.getParameter("position");


            if (fullName == null ||
                fullName.trim().isEmpty()) {

                request.setAttribute(
                        "error",
                        "Full name is required."
                );

                User employee =
                        userDAO.getUserById(userId);

                request.setAttribute(
                        "employee",
                        employee
                );

                request.getRequestDispatcher(
                        "/WEB-INF/views/admin/edit-employee.jsp")
                        .forward(request, response);

                return;
            }


            User employee =
                    userDAO.getUserById(userId);

            if (employee == null ||
                !"RECEPTIONIST".equalsIgnoreCase(
                        employee.getRole())) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/employees"
                );

                return;
            }


            employee.setFullName(fullName);
            employee.setEmail(email);
            employee.setPhone(phone);
            employee.setAddress(address);
            employee.setPosition(position);


            boolean success =
                    userDAO.updateReceptionist(employee);


            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/employees?success=updated"
                );

            } else {

                request.setAttribute(
                        "error",
                        "Unable to update receptionist."
                );

                request.setAttribute(
                        "employee",
                        employee
                );

                request.getRequestDispatcher(
                        "/WEB-INF/views/admin/edit-employee.jsp")
                        .forward(request, response);
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/employees"
            );
        }
    }
}
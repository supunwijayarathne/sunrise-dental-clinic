package com.sunrise.controller;

import java.io.IOException;

import com.sunrise.dao.UserDAO;
import com.sunrise.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/add-employee")
public class AddEmployeeController extends HttpServlet {

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

        request.getRequestDispatcher(
                "/WEB-INF/views/admin/add-employee.jsp")
                .forward(request, response);
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

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

        String username =
                request.getParameter("username");

        String password =
                request.getParameter("password");


        // ============================
        // VALIDATION
        // ============================

        if (fullName == null ||
            fullName.trim().isEmpty() ||

            username == null ||
            username.trim().isEmpty() ||

            password == null ||
            password.trim().isEmpty()) {

            request.setAttribute(
                    "error",
                    "Please fill in all required fields."
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/add-employee.jsp")
                    .forward(request, response);

            return;
        }


        if (userDAO.usernameExists(username)) {

            request.setAttribute(
                    "error",
                    "Username already exists."
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/add-employee.jsp")
                    .forward(request, response);

            return;
        }


        User user = new User();

        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);
        user.setPosition(position);

        user.setUsername(username);
        user.setPasswordHash(password);

        user.setRole("RECEPTIONIST");
        user.setActive(true);


        boolean success =
                userDAO.addReceptionist(user);


        if (success) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/employees?success=added"
            );

        } else {

            request.setAttribute(
                    "error",
                    "Unable to create receptionist account."
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/add-employee.jsp")
                    .forward(request, response);
        }
    }
}
package com.sunrise.controller;

import java.io.IOException;

import com.sunrise.dao.UserDAO;
import com.sunrise.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    // =========================================================
    // SHOW LOGIN PAGE
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/WEB-INF/views/auth/login.jsp")
                .forward(request, response);
    }

    // =========================================================
    // LOGIN
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username =
                request.getParameter("username");

        String password =
                request.getParameter("password");

        // Check login credentials
        User user =
                userDAO.login(username, password);

        if (user != null) {

            // Create session
            HttpSession session =
                    request.getSession();

            // IMPORTANT:
            // Use the same name throughout the application
            session.setAttribute("loggedUser", user);

            // =================================================
            // NEW USER CHECK
            // =================================================

            if (user.isFirstLogin()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/help");

                return;
            }

            // =================================================
            // NORMAL LOGIN
            // =================================================

            if ("ADMIN".equalsIgnoreCase(
                    user.getRole())) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/dashboard");

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/dashboard");
            }

        } else {

            request.setAttribute(
                    "error",
                    "Invalid username or password."
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/auth/login.jsp")
                    .forward(request, response);
        }
    }
}
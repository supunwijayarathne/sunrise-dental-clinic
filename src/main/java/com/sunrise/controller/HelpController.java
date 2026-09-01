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

@WebServlet("/help")
public class HelpController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    // =========================================================
    // OPEN HELP / NEW USER GUIDE
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // IMPORTANT:
        // LoginController uses "loggedUser"
        User user = null;

        if (session != null) {

            user = (User) session.getAttribute(
                    "loggedUser"
            );
        }

        // User is not logged in
        if (user == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login"
            );

            return;
        }

        // Send user information to JSP
        request.setAttribute(
                "loggedUser",
                user
        );

        // Open Help page
        request.getRequestDispatcher(
                "/WEB-INF/views/common/help.jsp"
        ).forward(request, response);
    }

    // =========================================================
    // FINISH NEW USER GUIDE
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        User user = null;

        if (session != null) {

            user = (User) session.getAttribute(
                    "loggedUser"
            );
        }

        // User is not logged in
        if (user == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login"
            );

            return;
        }

        // =====================================================
        // 1. UPDATE DATABASE
        // =====================================================

        boolean updated =
                userDAO.markFirstLoginCompleted(
                        user.getUserId()
                );

        if (updated) {

            user.setFirstLogin(false);

            session.setAttribute(
                    "loggedUser",
                    user
            );
        }

        // =====================================================
        // 2. CREATE COOKIE
        // =====================================================

        Cookie guideCookie =
                new Cookie(
                        "guideCompleted",
                        "true"
                );

        // Keep cookie for 30 days
        guideCookie.setMaxAge(
                60 * 60 * 24 * 30
        );

        // Make cookie available to application
        String contextPath =
                request.getContextPath();

        if (contextPath == null ||
                contextPath.isEmpty()) {

            guideCookie.setPath("/");

        } else {

            guideCookie.setPath(contextPath);
        }

        response.addCookie(guideCookie);

        // =====================================================
        // 3. REDIRECT TO DASHBOARD
        // =====================================================

        if ("ADMIN".equalsIgnoreCase(
                user.getRole())) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/dashboard"
            );

        } else {

            response.sendRedirect(
                    request.getContextPath()
                    + "/dashboard"
            );
        }
    }
}
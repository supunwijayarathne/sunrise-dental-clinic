package com.sunrise.controller;

import java.io.IOException;

import com.sunrise.dao.UserDAO;
import com.sunrise.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
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

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/WEB-INF/views/auth/login.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username =
                request.getParameter("username");

        String password =
                request.getParameter("password");

        User user =
                userDAO.login(username, password);

        if (user != null) {

            HttpSession session = request.getSession();

            session.setAttribute("loggedUser", user);

            if ("ADMIN".equals(user.getRole())) {

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
                    "Invalid username or password.");

            request.getRequestDispatcher(
                    "/WEB-INF/views/auth/login.jsp")
                    .forward(request, response);
        }
    }
}
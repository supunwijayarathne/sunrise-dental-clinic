package com.sunrise.controller;

import java.io.IOException;
import com.sunrise.dao.UserDAO;
import com.sunrise.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/add-user")
public class AddUserController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() { userDAO = new UserDAO(); }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/admin/add-user.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String fullName=request.getParameter("fullName");
        String email=request.getParameter("email");
        String phone=request.getParameter("phone");
        String address=request.getParameter("address");
        String position=request.getParameter("position");
        String username=request.getParameter("username");
        String password=request.getParameter("password");
        String role=request.getParameter("role");

        if (fullName==null || fullName.trim().isEmpty()
                || username==null || username.trim().isEmpty()
                || password==null || password.trim().isEmpty()) {
            request.setAttribute("error","Please fill in all required fields.");
            request.getRequestDispatcher("/WEB-INF/views/admin/add-user.jsp").forward(request,response);
            return;
        }

        role=role==null ? "" : role.trim().toUpperCase();
        if (!"ADMIN".equals(role) && !"RECEPTIONIST".equals(role)) {
            request.setAttribute("error","Please select a valid user role.");
            request.getRequestDispatcher("/WEB-INF/views/admin/add-user.jsp").forward(request,response);
            return;
        }

        if (userDAO.usernameExists(username.trim())) {
            request.setAttribute("error","Username already exists.");
            request.getRequestDispatcher("/WEB-INF/views/admin/add-user.jsp").forward(request,response);
            return;
        }

        User user=new User();
        user.setFullName(fullName.trim());
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);
        user.setPosition(position);
        user.setUsername(username.trim());
        user.setPasswordHash(password);
        user.setRole(role);
        user.setActive(true);
        user.setFirstLogin(true);

        if (userDAO.addUser(user)) {
            response.sendRedirect(request.getContextPath()+"/admin/users?success=added");
        } else {
            request.setAttribute("error","Unable to create user account.");
            request.getRequestDispatcher("/WEB-INF/views/admin/add-user.jsp").forward(request,response);
        }
    }
}

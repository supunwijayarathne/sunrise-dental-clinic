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

@WebServlet("/admin/user-status")
public class UserStatusController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() { userDAO = new UserDAO(); }

    @Override
    protected void doPost(HttpServletRequest request,HttpServletResponse response)
            throws ServletException,IOException {
        try {
            int userId=Integer.parseInt(request.getParameter("id"));
            boolean active="activate".equalsIgnoreCase(request.getParameter("status"));

            HttpSession session=request.getSession(false);
            User loggedUser=session==null?null:(User)session.getAttribute("loggedUser");

            if(loggedUser!=null && loggedUser.getUserId()==userId && !active){
                response.sendRedirect(request.getContextPath()+"/admin/users?error=selfdisable");
                return;
            }

            userDAO.updateStatus(userId,active);
        }catch(NumberFormatException e){ e.printStackTrace(); }

        response.sendRedirect(request.getContextPath()+"/admin/users");
    }
}

package com.sunrise.controller;

import java.io.IOException;
import com.sunrise.dao.UserDAO;
import com.sunrise.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/edit-user")
public class EditUserController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() { userDAO = new UserDAO(); }

    @Override
    protected void doGet(HttpServletRequest request,HttpServletResponse response)
            throws ServletException,IOException {
        try {
            User user=userDAO.getUserById(Integer.parseInt(request.getParameter("id")));
            if(user==null){ response.sendRedirect(request.getContextPath()+"/admin/users"); return; }
            request.setAttribute("user",user);
            request.getRequestDispatcher("/WEB-INF/views/admin/edit-user.jsp").forward(request,response);
        } catch(NumberFormatException e){
            response.sendRedirect(request.getContextPath()+"/admin/users");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,HttpServletResponse response)
            throws ServletException,IOException {
        try {
            int id=Integer.parseInt(request.getParameter("userId"));
            User user=userDAO.getUserById(id);
            if(user==null){ response.sendRedirect(request.getContextPath()+"/admin/users"); return; }

            String fullName=request.getParameter("fullName");
            String role=request.getParameter("role");
            if(fullName==null || fullName.trim().isEmpty()){
                request.setAttribute("error","Full name is required.");
                request.setAttribute("user",user);
                request.getRequestDispatcher("/WEB-INF/views/admin/edit-user.jsp").forward(request,response);
                return;
            }

            role=role==null ? "" : role.trim().toUpperCase();
            if(!"ADMIN".equals(role) && !"RECEPTIONIST".equals(role)){
                request.setAttribute("error","Please select a valid user role.");
                request.setAttribute("user",user);
                request.getRequestDispatcher("/WEB-INF/views/admin/edit-user.jsp").forward(request,response);
                return;
            }

            user.setFullName(fullName.trim());
            user.setEmail(request.getParameter("email"));
            user.setPhone(request.getParameter("phone"));
            user.setAddress(request.getParameter("address"));
            user.setPosition(request.getParameter("position"));
            user.setRole(role);

            if(userDAO.updateUser(user)){
                response.sendRedirect(request.getContextPath()+"/admin/users?success=updated");
            }else{
                request.setAttribute("error","Unable to update user.");
                request.setAttribute("user",user);
                request.getRequestDispatcher("/WEB-INF/views/admin/edit-user.jsp").forward(request,response);
            }
        }catch(NumberFormatException e){
            response.sendRedirect(request.getContextPath()+"/admin/users");
        }
    }
}

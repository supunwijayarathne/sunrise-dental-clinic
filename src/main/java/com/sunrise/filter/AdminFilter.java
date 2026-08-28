package com.sunrise.filter;

import java.io.IOException;

import com.sunrise.model.User;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void doFilter(
            ServletRequest request,
            ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest =
                (HttpServletRequest) request;

        HttpServletResponse httpResponse =
                (HttpServletResponse) response;

        HttpSession session =
                httpRequest.getSession(false);

        User loggedUser = null;

        if (session != null) {

            loggedUser =
                    (User) session.getAttribute(
                            "loggedUser"
                    );
        }

        if (loggedUser == null) {

            httpResponse.sendRedirect(
                    httpRequest.getContextPath()
                    + "/login"
            );

            return;
        }

        if (!"ADMIN".equalsIgnoreCase(
                loggedUser.getRole())) {

            httpResponse.sendRedirect(
                    httpRequest.getContextPath()
                    + "/dashboard"
            );

            return;
        }

        chain.doFilter(
                request,
                response
        );
    }
}
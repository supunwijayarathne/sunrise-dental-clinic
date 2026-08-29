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

@WebFilter("/*")
public class AuthenticationFilter implements Filter {

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

        String contextPath =
                httpRequest.getContextPath();

        String requestURI =
                httpRequest.getRequestURI();

        String path =
                requestURI.substring(contextPath.length());


        // =====================================================
        // ALLOW LOGIN PAGE
        // =====================================================

        if (path.equals("/login")) {

            chain.doFilter(request, response);

            return;
        }


        // =====================================================
        // ALLOW STATIC RESOURCES
        // =====================================================

        if (path.startsWith("/css/")
                || path.startsWith("/js/")
                || path.startsWith("/images/")
                || path.startsWith("/assets/")
                || path.endsWith(".css")
                || path.endsWith(".js")
                || path.endsWith(".png")
                || path.endsWith(".jpg")
                || path.endsWith(".jpeg")
                || path.endsWith(".svg")
                || path.endsWith(".ico")) {

            chain.doFilter(request, response);

            return;
        }


        // =====================================================
        // GET SESSION
        // =====================================================

        HttpSession session =
                httpRequest.getSession(false);

        User loggedUser = null;

        if (session != null) {

            loggedUser =
                    (User) session.getAttribute("loggedUser");
        }


        // =====================================================
        // NOT LOGGED IN
        // =====================================================

        if (loggedUser == null) {

            httpResponse.sendRedirect(
                    contextPath + "/login");

            return;
        }


        // =====================================================
        // ADMIN AREA
        // =====================================================

        if (path.startsWith("/admin")) {

            if (!"ADMIN".equals(loggedUser.getRole())) {

                httpResponse.sendError(
                        HttpServletResponse.SC_FORBIDDEN,
                        "Access denied.");

                return;
            }
        }


        // =====================================================
        // ADMIN USER TRYING TO ACCESS RECEPTIONIST DASHBOARD
        // =====================================================

        if (path.equals("/dashboard")) {

            if ("ADMIN".equals(loggedUser.getRole())) {

                httpResponse.sendRedirect(
                        contextPath + "/admin/dashboard");

                return;
            }
        }


        // =====================================================
        // CONTINUE
        // =====================================================

        chain.doFilter(request, response);
    }
}
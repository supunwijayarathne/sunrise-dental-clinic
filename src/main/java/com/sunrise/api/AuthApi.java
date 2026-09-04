package com.sunrise.api;

import java.io.BufferedReader;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

import com.sunrise.model.User;
import com.sunrise.service.AuthService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/api/auth/*")
public class AuthApi extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private AuthService authService;

    // =========================================================
    // INITIALIZE
    // =========================================================

    @Override
    public void init()
            throws ServletException {

        authService =
                new AuthService();
    }

    // =========================================================
    // OPTIONS
    // =========================================================

    @Override
    protected void doOptions(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        ApiUtil.cors(response);
        ApiUtil.noContent(response);
    }

    // =========================================================
    // POST
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        ApiUtil.cors(response);
        ApiUtil.json(response);

        request.setCharacterEncoding(
                "UTF-8"
        );

        try {

            String path =
                    getApiPath(request);

            // =================================================
            // POST /api/auth/login
            // =================================================

            if ("/login".equals(path)) {

                login(
                        request,
                        response
                );

                return;
            }

            // =================================================
            // POST /api/auth/logout
            // =================================================

            if ("/logout".equals(path)) {

                logout(
                        request,
                        response
                );

                return;
            }

            ApiUtil.error(
                    response,
                    404,
                    "Authentication endpoint not found"
            );

        } catch (Exception e) {

            e.printStackTrace();

            ApiUtil.error(
                    response,
                    500,
                    "Server error"
            );
        }
    }

    // =========================================================
    // LOGIN
    // =========================================================

    private void login(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        // -----------------------------------------------------
        // Read form body
        // -----------------------------------------------------

        Map<String, String> params =
                readRequestParameters(request);

        String username =
                params.get("username");

        String password =
                params.get("password");

        // -----------------------------------------------------
        // Required validation
        // -----------------------------------------------------

        if (ApiUtil.blank(username)
                || ApiUtil.blank(password)) {

            ApiUtil.error(
                    response,
                    400,
                    "Username and password are required"
            );

            return;
        }

        // -----------------------------------------------------
        // Authenticate through service
        // -----------------------------------------------------

        User user =
                authService.login(
                        username,
                        password
                );

        if (user == null) {

            ApiUtil.error(
                    response,
                    401,
                    "Invalid username or password"
            );

            return;
        }

        // -----------------------------------------------------
        // Check account status
        // -----------------------------------------------------

        if (!authService.isActive(user)) {

            ApiUtil.error(
                    response,
                    403,
                    "User account is inactive"
            );

            return;
        }

        // -----------------------------------------------------
        // Create session
        // -----------------------------------------------------

        HttpSession session =
                request.getSession(true);

        /*
         * Existing application uses loggedUser.
         * AuthenticationFilter/AdminFilter can continue
         * using this attribute.
         */
        session.setAttribute(
                "loggedUser",
                user
        );

        /*
         * API uses user.
         */
        session.setAttribute(
                "user",
                user
        );

        session.setAttribute(
                "userId",
                user.getUserId()
        );

        session.setAttribute(
                "username",
                user.getUsername()
        );

        session.setAttribute(
                "role",
                user.getRole()
        );

        // -----------------------------------------------------
        // Response
        // -----------------------------------------------------

        response.getWriter().write(
                userJson(user)
        );
    }

    // =========================================================
    // LOGOUT
    // =========================================================

    private void logout(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session =
                request.getSession(false);

        if (session != null) {

            session.invalidate();
        }

        ApiUtil.ok(
                response,
                "Logged out successfully"
        );
    }

    // =========================================================
    // GET
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        ApiUtil.cors(response);
        ApiUtil.json(response);

        try {

            String path =
                    getApiPath(request);

            // =================================================
            // GET /api/auth/me
            // =================================================

            if ("/me".equals(path)) {

                getCurrentUser(
                        request,
                        response
                );

                return;
            }

            ApiUtil.error(
                    response,
                    404,
                    "Authentication endpoint not found"
            );

        } catch (Exception e) {

            e.printStackTrace();

            ApiUtil.error(
                    response,
                    500,
                    "Server error"
            );
        }
    }

    // =========================================================
    // GET CURRENT USER
    // =========================================================

    private void getCurrentUser(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null) {

            ApiUtil.error(
                    response,
                    401,
                    "Not authenticated"
            );

            return;
        }

        // -----------------------------------------------------
        // First check API session user
        // -----------------------------------------------------

        Object userObject =
                session.getAttribute(
                        "user"
                );

        // -----------------------------------------------------
        // Fallback to existing application session
        // -----------------------------------------------------

        if (!(userObject instanceof User)) {

            userObject =
                    session.getAttribute(
                            "loggedUser"
                    );
        }

        if (!(userObject instanceof User)) {

            ApiUtil.error(
                    response,
                    401,
                    "Not authenticated"
            );

            return;
        }

        User user =
                (User) userObject;

        // -----------------------------------------------------
        // Check active account
        // -----------------------------------------------------

        if (!authService.isActive(user)) {

            ApiUtil.error(
                    response,
                    403,
                    "User account is inactive"
            );

            return;
        }

        response.getWriter().write(
                userJson(user)
        );
    }

    // =========================================================
    // GET API PATH
    // =========================================================

    private String getApiPath(
            HttpServletRequest request) {

        String requestURI =
                request.getRequestURI();

        String contextPath =
                request.getContextPath();

        String base =
                contextPath + "/api/auth";

        if (requestURI.startsWith(base)) {

            String path =
                    requestURI.substring(
                            base.length()
                    );

            if (path.isEmpty()) {

                return "/";
            }

            return path;
        }

        return "";
    }

    // =========================================================
    // READ REQUEST PARAMETERS
    // =========================================================

    private Map<String, String>
    readRequestParameters(
            HttpServletRequest request)
            throws IOException {

        Map<String, String> params =
                new HashMap<>();

        // -----------------------------------------------------
        // First try standard request parameters.
        // Useful if the request comes from the existing JSP.
        // -----------------------------------------------------

        String username =
                request.getParameter(
                        "username"
                );

        String password =
                request.getParameter(
                        "password"
                );

        if (!ApiUtil.blank(username)) {

            params.put(
                    "username",
                    username
            );
        }

        if (!ApiUtil.blank(password)) {

            params.put(
                    "password",
                    password
            );
        }

        // -----------------------------------------------------
        // If parameters are missing, read form body.
        // This keeps compatibility with Postman
        // x-www-form-urlencoded requests.
        // -----------------------------------------------------

        if (ApiUtil.blank(username)
                || ApiUtil.blank(password)) {

            StringBuilder body =
                    new StringBuilder();

            String line;

            try (BufferedReader reader =
                         request.getReader()) {

                while ((line =
                        reader.readLine()) != null) {

                    body.append(line);
                }
            }

            Map<String, String> bodyParams =
                    parseFormData(
                            body.toString()
                    );

            if (ApiUtil.blank(
                    params.get("username")
            )) {

                String value =
                        bodyParams.get(
                                "username"
                        );

                if (value != null) {

                    params.put(
                            "username",
                            value
                    );
                }
            }

            if (ApiUtil.blank(
                    params.get("password")
            )) {

                String value =
                        bodyParams.get(
                                "password"
                        );

                if (value != null) {

                    params.put(
                            "password",
                            value
                    );
                }
            }
        }

        return params;
    }

    // =========================================================
    // FORM DATA PARSER
    // =========================================================

    private Map<String, String>
    parseFormData(String body) {

        Map<String, String> params =
                new HashMap<>();

        if (body == null
                || body.trim().isEmpty()) {

            return params;
        }

        String[] pairs =
                body.split("&");

        for (String pair :
                pairs) {

            String[] parts =
                    pair.split(
                            "=",
                            2
                    );

            if (parts.length != 2) {
                continue;
            }

            String key =
                    URLDecoder.decode(
                            parts[0],
                            StandardCharsets.UTF_8
                    );

            String value =
                    URLDecoder.decode(
                            parts[1],
                            StandardCharsets.UTF_8
                    );

            params.put(
                    key,
                    value
            );
        }

        return params;
    }

    // =========================================================
    // USER JSON
    // =========================================================

    private String userJson(
            User user) {

        return "{"

                + "\"success\":true,"

                + "\"user\":{"

                + "\"userId\":"
                + user.getUserId()

                + ",\"fullName\":"
                + ApiUtil.str(
                        user.getFullName()
                  )

                + ",\"email\":"
                + ApiUtil.nullable(
                        user.getEmail()
                  )

                + ",\"phone\":"
                + ApiUtil.nullable(
                        user.getPhone()
                  )

                + ",\"position\":"
                + ApiUtil.nullable(
                        user.getPosition()
                  )

                + ",\"username\":"
                + ApiUtil.str(
                        user.getUsername()
                  )

                + ",\"role\":"
                + ApiUtil.str(
                        user.getRole()
                  )

                + ",\"active\":"
                + user.isActive()

                + ",\"firstLogin\":"
                + user.isFirstLogin()

                + "}"

                + "}";
    }
}
package com.sunrise.api;

import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sunrise.model.User;
import com.sunrise.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/api/users/*")
public class UserApi extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserService userService;

    // =========================================================
    // INITIALIZE
    // =========================================================

    @Override
    public void init() {

        userService =
                new UserService();
    }

    // =========================================================
    // OPTIONS
    // =========================================================

    @Override
    protected void doOptions(
            HttpServletRequest request,
            HttpServletResponse response) {

        ApiUtil.cors(response);
        ApiUtil.noContent(response);
    }

    // =========================================================
    // ADMIN CHECK
    // =========================================================

    private boolean admin(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null
                || !"ADMIN".equalsIgnoreCase(
                        String.valueOf(
                                session.getAttribute("role")
                        )
                )) {

            ApiUtil.error(
                    response,
                    403,
                    "Admin role required"
            );

            return false;
        }

        return true;
    }

    // =========================================================
    // GET
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        ApiUtil.json(response);
        ApiUtil.cors(response);

        if (!admin(request, response)) {
            return;
        }

        try {

            String path =
                    request.getPathInfo();

            // =================================================
            // GET RECEPTIONISTS
            // =================================================

            if ("/receptionists".equals(path)) {

                response.getWriter().write(
                        list(
                                userService
                                        .getAllReceptionists()
                        )
                );

                return;
            }

            // =================================================
            // GET ALL USERS
            // =================================================

            if (path == null
                    || "/".equals(path)
                    || path.isEmpty()) {

                response.getWriter().write(
                        list(
                                userService
                                        .getAllUsers()
                        )
                );

                return;
            }

            // =================================================
            // GET USER BY ID
            // =================================================

            int userId =
                    Integer.parseInt(
                            path.substring(1)
                    );

            User user =
                    userService.getUserById(
                            userId
                    );

            if (user == null) {

                ApiUtil.error(
                        response,
                        404,
                        "User not found"
                );

                return;
            }

            response.getWriter().write(
                    one(user)
            );

        } catch (NumberFormatException e) {

            ApiUtil.error(
                    response,
                    400,
                    "Invalid user ID"
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
    // POST
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        ApiUtil.json(response);
        ApiUtil.cors(response);

        request.setCharacterEncoding(
                "UTF-8"
        );

        if (!admin(request, response)) {
            return;
        }

        try {

            // =================================================
            // READ REQUEST BODY
            // =================================================

            String body =
                    request.getReader()
                           .lines()
                           .reduce(
                                   "",
                                   (a, b) -> a + b
                           );

            Map<String, String> params =
                    parseFormData(body);

            // =================================================
            // PARAMETERS
            // =================================================

            String fullName =
                    params.get("fullName");

            String email =
                    params.get("email");

            String phone =
                    params.get("phone");

            String address =
                    params.get("address");

            String position =
                    params.get("position");

            String username =
                    params.get("username");

            String password =
                    params.get("password");

            String role =
                    params.get("role");

            // =================================================
            // REQUIRED VALIDATION
            // =================================================

            if (ApiUtil.blank(fullName)
                    || ApiUtil.blank(username)
                    || ApiUtil.blank(password)) {

                ApiUtil.error(
                        response,
                        400,
                        "Full name, username and password are required"
                );

                return;
            }

            // =================================================
            // USERNAME CHECK
            // =================================================

            if (userService.usernameExists(
                    username.trim()
            )) {

                ApiUtil.error(
                        response,
                        409,
                        "Username already exists"
                );

                return;
            }

            // =================================================
            // BUILD USER
            // =================================================

            User user =
                    new User();

            user.setFullName(
                    fullName.trim()
            );

            user.setEmail(
                    ApiUtil.blank(email)
                            ? null
                            : email.trim()
            );

            user.setPhone(
                    ApiUtil.blank(phone)
                            ? null
                            : phone.trim()
            );

            user.setAddress(
                    ApiUtil.blank(address)
                            ? null
                            : address.trim()
            );

            user.setPosition(
                    ApiUtil.blank(position)
                            ? null
                            : position.trim()
            );

            user.setUsername(
                    username.trim()
            );

            user.setPasswordHash(
                    password
            );

            user.setRole(
                    ApiUtil.blank(role)
                            ? "RECEPTIONIST"
                            : role.trim()
            );

            user.setActive(true);
            user.setFirstLogin(true);

            // =================================================
            // CREATE THROUGH SERVICE
            // =================================================

            if (userService.createUser(user)) {

                response.setStatus(
                        HttpServletResponse.SC_CREATED
                );

                response.getWriter().write(
                        one(user)
                );

                return;
            }

            // =================================================
            // DUPLICATE CHECK
            // =================================================

            if (userService.usernameExists(
                    username.trim()
            )) {

                ApiUtil.error(
                        response,
                        409,
                        "Username already exists"
                );

                return;
            }

            ApiUtil.error(
                    response,
                    400,
                    "User could not be created"
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
    // PUT
    // =========================================================

    @Override
    protected void doPut(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        ApiUtil.json(response);
        ApiUtil.cors(response);

        request.setCharacterEncoding(
                "UTF-8"
        );

        if (!admin(request, response)) {
            return;
        }

        try {

            String path =
                    request.getPathInfo();

            if (path == null
                    || "/".equals(path)) {

                ApiUtil.error(
                        response,
                        400,
                        "User ID is required"
                );

                return;
            }

            int userId =
                    Integer.parseInt(
                            path.substring(1)
                    );

            User user =
                    userService.getUserById(
                            userId
                    );

            if (user == null) {

                ApiUtil.error(
                        response,
                        404,
                        "User not found"
                );

                return;
            }

            // =================================================
            // READ BODY
            // =================================================

            String body =
                    request.getReader()
                           .lines()
                           .reduce(
                                   "",
                                   (a, b) -> a + b
                           );

            Map<String, String> params =
                    parseFormData(body);

            // =================================================
            // UPDATE FIELDS
            // =================================================

            String fullName =
                    params.get("fullName");

            String email =
                    params.get("email");

            String phone =
                    params.get("phone");

            String address =
                    params.get("address");

            String position =
                    params.get("position");

            String role =
                    params.get("role");

            if (fullName != null) {

                user.setFullName(
                        fullName.trim()
                );
            }

            if (email != null) {

                user.setEmail(
                        email.trim()
                );
            }

            if (phone != null) {

                user.setPhone(
                        phone.trim()
                );
            }

            if (address != null) {

                user.setAddress(
                        address.trim()
                );
            }

            if (position != null) {

                user.setPosition(
                        position.trim()
                );
            }

            if (role != null) {

                user.setRole(
                        role.trim()
                );
            }

            // =================================================
            // UPDATE THROUGH SERVICE
            // =================================================

            if (userService.updateUser(user)) {

                response.getWriter().write(
                        one(user)
                );

            } else {

                ApiUtil.error(
                        response,
                        400,
                        "User could not be updated"
                );
            }

        } catch (NumberFormatException e) {

            ApiUtil.error(
                    response,
                    400,
                    "Invalid user ID"
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
    // PATCH SUPPORT
    // =========================================================

    @Override
    protected void service(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if ("PATCH".equalsIgnoreCase(
                request.getMethod())) {

            doPatch(
                    request,
                    response
            );

            return;
        }

        super.service(
                request,
                response
        );
    }

    // =========================================================
    // PATCH
    // =========================================================

    private void doPatch(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        ApiUtil.json(response);
        ApiUtil.cors(response);

        if (!admin(request, response)) {
            return;
        }

        try {

            String path =
                    request.getPathInfo();

            if (path == null
                    || "/".equals(path)) {

                ApiUtil.error(
                        response,
                        400,
                        "User ID is required"
                );

                return;
            }

            int userId =
                    Integer.parseInt(
                            path.substring(1)
                    );

            // =================================================
            // READ ACTIVE VALUE
            // =================================================

            String active =
                    request.getParameter(
                            "active"
                    );

            // If query parameter is not available,
            // read the form body.

            if (ApiUtil.blank(active)) {

                String body =
                        request.getReader()
                               .lines()
                               .reduce(
                                       "",
                                       (a, b) -> a + b
                               );

                Map<String, String> params =
                        parseFormData(body);

                active =
                        params.get("active");
            }

            if (ApiUtil.blank(active)) {

                ApiUtil.error(
                        response,
                        400,
                        "active is required"
                );

                return;
            }

            // =================================================
            // VALID BOOLEAN
            // =================================================

            if (!"true".equalsIgnoreCase(active)
                    && !"false".equalsIgnoreCase(active)) {

                ApiUtil.error(
                        response,
                        400,
                        "active must be true or false"
                );

                return;
            }

            boolean activeValue =
                    Boolean.parseBoolean(
                            active
                    );

            // =================================================
            // UPDATE THROUGH SERVICE
            // =================================================

            boolean updated =
                    userService.updateStatus(
                            userId,
                            activeValue
                    );

            if (updated) {

                ApiUtil.ok(
                        response,
                        "User status updated successfully"
                );

            } else {

                ApiUtil.error(
                        response,
                        400,
                        "User status could not be updated"
                );
            }

        } catch (NumberFormatException e) {

            ApiUtil.error(
                    response,
                    400,
                    "Invalid user ID"
            );

        } catch (Exception e) {

            e.printStackTrace();

            ApiUtil.error(
                    response,
                    400,
                    "Invalid user status request"
            );
        }
    }

    // =========================================================
    // FORM DATA PARSER
    // =========================================================

    private Map<String, String> parseFormData(
            String body) {

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
    // JSON LIST
    // =========================================================

    private String list(
            List<User> users) {

        StringBuilder json =
                new StringBuilder("[");

        for (int i = 0;
             i < users.size();
             i++) {

            if (i > 0) {
                json.append(",");
            }

            json.append(
                    one(
                            users.get(i)
                    )
            );
        }

        json.append("]");

        return json.toString();
    }

    // =========================================================
    // JSON ONE
    // =========================================================

    private String one(
            User user) {

        return "{"

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

                + ",\"address\":"
                + ApiUtil.nullable(
                        user.getAddress()
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

                + "}";
    }
}
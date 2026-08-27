package com.sunrise.controller;

import java.io.IOException;
import java.util.List;

import com.sunrise.dao.DentistDAO;
import com.sunrise.model.Dentist;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/dentists/*")
public class DentistController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private DentistDAO dentistDAO;

    @Override
    public void init() {
        dentistDAO = new DentistDAO();
    }

    // =========================================================
    // GET REQUESTS
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();

        if (path == null || path.equals("/")) {

            listDentists(request, response);

        } else if (path.equals("/add")) {

            showAddForm(request, response);

        } else if (path.equals("/view")) {

            viewDentist(request, response);

        } else if (path.equals("/edit")) {

            showEditForm(request, response);

        } else {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND
            );
        }
    }

    // =========================================================
    // POST REQUESTS
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String path = request.getPathInfo();

        if ("/add".equals(path)) {

            addDentist(request, response);

        } else if ("/edit".equals(path)) {

            updateDentist(request, response);

        } else {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND
            );
        }
    }

    // =========================================================
    // LIST / SEARCH
    // =========================================================

    private void listDentists(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");

        List<Dentist> dentists;

        if (keyword != null && !keyword.trim().isEmpty()) {

            keyword = keyword.trim();

            dentists = dentistDAO.searchDentists(keyword);

        } else {

            dentists = dentistDAO.getAllDentists();
        }

        request.setAttribute("dentists", dentists);
        request.setAttribute("keyword", keyword);

        request.getRequestDispatcher(
                "/WEB-INF/views/dentists/dentist-list.jsp"
        ).forward(request, response);
    }

    // =========================================================
    // SHOW ADD FORM
    // =========================================================

    private void showAddForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("formMode", "add");

        request.getRequestDispatcher(
                "/WEB-INF/views/dentists/dentist-form.jsp"
        ).forward(request, response);
    }

    // =========================================================
    // ADD DENTIST
    // =========================================================

    private void addDentist(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String dentistName =
                request.getParameter("dentistName");

        String specialization =
                request.getParameter("specialization");

        String feeText =
                request.getParameter("consultationFee");

        String phoneNumber =
                request.getParameter("phoneNumber");

        String email =
                request.getParameter("email");

        String activeText =
                request.getParameter("active");

        dentistName =
                dentistName != null
                ? dentistName.trim()
                : "";

        specialization =
                specialization != null
                ? specialization.trim()
                : "";

        phoneNumber =
                phoneNumber != null
                ? phoneNumber.trim()
                : "";

        email =
                email != null
                ? email.trim()
                : "";

        boolean active =
                "true".equals(activeText);

        double consultationFee;

        try {

            consultationFee =
                    Double.parseDouble(feeText);

        } catch (Exception e) {

            Dentist dentist = new Dentist(
                    dentistName,
                    specialization,
                    0,
                    phoneNumber,
                    email,
                    active
            );

            showFormWithError(
                    request,
                    response,
                    dentist,
                    "Please enter a valid consultation fee.",
                    "add"
            );

            return;
        }

        String error =
                validateDentist(
                        dentistName,
                        specialization,
                        consultationFee,
                        phoneNumber,
                        email
                );

        if (error != null) {

            Dentist dentist = new Dentist(
                    dentistName,
                    specialization,
                    consultationFee,
                    phoneNumber,
                    email,
                    active
            );

            showFormWithError(
                    request,
                    response,
                    dentist,
                    error,
                    "add"
            );

            return;
        }

        Dentist dentist = new Dentist(
                dentistName,
                specialization,
                consultationFee,
                phoneNumber,
                email,
                active
        );

        boolean success =
                dentistDAO.addDentist(dentist);

        if (success) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/dentists?success=1"
            );

        } else {

            showFormWithError(
                    request,
                    response,
                    dentist,
                    "Unable to add dentist. Please try again.",
                    "add"
            );
        }
    }

    // =========================================================
    // VIEW DENTIST
    // =========================================================

    private void viewDentist(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int dentistId =
                    Integer.parseInt(
                            request.getParameter("id")
                    );

            Dentist dentist =
                    dentistDAO.getDentistById(dentistId);

            if (dentist == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Dentist not found."
                );

                return;
            }

            request.setAttribute(
                    "dentist",
                    dentist
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/dentists/dentist-details.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid dentist ID."
            );
        }
    }

    // =========================================================
    // SHOW EDIT FORM
    // =========================================================

    private void showEditForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int dentistId =
                    Integer.parseInt(
                            request.getParameter("id")
                    );

            Dentist dentist =
                    dentistDAO.getDentistById(dentistId);

            if (dentist == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Dentist not found."
                );

                return;
            }

            request.setAttribute(
                    "dentist",
                    dentist
            );

            request.setAttribute(
                    "formMode",
                    "edit"
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/dentists/dentist-form.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid dentist ID."
            );
        }
    }

    // =========================================================
    // UPDATE DENTIST
    // =========================================================

    private void updateDentist(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int dentistId =
                    Integer.parseInt(
                            request.getParameter("dentistId")
                    );

            String dentistName =
                    request.getParameter("dentistName");

            String specialization =
                    request.getParameter("specialization");

            String feeText =
                    request.getParameter("consultationFee");

            String phoneNumber =
                    request.getParameter("phoneNumber");

            String email =
                    request.getParameter("email");

            String activeText =
                    request.getParameter("active");

            dentistName =
                    dentistName != null
                    ? dentistName.trim()
                    : "";

            specialization =
                    specialization != null
                    ? specialization.trim()
                    : "";

            phoneNumber =
                    phoneNumber != null
                    ? phoneNumber.trim()
                    : "";

            email =
                    email != null
                    ? email.trim()
                    : "";

            boolean active =
                    "true".equals(activeText);

            Dentist dentist =
                    dentistDAO.getDentistById(dentistId);

            if (dentist == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Dentist not found."
                );

                return;
            }

            double consultationFee;

            try {

                consultationFee =
                        Double.parseDouble(feeText);

            } catch (Exception e) {

                dentist.setDentistName(dentistName);
                dentist.setSpecialization(specialization);
                dentist.setPhoneNumber(phoneNumber);
                dentist.setEmail(email);
                dentist.setActive(active);

                showFormWithError(
                        request,
                        response,
                        dentist,
                        "Please enter a valid consultation fee.",
                        "edit"
                );

                return;
            }

            String error =
                    validateDentist(
                            dentistName,
                            specialization,
                            consultationFee,
                            phoneNumber,
                            email
                    );

            if (error != null) {

                dentist.setDentistName(dentistName);
                dentist.setSpecialization(specialization);
                dentist.setConsultationFee(
                        consultationFee
                );
                dentist.setPhoneNumber(phoneNumber);
                dentist.setEmail(email);
                dentist.setActive(active);

                showFormWithError(
                        request,
                        response,
                        dentist,
                        error,
                        "edit"
                );

                return;
            }

            dentist.setDentistName(dentistName);
            dentist.setSpecialization(specialization);
            dentist.setConsultationFee(
                    consultationFee
            );
            dentist.setPhoneNumber(phoneNumber);
            dentist.setEmail(email);
            dentist.setActive(active);

            boolean success =
                    dentistDAO.updateDentist(dentist);

            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/dentists/view?id="
                        + dentistId
                        + "&updated=1"
                );

            } else {

                showFormWithError(
                        request,
                        response,
                        dentist,
                        "Unable to update dentist.",
                        "edit"
                );
            }

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid dentist ID."
            );
        }
    }

    // =========================================================
    // VALIDATION
    // =========================================================

    private String validateDentist(
            String dentistName,
            String specialization,
            double consultationFee,
            String phoneNumber,
            String email) {

        if (dentistName.isEmpty()) {
            return "Dentist name is required.";
        }

        if (dentistName.length() < 2) {
            return "Dentist name must contain at least 2 characters.";
        }

        if (!dentistName.matches("[a-zA-Z .'-]+")) {
            return "Dentist name contains invalid characters.";
        }

        if (specialization.isEmpty()) {
            return "Specialization is required.";
        }

        if (consultationFee < 0) {
            return "Consultation fee cannot be negative.";
        }

        if (phoneNumber.isEmpty()) {
            return "Phone number is required.";
        }

        if (!phoneNumber.matches(
                "^(\\+94|0)?7[0-9]{8}$")) {

            return "Please enter a valid Sri Lankan mobile number.";
        }

        // Email is optional
        if (!email.isEmpty()) {

            if (!email.matches(
                    "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {

                return "Please enter a valid email address.";
            }
        }

        return null;
    }

    // =========================================================
    // COMMON FORM ERROR HANDLER
    // =========================================================

    private void showFormWithError(
            HttpServletRequest request,
            HttpServletResponse response,
            Dentist dentist,
            String error,
            String formMode)
            throws ServletException, IOException {

        request.setAttribute(
                "dentist",
                dentist
        );

        request.setAttribute(
                "formMode",
                formMode
        );

        request.setAttribute(
                "error",
                error
        );

        request.getRequestDispatcher(
                "/WEB-INF/views/dentists/dentist-form.jsp"
        ).forward(request, response);
    }
}
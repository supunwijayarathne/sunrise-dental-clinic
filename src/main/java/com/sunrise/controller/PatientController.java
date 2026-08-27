package com.sunrise.controller;

import java.io.IOException;
import java.util.List;

import com.sunrise.dao.PatientDAO;
import com.sunrise.model.Patient;
import com.sunrise.util.PatientCodeGenerator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/patients/*")
public class PatientController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private PatientDAO patientDAO;

    @Override
    public void init() {
        patientDAO = new PatientDAO();
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

            listPatients(request, response);

        } else if (path.equals("/add")) {

            showAddForm(request, response);

        } else if (path.equals("/view")) {

            viewPatient(request, response);

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

            addPatient(request, response);

        } else if ("/edit".equals(path)) {

            updatePatient(request, response);

        } else {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND
            );
        }
    }

    // =========================================================
    // LIST / SEARCH PATIENTS
    // =========================================================

    private void listPatients(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");

        List<Patient> patients;

        if (keyword != null && !keyword.trim().isEmpty()) {

            keyword = keyword.trim();

            patients = patientDAO.searchPatients(keyword);

        } else {

            patients = patientDAO.getAllPatients();
        }

        request.setAttribute("patients", patients);
        request.setAttribute("keyword", keyword);

        request.getRequestDispatcher(
                "/WEB-INF/views/patients/patient-list.jsp"
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
                "/WEB-INF/views/patients/patient-form.jsp"
        ).forward(request, response);
    }

    // =========================================================
    // ADD PATIENT
    // =========================================================

    private void addPatient(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String contactNumber = request.getParameter("contactNumber");
        String email = request.getParameter("email");

        // Remove unnecessary spaces
        name = name != null ? name.trim() : "";
        address = address != null ? address.trim() : "";
        contactNumber = contactNumber != null ? contactNumber.trim() : "";
        email = email != null ? email.trim() : "";

        // Validate input
        String validationError =
                validatePatient(name, address, contactNumber, email);

        if (validationError != null) {

            Patient patient = new Patient(
                    "",
                    name,
                    address,
                    contactNumber,
                    email
            );

            request.setAttribute("patient", patient);
            request.setAttribute("formMode", "add");
            request.setAttribute("error", validationError);

            request.getRequestDispatcher(
                    "/WEB-INF/views/patients/patient-form.jsp"
            ).forward(request, response);

            return;
        }

        String patientCode =
                PatientCodeGenerator.generate();

        Patient patient = new Patient(
                patientCode,
                name,
                address,
                contactNumber,
                email
        );

        boolean success =
                patientDAO.addPatient(patient);

        if (success) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/patients?success=1"
            );

        } else {

            request.setAttribute(
                    "error",
                    "Unable to register patient. Please try again."
            );

            request.setAttribute(
                    "patient",
                    patient
            );

            request.setAttribute(
                    "formMode",
                    "add"
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/patients/patient-form.jsp"
            ).forward(request, response);
        }
    }

    // =========================================================
    // VIEW PATIENT
    // =========================================================

    private void viewPatient(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int patientId =
                    Integer.parseInt(
                            request.getParameter("id")
                    );

            Patient patient =
                    patientDAO.getPatientById(patientId);

            if (patient == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Patient not found."
                );

                return;
            }

            request.setAttribute(
                    "patient",
                    patient
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/patients/patient-details.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid patient ID."
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

            int patientId =
                    Integer.parseInt(
                            request.getParameter("id")
                    );

            Patient patient =
                    patientDAO.getPatientById(patientId);

            if (patient == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Patient not found."
                );

                return;
            }

            request.setAttribute(
                    "patient",
                    patient
            );

            request.setAttribute(
                    "formMode",
                    "edit"
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/patients/patient-form.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid patient ID."
            );
        }
    }

    // =========================================================
    // UPDATE PATIENT
    // =========================================================

    private void updatePatient(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int patientId =
                    Integer.parseInt(
                            request.getParameter("patientId")
                    );

            String name =
                    request.getParameter("name");

            String address =
                    request.getParameter("address");

            String contactNumber =
                    request.getParameter("contactNumber");

            String email =
                    request.getParameter("email");

            // Remove unnecessary spaces
            name = name != null ? name.trim() : "";
            address = address != null ? address.trim() : "";
            contactNumber =
                    contactNumber != null
                    ? contactNumber.trim()
                    : "";

            email =
                    email != null
                    ? email.trim()
                    : "";

            // Validate input
            String validationError =
                    validatePatient(
                            name,
                            address,
                            contactNumber,
                            email
                    );

            Patient patient =
                    patientDAO.getPatientById(patientId);

            if (patient == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Patient not found."
                );

                return;
            }

            if (validationError != null) {

                patient.setName(name);
                patient.setAddress(address);
                patient.setContactNumber(contactNumber);
                patient.setEmail(email);

                request.setAttribute(
                        "patient",
                        patient
                );

                request.setAttribute(
                        "formMode",
                        "edit"
                );

                request.setAttribute(
                        "error",
                        validationError
                );

                request.getRequestDispatcher(
                        "/WEB-INF/views/patients/patient-form.jsp"
                ).forward(request, response);

                return;
            }

            patient.setName(name);
            patient.setAddress(address);
            patient.setContactNumber(contactNumber);
            patient.setEmail(email);

            boolean success =
                    patientDAO.updatePatient(patient);

            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/patients/view?id="
                        + patientId
                        + "&updated=1"
                );

            } else {

                request.setAttribute(
                        "error",
                        "Unable to update patient. Please try again."
                );

                request.setAttribute(
                        "patient",
                        patient
                );

                request.setAttribute(
                        "formMode",
                        "edit"
                );

                request.getRequestDispatcher(
                        "/WEB-INF/views/patients/patient-form.jsp"
                ).forward(request, response);
            }

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid patient ID."
            );
        }
    }

    // =========================================================
    // SERVER-SIDE VALIDATION
    // =========================================================

    private String validatePatient(
            String name,
            String address,
            String contactNumber,
            String email) {

        // Name
        if (name.isEmpty()) {
            return "Patient name is required.";
        }

        if (name.length() < 2) {
            return "Patient name must contain at least 2 characters.";
        }

        if (!name.matches("[a-zA-Z .'-]+")) {
            return "Patient name contains invalid characters.";
        }


        // Address
        if (address.isEmpty()) {
            return "Patient address is required.";
        }

        if (address.length() < 5) {
            return "Please enter a valid address.";
        }


        // Contact Number
        if (contactNumber.isEmpty()) {
            return "Contact number is required.";
        }

        if (!contactNumber.matches("^(\\+94|0)?7[0-9]{8}$")) {
            return "Please enter a valid Sri Lankan mobile number.";
        }


        // Email - OPTIONAL
        if (!email.isEmpty()) {

            if (!email.matches(
                    "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {

                return "Please enter a valid email address.";
            }
        }

        return null;
    }
}
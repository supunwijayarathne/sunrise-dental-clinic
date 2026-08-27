package com.sunrise.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;
import java.util.List;

import com.sunrise.dao.AppointmentDAO;
import com.sunrise.dao.DentistDAO;
import com.sunrise.dao.PatientDAO;
import com.sunrise.dao.TreatmentDAO;
import com.sunrise.model.Appointment;
import com.sunrise.model.Dentist;
import com.sunrise.model.Patient;
import com.sunrise.model.Treatment;
import com.sunrise.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/appointments/*")
public class AppointmentController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private AppointmentDAO appointmentDAO;
    private PatientDAO patientDAO;
    private DentistDAO dentistDAO;
    private TreatmentDAO treatmentDAO;


    // =========================================================
    // INITIALIZE
    // =========================================================

    @Override
    public void init() {

        appointmentDAO = new AppointmentDAO();
        patientDAO = new PatientDAO();
        dentistDAO = new DentistDAO();
        treatmentDAO = new TreatmentDAO();
    }


    // =========================================================
    // GET
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();

        if (path == null || path.equals("/")) {

            listAppointments(request, response);

        } else if (path.equals("/add")) {

            showAddForm(request, response);

        } else if (path.equals("/view")) {

            viewAppointment(request, response);

        } else if (path.equals("/edit")) {

            showEditForm(request, response);

        } else {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND
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
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String path = request.getPathInfo();

        if ("/add".equals(path)) {

            addAppointment(request, response);

        } else if ("/edit".equals(path)) {

            updateAppointment(request, response);

        } else {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND
            );
        }
    }


    // =========================================================
    // LIST / SEARCH
    // =========================================================

    private void listAppointments(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String keyword =
                request.getParameter("keyword");

        List<Appointment> appointments;

        if (keyword != null
                && !keyword.trim().isEmpty()) {

            keyword = keyword.trim();

            appointments =
                    appointmentDAO.searchAppointments(keyword);

        } else {

            appointments =
                    appointmentDAO.getAllAppointments();
        }

        request.setAttribute(
                "appointments",
                appointments
        );

        request.setAttribute(
                "keyword",
                keyword
        );

        request.getRequestDispatcher(
                "/WEB-INF/views/appointments/appointment-list.jsp"
        ).forward(request, response);
    }


    // =========================================================
    // SHOW ADD FORM
    // =========================================================

    private void showAddForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        loadFormData(request);

        request.setAttribute(
                "formMode",
                "add"
        );

        request.getRequestDispatcher(
                "/WEB-INF/views/appointments/appointment-form.jsp"
        ).forward(request, response);
    }


    // =========================================================
    // ADD APPOINTMENT
    // =========================================================

    private void addAppointment(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String appointmentNumber =
                request.getParameter("appointmentNumber");

        String patientIdText =
                request.getParameter("patientId");

        String dentistIdText =
                request.getParameter("dentistId");

        String treatmentIdText =
                request.getParameter("treatmentId");

        String dateText =
                request.getParameter("appointmentDate");

        String timeText =
                request.getParameter("appointmentTime");

        String status =
                request.getParameter("status");

        String notes =
                request.getParameter("notes");


        appointmentNumber =
                clean(appointmentNumber);

        dateText =
                clean(dateText);

        timeText =
                clean(timeText);

        status =
                clean(status);

        notes =
                clean(notes);


        int patientId;
        int dentistId;
        int treatmentId;


        try {

            patientId =
                    Integer.parseInt(patientIdText);

            dentistId =
                    Integer.parseInt(dentistIdText);

            treatmentId =
                    Integer.parseInt(treatmentIdText);

        } catch (Exception e) {

            showAddError(
                    request,
                    response,
                    "Please select a valid patient, dentist and treatment."
            );

            return;
        }


        LocalDate appointmentDate;

        LocalTime appointmentTime;


        try {

            appointmentDate =
                    LocalDate.parse(dateText);

            appointmentTime =
                    LocalTime.parse(timeText);

        } catch (DateTimeParseException e) {

            showAddError(
                    request,
                    response,
                    "Please enter a valid appointment date and time."
            );

            return;
        }


        String validationError =
                validateAppointment(
                        appointmentNumber,
                        patientId,
                        dentistId,
                        treatmentId,
                        appointmentDate,
                        appointmentTime,
                        status,
                        notes
                );


        if (validationError != null) {

            showAddError(
                    request,
                    response,
                    validationError
            );

            return;
        }


        // =====================================================
        // CHECK PATIENT EXISTS
        // =====================================================

        Patient patient =
                patientDAO.getPatientById(patientId);

        if (patient == null) {

            showAddError(
                    request,
                    response,
                    "Selected patient does not exist."
            );

            return;
        }


        // =====================================================
        // CHECK DENTIST
        // =====================================================

        Dentist dentist =
                dentistDAO.getDentistById(dentistId);

        if (dentist == null) {

            showAddError(
                    request,
                    response,
                    "Selected dentist does not exist."
            );

            return;
        }

        if (!dentist.isActive()) {

            showAddError(
                    request,
                    response,
                    "Selected dentist is currently inactive."
            );

            return;
        }


        // =====================================================
        // CHECK TREATMENT
        // =====================================================

        Treatment treatment =
                treatmentDAO.getTreatmentById(treatmentId);

        if (treatment == null) {

            showAddError(
                    request,
                    response,
                    "Selected treatment does not exist."
            );

            return;
        }

        if (!treatment.isActive()) {

            showAddError(
                    request,
                    response,
                    "Selected treatment is currently inactive."
            );

            return;
        }


        // =====================================================
        // CHECK DENTIST DOUBLE BOOKING
        // =====================================================

        boolean dentistAvailable =
                appointmentDAO.isDentistAvailable(
                        dentistId,
                        appointmentDate,
                        appointmentTime,
                        0
                );

        if (!dentistAvailable) {

            showAddError(
                    request,
                    response,
                    "This dentist already has an appointment at the selected date and time."
            );

            return;
        }


        // =====================================================
        // CHECK PATIENT DOUBLE BOOKING
        // =====================================================

        boolean patientAvailable =
                appointmentDAO.isPatientAvailable(
                        patientId,
                        appointmentDate,
                        appointmentTime,
                        0
                );

        if (!patientAvailable) {

            showAddError(
                    request,
                    response,
                    "This patient already has an appointment at the selected date and time."
            );

            return;
        }


        // =====================================================
        // CHECK APPOINTMENT NUMBER
        // =====================================================

        if (appointmentDAO.appointmentNumberExists(
                appointmentNumber,
                0)) {

            showAddError(
                    request,
                    response,
                    "Appointment number already exists."
            );

            return;
        }


        // =====================================================
        // GET LOGGED-IN USER
        // =====================================================



        HttpSession session =
                request.getSession(false);

        if (session == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login"
            );

            return;
        }

        User loggedUser =
                (User) session.getAttribute("loggedUser");

        if (loggedUser == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login"
            );

            return;
        }

        int createdBy =
                loggedUser.getUserId();


        // =====================================================
        // CREATE APPOINTMENT OBJECT
        // =====================================================

        Appointment appointment =
                new Appointment(
                        appointmentNumber,
                        patientId,
                        dentistId,
                        treatmentId,
                        appointmentDate,
                        appointmentTime,
                        status,
                        notes,
                        createdBy
                );


        boolean success =
                appointmentDAO.addAppointment(
                        appointment
                );


        if (success) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/appointments?success=1"
            );

        } else {

            showAddError(
                    request,
                    response,
                    "Unable to create appointment."
            );
        }
    }


    // =========================================================
    // VIEW
    // =========================================================

    private void viewAppointment(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int appointmentId =
                    Integer.parseInt(
                            request.getParameter("id")
                    );


            Appointment appointment =
                    appointmentDAO.getAppointmentById(
                            appointmentId
                    );


            if (appointment == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Appointment not found."
                );

                return;
            }


            request.setAttribute(
                    "appointment",
                    appointment
            );


            Patient patient =
                    patientDAO.getPatientById(
                            appointment.getPatientId()
                    );

            Dentist dentist =
                    dentistDAO.getDentistById(
                            appointment.getDentistId()
                    );

            Treatment treatment =
                    treatmentDAO.getTreatmentById(
                            appointment.getTreatmentId()
                    );


            request.setAttribute(
                    "patient",
                    patient
            );

            request.setAttribute(
                    "dentist",
                    dentist
            );

            request.setAttribute(
                    "treatment",
                    treatment
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/appointments/appointment-details.jsp"
            ).forward(request, response);


        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid appointment ID."
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

            int appointmentId =
                    Integer.parseInt(
                            request.getParameter("id")
                    );


            Appointment appointment =
                    appointmentDAO.getAppointmentById(
                            appointmentId
                    );


            if (appointment == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Appointment not found."
                );

                return;
            }


            loadFormData(request);


            request.setAttribute(
                    "appointment",
                    appointment
            );

            request.setAttribute(
                    "formMode",
                    "edit"
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/appointments/appointment-form.jsp"
            ).forward(request, response);


        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid appointment ID."
            );
        }
    }


    // =========================================================
    // UPDATE
    // =========================================================

    private void updateAppointment(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int appointmentId =
                    Integer.parseInt(
                            request.getParameter("appointmentId")
                    );


            String patientIdText =
                    request.getParameter("patientId");

            String dentistIdText =
                    request.getParameter("dentistId");

            String treatmentIdText =
                    request.getParameter("treatmentId");

            String dateText =
                    request.getParameter("appointmentDate");

            String timeText =
                    request.getParameter("appointmentTime");

            String status =
                    clean(
                            request.getParameter("status")
                    );

            String notes =
                    clean(
                            request.getParameter("notes")
                    );


            int patientId =
                    Integer.parseInt(patientIdText);

            int dentistId =
                    Integer.parseInt(dentistIdText);

            int treatmentId =
                    Integer.parseInt(treatmentIdText);


            LocalDate appointmentDate =
                    LocalDate.parse(dateText);

            LocalTime appointmentTime =
                    LocalTime.parse(timeText);


            Appointment appointment =
                    appointmentDAO.getAppointmentById(
                            appointmentId
                    );


            if (appointment == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Appointment not found."
                );

                return;
            }


            String validationError =
                    validateAppointment(
                            appointment.getAppointmentNumber(),
                            patientId,
                            dentistId,
                            treatmentId,
                            appointmentDate,
                            appointmentTime,
                            status,
                            notes
                    );


            if (validationError != null) {

                showEditError(
                        request,
                        response,
                        appointment,
                        validationError
                );

                return;
            }


            // CHECK PATIENT

            Patient patient =
                    patientDAO.getPatientById(patientId);

            if (patient == null) {

                showEditError(
                        request,
                        response,
                        appointment,
                        "Selected patient does not exist."
                );

                return;
            }


            // CHECK DENTIST

            Dentist dentist =
                    dentistDAO.getDentistById(dentistId);

            if (dentist == null) {

                showEditError(
                        request,
                        response,
                        appointment,
                        "Selected dentist does not exist."
                );

                return;
            }


            if (!dentist.isActive()) {

                showEditError(
                        request,
                        response,
                        appointment,
                        "Selected dentist is currently inactive."
                );

                return;
            }


            // CHECK TREATMENT

            Treatment treatment =
                    treatmentDAO.getTreatmentById(
                            treatmentId
                    );

            if (treatment == null) {

                showEditError(
                        request,
                        response,
                        appointment,
                        "Selected treatment does not exist."
                );

                return;
            }


            if (!treatment.isActive()) {

                showEditError(
                        request,
                        response,
                        appointment,
                        "Selected treatment is currently inactive."
                );

                return;
            }


            // CHECK DENTIST AVAILABILITY

            if (!appointmentDAO.isDentistAvailable(
                    dentistId,
                    appointmentDate,
                    appointmentTime,
                    appointmentId)) {

                showEditError(
                        request,
                        response,
                        appointment,
                        "This dentist already has another appointment at the selected date and time."
                );

                return;
            }


            // CHECK PATIENT AVAILABILITY

            if (!appointmentDAO.isPatientAvailable(
                    patientId,
                    appointmentDate,
                    appointmentTime,
                    appointmentId)) {

                showEditError(
                        request,
                        response,
                        appointment,
                        "This patient already has another appointment at the selected date and time."
                );

                return;
            }


            // UPDATE OBJECT

            appointment.setPatientId(patientId);

            appointment.setDentistId(dentistId);

            appointment.setTreatmentId(treatmentId);

            appointment.setAppointmentDate(
                    appointmentDate
            );

            appointment.setAppointmentTime(
                    appointmentTime
            );

            appointment.setStatus(status);

            appointment.setNotes(notes);


            boolean success =
                    appointmentDAO.updateAppointment(
                            appointment
                    );


            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/appointments/view?id="
                        + appointmentId
                        + "&updated=1"
                );

            } else {

                showEditError(
                        request,
                        response,
                        appointment,
                        "Unable to update appointment."
                );
            }


        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid appointment information."
            );
        }
    }


    // =========================================================
    // LOAD FORM DATA
    // =========================================================

    private void loadFormData(
            HttpServletRequest request) {

        List<Patient> patients =
                patientDAO.getAllPatients();

        List<Dentist> dentists =
                dentistDAO.getActiveDentists();

        List<Treatment> treatments =
                treatmentDAO.getActiveTreatments();


        request.setAttribute(
                "patients",
                patients
        );

        request.setAttribute(
                "dentists",
                dentists
        );

        request.setAttribute(
                "treatments",
                treatments
        );
    }


    // =========================================================
    // VALIDATION
    // =========================================================

    private String validateAppointment(
            String appointmentNumber,
            int patientId,
            int dentistId,
            int treatmentId,
            LocalDate appointmentDate,
            LocalTime appointmentTime,
            String status,
            String notes) {


        if (appointmentNumber == null
                || appointmentNumber.isEmpty()) {

            return "Appointment number is required.";
        }


        if (appointmentNumber.length() > 30) {

            return "Appointment number cannot exceed 30 characters.";
        }


        if (patientId <= 0) {

            return "Please select a patient.";
        }


        if (dentistId <= 0) {

            return "Please select a dentist.";
        }


        if (treatmentId <= 0) {

            return "Please select a treatment.";
        }


        if (appointmentDate == null) {

            return "Appointment date is required.";
        }


        if (appointmentTime == null) {

            return "Appointment time is required.";
        }


        if (appointmentDate.isBefore(
                LocalDate.now())) {

            return "Appointment date cannot be in the past.";
        }


        if (status == null
                || status.isEmpty()) {

            return "Appointment status is required.";
        }


        if (!status.equals("SCHEDULED")
                && !status.equals("COMPLETED")
                && !status.equals("CANCELLED")
                && !status.equals("NO_SHOW")
                && !status.equals("BILLED")) {

            return "Invalid appointment status.";
        }


        if (notes != null
                && notes.length() > 500) {

            return "Notes cannot exceed 500 characters.";
        }


        return null;
    }


    // =========================================================
    // CLEAN STRING
    // =========================================================

    private String clean(String value) {

        if (value == null) {

            return "";
        }

        return value.trim();
    }


    // =========================================================
    // ADD FORM ERROR
    // =========================================================

    private void showAddError(
            HttpServletRequest request,
            HttpServletResponse response,
            String error)
            throws ServletException, IOException {

        loadFormData(request);

        request.setAttribute(
                "formMode",
                "add"
        );

        request.setAttribute(
                "error",
                error
        );

        request.getRequestDispatcher(
                "/WEB-INF/views/appointments/appointment-form.jsp"
        ).forward(request, response);
    }


    // =========================================================
    // EDIT FORM ERROR
    // =========================================================

    private void showEditError(
            HttpServletRequest request,
            HttpServletResponse response,
            Appointment appointment,
            String error)
            throws ServletException, IOException {

        loadFormData(request);

        request.setAttribute(
                "appointment",
                appointment
        );

        request.setAttribute(
                "formMode",
                "edit"
        );

        request.setAttribute(
                "error",
                error
        );

        request.getRequestDispatcher(
                "/WEB-INF/views/appointments/appointment-form.jsp"
        ).forward(request, response);
    }
}
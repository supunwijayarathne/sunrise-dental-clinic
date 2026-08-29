package com.sunrise.controller;

import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

import com.sunrise.dao.AppointmentDAO;
import com.sunrise.dao.DentistDAO;
import com.sunrise.dao.DentistScheduleDAO;
import com.sunrise.dao.PatientDAO;
import com.sunrise.dao.TreatmentDAO;

import com.sunrise.model.Appointment;
import com.sunrise.model.Dentist;
import com.sunrise.model.DentistSchedule;
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
    private DentistScheduleDAO dentistScheduleDAO;


    @Override
    public void init() {

        appointmentDAO =
                new AppointmentDAO();

        patientDAO =
                new PatientDAO();

        dentistDAO =
                new DentistDAO();

        treatmentDAO =
                new TreatmentDAO();

        dentistScheduleDAO =
                new DentistScheduleDAO();
    }


    // =========================================================
    // GET
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String path =
                request.getPathInfo();


        if (path == null || path.equals("/")) {

            listAppointments(
                    request,
                    response
            );


        } else if (path.equals("/add")) {

            showAddForm(
                    request,
                    response
            );


        } else if (path.equals("/view")) {

            viewAppointment(
                    request,
                    response
            );


        } else if (path.equals("/edit")) {

            showEditForm(
                    request,
                    response
            );


        } else if (path.equals("/slots")) {

            getAvailableSlots(
                    request,
                    response
            );


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

        String path =
                request.getPathInfo();


        if ("/add".equals(path)) {

            addAppointment(
                    request,
                    response
            );


        } else if ("/edit".equals(path)) {

            updateAppointment(
                    request,
                    response
            );


        } else {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND
            );
        }
    }


    // =========================================================
    // AVAILABLE TIME SLOTS
    // =========================================================

    private void getAvailableSlots(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        response.setContentType(
                "application/json"
        );

        response.setCharacterEncoding(
                "UTF-8"
        );


        String dentistText =
                request.getParameter("dentistId");

        String dateText =
                request.getParameter("appointmentDate");

        String appointmentText =
                request.getParameter("appointmentId");


        int dentistId;
        int appointmentId = 0;


        try {

            dentistId =
                    Integer.parseInt(dentistText);

            if (appointmentText != null
                    && !appointmentText.trim().isEmpty()) {

                appointmentId =
                        Integer.parseInt(
                                appointmentText
                        );
            }

        } catch (Exception e) {

            writeJson(
                    response,
                    false,
                    "Invalid dentist."
            );

            return;
        }


        LocalDate appointmentDate;


        try {

            appointmentDate =
                    LocalDate.parse(dateText);

        } catch (Exception e) {

            writeJson(
                    response,
                    false,
                    "Please select a valid date."
            );

            return;
        }


        if (appointmentDate.isBefore(
                LocalDate.now())) {

            writeJson(
                    response,
                    false,
                    "Please select today or a future date."
            );

            return;
        }


        // =====================================================
        // GET DAY OF WEEK
        // =====================================================

        DayOfWeek dayOfWeek =
                appointmentDate.getDayOfWeek();


        String dayName =
                dayOfWeek.name();


        // =====================================================
        // GET DENTIST SCHEDULE
        // =====================================================

        List<DentistSchedule> schedules =
                dentistScheduleDAO
                    .getSchedulesByDentistAndDay(
                        dentistId,
                        dayName
                    );


        if (schedules == null
                || schedules.isEmpty()) {

            writeJson(
                    response,
                    true,
                    "No working hours are configured for this dentist on "
                    + capitalize(dayName)
                    + ". Please select another date."
            );

            return;
        }


        // =====================================================
        // GET BOOKED TIMES
        // =====================================================

        List<LocalTime> bookedTimes =
                appointmentDAO.getBookedTimes(
                        dentistId,
                        appointmentDate,
                        appointmentId
                );


        List<String> slots =
                new ArrayList<>();


        DateTimeFormatter displayFormatter =
                DateTimeFormatter.ofPattern(
                        "hh:mm a"
                );


        // =====================================================
        // GENERATE SLOTS
        // =====================================================

        for (DentistSchedule schedule : schedules) {

            LocalTime current =
                    schedule.getStartTime();

            LocalTime end =
                    schedule.getEndTime();

            int duration =
                    schedule.getSlotDuration();


            if (duration <= 0) {

                duration = 30;
            }


            while (
                !current.plusMinutes(duration)
                    .isAfter(end)
            ) {

                LocalTime slotEnd =
                        current.plusMinutes(duration);


                /*
                 * We use the START time as the
                 * appointment time.
                 */

                if (!bookedTimes.contains(current)) {

                    String timeValue =
                            current.toString();


                    String displayTime =
                            current.format(
                                    displayFormatter
                            );


                    slots.add(
                            "{"
                            + "\"value\":\""
                            + escapeJson(timeValue)
                            + "\","
                            + "\"label\":\""
                            + escapeJson(displayTime)
                            + "\""
                            + "}"
                    );
                }


                current =
                        slotEnd;
            }
        }


        if (slots.isEmpty()) {

            writeJson(
                    response,
                    true,
                    "All available times are already booked for this date. Please select another date."
            );

            return;
        }


        StringBuilder json =
                new StringBuilder();


        json.append("{");

        json.append("\"available\":true,");

        json.append("\"message\":\"\",");

        json.append("\"slots\":[");


        for (int i = 0;
             i < slots.size();
             i++) {

            if (i > 0) {

                json.append(",");
            }

            json.append(
                    slots.get(i)
            );
        }


        json.append("]");

        json.append("}");


        response.getWriter()
                .write(
                        json.toString()
                );
    }


    // =========================================================
    // JSON RESPONSE
    // =========================================================

    private void writeJson(
            HttpServletResponse response,
            boolean available,
            String message)
            throws IOException {

        String json =
                "{"
                + "\"available\":"
                + available
                + ","
                + "\"message\":\""
                + escapeJson(message)
                + "\","
                + "\"slots\":[]"
                + "}";


        response.getWriter()
                .write(json);
    }


    private String escapeJson(
            String value) {

        if (value == null) {

            return "";
        }

        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\r", "")
                .replace("\n", "\\n");
    }


    private String capitalize(
            String value) {

        if (value == null
                || value.isEmpty()) {

            return value;
        }

        return value.substring(0, 1)
                + value.substring(1)
                    .toLowerCase();
    }


    // =========================================================
    // LIST
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

            keyword =
                    keyword.trim();

            appointments =
                    appointmentDAO
                        .searchAppointments(
                            keyword
                        );

        } else {

            appointments =
                    appointmentDAO
                        .getAllAppointments();
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
        ).forward(
                request,
                response
        );
    }


    // =========================================================
    // SHOW ADD
    // =========================================================

    private void showAddForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        loadFormData(request);


        String generatedAppointmentNumber =
                appointmentDAO
                    .generateNextAppointmentNumber();


        request.setAttribute(
                "generatedAppointmentNumber",
                generatedAppointmentNumber
        );


        request.setAttribute(
                "formMode",
                "add"
        );


        request.getRequestDispatcher(
                "/WEB-INF/views/appointments/appointment-form.jsp"
        ).forward(
                request,
                response
        );
    }


    // =========================================================
    // ADD
    // =========================================================

    private void addAppointment(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String appointmentNumber =
                clean(
                    request.getParameter(
                        "appointmentNumber"
                    )
                );


        String patientIdText =
                request.getParameter(
                        "patientId"
                );


        String dentistIdText =
                request.getParameter(
                        "dentistId"
                );


        String treatmentIdText =
                request.getParameter(
                        "treatmentId"
                );


        String dateText =
                clean(
                    request.getParameter(
                        "appointmentDate"
                    )
                );


        String timeText =
                clean(
                    request.getParameter(
                        "appointmentTime"
                    )
                );


        String status =
                clean(
                    request.getParameter(
                        "status"
                    )
                );


        String notes =
                clean(
                    request.getParameter(
                        "notes"
                    )
                );


        int patientId;
        int dentistId;
        int treatmentId;


        try {

            patientId =
                    Integer.parseInt(
                            patientIdText
                    );

            dentistId =
                    Integer.parseInt(
                            dentistIdText
                    );

            treatmentId =
                    Integer.parseInt(
                            treatmentIdText
                    );

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
                    LocalDate.parse(
                            dateText
                    );

            appointmentTime =
                    LocalTime.parse(
                            timeText
                    );

        } catch (DateTimeParseException e) {

            showAddError(
                    request,
                    response,
                    "Please select a valid appointment date and time."
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
        // VERIFY SELECTED TIME IS IN DENTIST SCHEDULE
        // =====================================================

        if (!isWithinDentistSchedule(
                dentistId,
                appointmentDate,
                appointmentTime)) {

            showAddError(
                    request,
                    response,
                    "The selected time is not available in this dentist's schedule."
            );

            return;
        }


        Patient patient =
                patientDAO.getPatientById(
                        patientId
                );


        if (patient == null) {

            showAddError(
                    request,
                    response,
                    "Selected patient does not exist."
            );

            return;
        }


        Dentist dentist =
                dentistDAO.getDentistById(
                        dentistId
                );


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


        Treatment treatment =
                treatmentDAO.getTreatmentById(
                        treatmentId
                );


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


        if (!appointmentDAO.isDentistAvailable(
                dentistId,
                appointmentDate,
                appointmentTime,
                0)) {

            showAddError(
                    request,
                    response,
                    "This time has just been booked. Please select another time."
            );

            return;
        }


        if (!appointmentDAO.isPatientAvailable(
                patientId,
                appointmentDate,
                appointmentTime,
                0)) {

            showAddError(
                    request,
                    response,
                    "This patient already has an appointment at the selected date and time."
            );

            return;
        }


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
                (User) session.getAttribute(
                        "loggedUser"
                );


        if (loggedUser == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login"
            );

            return;
        }


        int createdBy =
                loggedUser.getUserId();


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
    // CHECK TIME AGAINST DENTIST SCHEDULE
    // =========================================================

    private boolean isWithinDentistSchedule(
            int dentistId,
            LocalDate date,
            LocalTime selectedTime) {

        String day =
                date.getDayOfWeek()
                    .name();


        List<DentistSchedule> schedules =
                dentistScheduleDAO
                    .getSchedulesByDentistAndDay(
                        dentistId,
                        day
                    );


        for (DentistSchedule schedule
                : schedules) {

            LocalTime current =
                    schedule.getStartTime();

            LocalTime end =
                    schedule.getEndTime();

            int duration =
                    schedule.getSlotDuration();


            if (duration <= 0) {

                duration = 30;
            }


            while (
                !current.plusMinutes(duration)
                    .isAfter(end)
            ) {

                if (current.equals(
                        selectedTime)) {

                    return true;
                }


                current =
                        current.plusMinutes(
                                duration
                        );
            }
        }


        return false;
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
                            request.getParameter(
                                    "id"
                            )
                    );


            Appointment appointment =
                    appointmentDAO
                        .getAppointmentById(
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


            request.setAttribute(
                    "patient",
                    patientDAO.getPatientById(
                            appointment.getPatientId()
                    )
            );


            request.setAttribute(
                    "dentist",
                    dentistDAO.getDentistById(
                            appointment.getDentistId()
                    )
            );


            request.setAttribute(
                    "treatment",
                    treatmentDAO.getTreatmentById(
                            appointment.getTreatmentId()
                    )
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/appointments/appointment-details.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid appointment ID."
            );
        }
    }


    // =========================================================
    // EDIT FORM
    // =========================================================

    private void showEditForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int appointmentId =
                    Integer.parseInt(
                            request.getParameter(
                                    "id"
                            )
                    );


            Appointment appointment =
                    appointmentDAO
                        .getAppointmentById(
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
            ).forward(
                    request,
                    response
            );


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
                            request.getParameter(
                                    "appointmentId"
                            )
                    );


            int patientId =
                    Integer.parseInt(
                            request.getParameter(
                                    "patientId"
                            )
                    );


            int dentistId =
                    Integer.parseInt(
                            request.getParameter(
                                    "dentistId"
                            )
                    );


            int treatmentId =
                    Integer.parseInt(
                            request.getParameter(
                                    "treatmentId"
                            )
                    );


            LocalDate appointmentDate =
                    LocalDate.parse(
                            request.getParameter(
                                    "appointmentDate"
                            )
                    );


            LocalTime appointmentTime =
                    LocalTime.parse(
                            request.getParameter(
                                    "appointmentTime"
                            )
                    );


            String status =
                    clean(
                        request.getParameter(
                            "status"
                        )
                    );


            String notes =
                    clean(
                        request.getParameter(
                            "notes"
                        )
                    );


            Appointment appointment =
                    appointmentDAO
                        .getAppointmentById(
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


            if (!isWithinDentistSchedule(
                    dentistId,
                    appointmentDate,
                    appointmentTime)) {

                showEditError(
                        request,
                        response,
                        appointment,
                        "The selected time is not available in this dentist's schedule."
                );

                return;
            }


            Patient patient =
                    patientDAO.getPatientById(
                            patientId
                    );


            if (patient == null) {

                showEditError(
                        request,
                        response,
                        appointment,
                        "Selected patient does not exist."
                );

                return;
            }


            Dentist dentist =
                    dentistDAO.getDentistById(
                            dentistId
                    );


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


            appointment.setPatientId(
                    patientId
            );

            appointment.setDentistId(
                    dentistId
            );

            appointment.setTreatmentId(
                    treatmentId
            );

            appointment.setAppointmentDate(
                    appointmentDate
            );

            appointment.setAppointmentTime(
                    appointmentTime
            );

            appointment.setStatus(
                    status
            );

            appointment.setNotes(
                    notes
            );


            boolean success =
                    appointmentDAO
                        .updateAppointment(
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

        request.setAttribute(
                "patients",
                patientDAO.getAllPatients()
        );

        request.setAttribute(
                "dentists",
                dentistDAO.getActiveDentists()
        );

        request.setAttribute(
                "treatments",
                treatmentDAO.getActiveTreatments()
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
    // CLEAN
    // =========================================================

    private String clean(String value) {

        if (value == null) {

            return "";
        }

        return value.trim();
    }


    // =========================================================
    // ADD ERROR
    // =========================================================

    private void showAddError(
            HttpServletRequest request,
            HttpServletResponse response,
            String error)
            throws ServletException, IOException {

        loadFormData(request);


        request.setAttribute(
                "generatedAppointmentNumber",
                appointmentDAO
                    .generateNextAppointmentNumber()
        );


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
        ).forward(
                request,
                response
        );
    }


    // =========================================================
    // EDIT ERROR
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
        ).forward(
                request,
                response
        );
    }
}
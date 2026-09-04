package com.sunrise.api;

import java.io.BufferedReader;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sunrise.model.Appointment;
import com.sunrise.service.AppointmentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/api/appointments/*")
public class AppointmentApi extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private AppointmentService appointmentService;

    // =========================================================
    // INITIALIZE
    // =========================================================

    @Override
    public void init() {

        appointmentService =
                new AppointmentService();
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
    // GET
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        ApiUtil.json(response);
        ApiUtil.cors(response);

        try {

            String path =
                    request.getPathInfo();

            String keyword =
                    request.getParameter(
                            "keyword"
                    );

            String dentistId =
                    request.getParameter(
                            "dentistId"
                    );

            String patientId =
                    request.getParameter(
                            "patientId"
                    );

            String date =
                    request.getParameter(
                            "date"
                    );

            // =================================================
            // AVAILABLE SLOTS
            // =================================================

            if ("/available-slots".equals(path)) {

                availableSlots(
                        dentistId,
                        date,
                        response
                );

                return;
            }

            // =================================================
            // SEARCH
            // =================================================

            if (!ApiUtil.blank(keyword)) {

                response.getWriter().write(
                        list(
                                appointmentService
                                        .searchAppointments(
                                                keyword.trim()
                                        )
                        )
                );

                return;
            }

            // =================================================
            // BY PATIENT
            // =================================================

            if (!ApiUtil.blank(patientId)) {

                int id =
                        Integer.parseInt(
                                patientId
                        );

                response.getWriter().write(
                        list(
                                appointmentService
                                        .getAppointmentsByPatient(
                                                id
                                        )
                        )
                );

                return;
            }

            // =================================================
            // BY DENTIST
            // =================================================

            if (!ApiUtil.blank(dentistId)) {

                int id =
                        Integer.parseInt(
                                dentistId
                        );

                response.getWriter().write(
                        list(
                                appointmentService
                                        .getAppointmentsByDentist(
                                                id
                                        )
                        )
                );

                return;
            }

            // =================================================
            // TODAY
            // =================================================

            if ("/today".equals(path)) {

                response.getWriter().write(
                        list(
                                appointmentService
                                        .getTodayAppointments()
                        )
                );

                return;
            }

            // =================================================
            // ALL
            // =================================================

            if (path == null
                    || "/".equals(path)
                    || path.isEmpty()) {

                response.getWriter().write(
                        list(
                                appointmentService
                                        .getAllAppointments()
                        )
                );

                return;
            }

            // =================================================
            // BY ID
            // =================================================

            int appointmentId =
                    Integer.parseInt(
                            path.substring(1)
                    );

            Appointment appointment =
                    appointmentService
                            .getAppointmentById(
                                    appointmentId
                            );

            if (appointment == null) {

                ApiUtil.error(
                        response,
                        404,
                        "Appointment not found"
                );

                return;
            }

            response.getWriter().write(
                    one(appointment)
            );

        } catch (NumberFormatException e) {

            ApiUtil.error(
                    response,
                    400,
                    "Invalid appointment, dentist or patient ID"
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
    // AVAILABLE SLOTS
    // =========================================================

    private void availableSlots(
            String dentistIdValue,
            String dateValue,
            HttpServletResponse response)
            throws IOException {

        if (ApiUtil.blank(dentistIdValue)
                || ApiUtil.blank(dateValue)) {

            ApiUtil.error(
                    response,
                    400,
                    "dentistId and date are required"
            );

            return;
        }

        try {

            int dentistId =
                    Integer.parseInt(
                            dentistIdValue
                    );

            LocalDate date =
                    LocalDate.parse(
                            dateValue
                    );

            List<LocalTime> slots =
                    appointmentService
                            .getAvailableSlots(
                                    dentistId,
                                    date
                            );

            StringBuilder json =
                    new StringBuilder();

            json.append("{");

            json.append("\"date\":")
                .append(
                        ApiUtil.str(
                                date.toString()
                        )
                );

            json.append(",\"dentistId\":")
                .append(dentistId);

            json.append(",\"slots\":[");

            for (int i = 0;
                 i < slots.size();
                 i++) {

                if (i > 0) {
                    json.append(",");
                }

                json.append(
                        ApiUtil.str(
                                slots.get(i)
                                      .toString()
                        )
                );
            }

            json.append("]}");

            response.getWriter().write(
                    json.toString()
            );

        } catch (DateTimeParseException e) {

            ApiUtil.error(
                    response,
                    400,
                    "Date must be yyyy-MM-dd"
            );

        } catch (NumberFormatException e) {

            ApiUtil.error(
                    response,
                    400,
                    "Invalid dentist ID"
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

        try {

            // =================================================
            // READ FORM BODY
            // =================================================

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

            Map<String, String> params =
                    parseFormData(
                            body.toString()
                    );

            // =================================================
            // PARAMETERS
            // =================================================

            String patientId =
                    params.get(
                            "patientId"
                    );

            String dentistId =
                    params.get(
                            "dentistId"
                    );

            String treatmentId =
                    params.get(
                            "treatmentId"
                    );

            String appointmentDate =
                    params.get(
                            "appointmentDate"
                    );

            String appointmentTime =
                    params.get(
                            "appointmentTime"
                    );

            String status =
                    params.get(
                            "status"
                    );

            String notes =
                    params.get(
                            "notes"
                    );

            // =================================================
            // REQUIRED FIELDS
            // =================================================

            if (ApiUtil.blank(patientId)
                    || ApiUtil.blank(dentistId)
                    || ApiUtil.blank(treatmentId)
                    || ApiUtil.blank(appointmentDate)
                    || ApiUtil.blank(appointmentTime)) {

                ApiUtil.error(
                        response,
                        400,
                        "patientId, dentistId, treatmentId, appointmentDate and appointmentTime are required"
                );

                return;
            }

            // =================================================
            // PARSE VALUES
            // =================================================

            int patient =
                    Integer.parseInt(
                            patientId
                    );

            int dentist =
                    Integer.parseInt(
                            dentistId
                    );

            int treatment =
                    Integer.parseInt(
                            treatmentId
                    );

            LocalDate date =
                    LocalDate.parse(
                            appointmentDate
                    );

            LocalTime time =
                    LocalTime.parse(
                            appointmentTime
                    );

            // =================================================
            // AUTHENTICATION
            // =================================================

            HttpSession session =
                    request.getSession(false);

            if (session == null
                    || session.getAttribute(
                            "userId"
                       ) == null) {

                ApiUtil.error(
                        response,
                        401,
                        "User is not authenticated"
                );

                return;
            }

            Object userIdObject =
                    session.getAttribute(
                            "userId"
                    );

            int createdBy;

            if (userIdObject instanceof Integer) {

                createdBy =
                        (Integer) userIdObject;

            } else {

                createdBy =
                        Integer.parseInt(
                                userIdObject.toString()
                        );
            }

            // =================================================
            // BUILD APPOINTMENT
            // =================================================

            Appointment appointment =
                    new Appointment();

            appointment.setPatientId(
                    patient
            );

            appointment.setDentistId(
                    dentist
            );

            appointment.setTreatmentId(
                    treatment
            );

            appointment.setAppointmentDate(
                    date
            );

            appointment.setAppointmentTime(
                    time
            );

            appointment.setStatus(
                    ApiUtil.blank(status)
                            ? "SCHEDULED"
                            : status
            );

            appointment.setNotes(
                    notes
            );

            appointment.setCreatedBy(
                    createdBy
            );

            // =================================================
            // CREATE THROUGH SERVICE
            // =================================================

            if (appointmentService
                    .createAppointment(
                            appointment
                    )) {

                response.setStatus(
                        HttpServletResponse.SC_CREATED
                );

                response.getWriter().write(
                        one(appointment)
                );

                return;
            }

            // =================================================
            // DETERMINE CONFLICT
            // =================================================

            if (!appointmentService
                    .isDentistAvailable(
                            dentist,
                            date,
                            time,
                            0
                    )) {

                ApiUtil.error(
                        response,
                        409,
                        "That time is already booked for this dentist"
                );

                return;
            }

            if (!appointmentService
                    .isPatientAvailable(
                            patient,
                            date,
                            time,
                            0
                    )) {

                ApiUtil.error(
                        response,
                        409,
                        "The patient already has an appointment at that time"
                );

                return;
            }

            ApiUtil.error(
                    response,
                    400,
                    "Appointment could not be created"
            );

        } catch (DateTimeParseException e) {

            ApiUtil.error(
                    response,
                    400,
                    "Invalid appointment date or time"
            );

        } catch (NumberFormatException e) {

            ApiUtil.error(
                    response,
                    400,
                    "Invalid appointment numeric value"
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

        try {

            String path =
                    request.getPathInfo();

            if (path == null
                    || "/".equals(path)) {

                ApiUtil.error(
                        response,
                        400,
                        "Appointment ID is required"
                );

                return;
            }

            int appointmentId =
                    Integer.parseInt(
                            path.substring(1)
                    );

            Appointment appointment =
                    appointmentService
                            .getAppointmentById(
                                    appointmentId
                            );

            if (appointment == null) {

                ApiUtil.error(
                        response,
                        404,
                        "Appointment not found"
                );

                return;
            }

            // =================================================
            // READ BODY
            // =================================================

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

            Map<String, String> params =
                    parseFormData(
                            body.toString()
                    );

            // =================================================
            // UPDATE PATIENT
            // =================================================

            String patientId =
                    params.get(
                            "patientId"
                    );

            if (!ApiUtil.blank(patientId)) {

                appointment.setPatientId(
                        Integer.parseInt(
                                patientId
                        )
                );
            }

            // =================================================
            // UPDATE DENTIST
            // =================================================

            String dentistId =
                    params.get(
                            "dentistId"
                    );

            if (!ApiUtil.blank(dentistId)) {

                appointment.setDentistId(
                        Integer.parseInt(
                                dentistId
                        )
                );
            }

            // =================================================
            // UPDATE TREATMENT
            // =================================================

            String treatmentId =
                    params.get(
                            "treatmentId"
                    );

            if (!ApiUtil.blank(treatmentId)) {

                appointment.setTreatmentId(
                        Integer.parseInt(
                                treatmentId
                        )
                );
            }

            // =================================================
            // UPDATE DATE
            // =================================================

            String date =
                    params.get(
                            "appointmentDate"
                    );

            if (!ApiUtil.blank(date)) {

                appointment.setAppointmentDate(
                        LocalDate.parse(
                                date
                        )
                );
            }

            // =================================================
            // UPDATE TIME
            // =================================================

            String time =
                    params.get(
                            "appointmentTime"
                    );

            if (!ApiUtil.blank(time)) {

                appointment.setAppointmentTime(
                        LocalTime.parse(
                                time
                        )
                );
            }

            // =================================================
            // UPDATE STATUS
            // =================================================

            String status =
                    params.get(
                            "status"
                    );

            if (status != null) {

                appointment.setStatus(
                        status.trim()
                );
            }

            // =================================================
            // UPDATE NOTES
            // =================================================

            String notes =
                    params.get(
                            "notes"
                    );

            if (notes != null) {

                appointment.setNotes(
                        notes.trim()
                );
            }

            // =================================================
            // UPDATE THROUGH SERVICE
            // =================================================

            if (appointmentService
                    .updateAppointment(
                            appointment
                    )) {

                response.getWriter().write(
                        one(appointment)
                );

                return;
            }

            // =================================================
            // DETERMINE CONFLICT
            // =================================================

            if (!appointmentService
                    .isDentistAvailable(
                            appointment.getDentistId(),
                            appointment.getAppointmentDate(),
                            appointment.getAppointmentTime(),
                            appointment.getAppointmentId()
                    )) {

                ApiUtil.error(
                        response,
                        409,
                        "That time is already booked for this dentist"
                );

                return;
            }

            if (!appointmentService
                    .isPatientAvailable(
                            appointment.getPatientId(),
                            appointment.getAppointmentDate(),
                            appointment.getAppointmentTime(),
                            appointment.getAppointmentId()
                    )) {

                ApiUtil.error(
                        response,
                        409,
                        "The patient already has an appointment at that time"
                );

                return;
            }

            ApiUtil.error(
                    response,
                    400,
                    "Appointment could not be updated"
            );

        } catch (NumberFormatException e) {

            ApiUtil.error(
                    response,
                    400,
                    "Invalid appointment ID or numeric value"
            );

        } catch (DateTimeParseException e) {

            ApiUtil.error(
                    response,
                    400,
                    "Invalid appointment date or time"
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

        try {

            String path =
                    request.getPathInfo();

            if (path == null
                    || "/".equals(path)) {

                ApiUtil.error(
                        response,
                        400,
                        "Appointment ID is required"
                );

                return;
            }

            int appointmentId =
                    Integer.parseInt(
                            path.substring(1)
                    );

            Appointment appointment =
                    appointmentService
                            .getAppointmentById(
                                    appointmentId
                            );

            if (appointment == null) {

                ApiUtil.error(
                        response,
                        404,
                        "Appointment not found"
                );

                return;
            }

            // =================================================
            // READ PATCH BODY
            // =================================================

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

            Map<String, String> params =
                    parseFormData(
                            body.toString()
                    );

            // =================================================
            // STATUS
            // =================================================

            String status =
                    params.get(
                            "status"
                    );

            if (!ApiUtil.blank(status)) {

                appointment.setStatus(
                        status.trim()
                );
            }

            // =================================================
            // NOTES
            // =================================================

            String notes =
                    params.get(
                            "notes"
                    );

            if (notes != null) {

                appointment.setNotes(
                        notes.trim()
                );
            }

            // =================================================
            // UPDATE
            // =================================================

            if (appointmentService
                    .patchAppointment(
                            appointment
                    )) {

                response.getWriter().write(
                        one(appointment)
                );

            } else {

                ApiUtil.error(
                        response,
                        400,
                        "Appointment could not be updated"
                );
            }

        } catch (NumberFormatException e) {

            ApiUtil.error(
                    response,
                    400,
                    "Invalid appointment ID"
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
            List<Appointment> appointments) {

        StringBuilder json =
                new StringBuilder("[");

        for (int i = 0;
             i < appointments.size();
             i++) {

            if (i > 0) {
                json.append(",");
            }

            json.append(
                    one(
                            appointments.get(i)
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
            Appointment appointment) {

        return "{"

                + "\"appointmentId\":"
                + appointment.getAppointmentId()

                + ",\"appointmentNumber\":"
                + ApiUtil.str(
                        appointment
                                .getAppointmentNumber()
                  )

                + ",\"patientId\":"
                + appointment.getPatientId()

                + ",\"dentistId\":"
                + appointment.getDentistId()

                + ",\"treatmentId\":"
                + appointment.getTreatmentId()

                + ",\"appointmentDate\":"
                + ApiUtil.date(
                        appointment
                                .getAppointmentDate()
                  )

                + ",\"appointmentTime\":"
                + ApiUtil.time(
                        appointment
                                .getAppointmentTime()
                  )

                + ",\"status\":"
                + ApiUtil.str(
                        appointment.getStatus()
                  )

                + ",\"notes\":"
                + ApiUtil.nullable(
                        appointment.getNotes()
                  )

                + ",\"createdBy\":"
                + appointment.getCreatedBy()

                + "}";
    }
}
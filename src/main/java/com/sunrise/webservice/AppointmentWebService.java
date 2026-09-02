package com.sunrise.webservice;
import java.util.List;

import com.sunrise.dao.AppointmentDAO;
import com.sunrise.model.Appointment;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/api/appointments/*")
public class AppointmentWebService extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private AppointmentDAO appointmentDAO;

    @Override
    public void init() {
        appointmentDAO = new AppointmentDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String path = request.getPathInfo();

        try {

            // GET /api/appointments
            if (path == null || path.equals("/")) {

                List<Appointment> appointments =
                        appointmentDAO.getAllAppointments();

                response.getWriter().write(
                        appointmentsToJson(appointments)
                );

                return;
            }

            // GET /api/appointments/{id}
            String idValue = path.substring(1);

            int appointmentId =
                    Integer.parseInt(idValue);

            Appointment appointment =
                    appointmentDAO.getAppointmentById(
                            appointmentId
                    );

            if (appointment == null) {

                response.setStatus(
                        HttpServletResponse.SC_NOT_FOUND
                );

                response.getWriter().write(
                        "{\"success\":false,\"message\":\"Appointment not found\"}"
                );

                return;
            }

            response.getWriter().write(
                    appointmentToJson(appointment)
            );

        } catch (NumberFormatException e) {

            response.setStatus(
                    HttpServletResponse.SC_BAD_REQUEST
            );

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"Invalid appointment ID\"}"
            );

        } catch (Exception e) {

            response.setStatus(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR
            );

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"Server error\"}"
            );
        }
    }

    private String appointmentsToJson(
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
                    appointmentToJson(
                            appointments.get(i)
                    )
            );
        }

        json.append("]");

        return json.toString();
    }

    private String appointmentToJson(
            Appointment a) {

        return "{"
                + "\"appointmentId\":"
                + a.getAppointmentId()
                + ","
                + "\"appointmentNumber\":\""
                + escape(a.getAppointmentNumber())
                + "\","
                + "\"patientId\":"
                + a.getPatientId()
                + ","
                + "\"dentistId\":"
                + a.getDentistId()
                + ","
                + "\"treatmentId\":"
                + a.getTreatmentId()
                + ","
                + "\"appointmentDate\":\""
                + a.getAppointmentDate()
                + "\","
                + "\"appointmentTime\":\""
                + a.getAppointmentTime()
                + "\","
                + "\"status\":\""
                + escape(a.getStatus())
                + "\""
                + "}";
    }

    private String escape(String value) {

        if (value == null) {
            return "";
        }

        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"");
    }
}
package com.sunrise.webservice;

import java.io.IOException;
import java.util.List;

import com.sunrise.dao.PatientDAO;
import com.sunrise.model.Patient;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/api/patients/*")
public class PatientWebService extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private PatientDAO patientDAO;

    @Override
    public void init() {
        patientDAO = new PatientDAO();
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

            String keyword =
                    request.getParameter("keyword");

            if (keyword != null &&
                !keyword.trim().isEmpty()) {

                List<Patient> patients =
                        patientDAO.searchPatients(
                                keyword.trim()
                        );

                response.getWriter().write(
                        patientsToJson(patients)
                );

                return;
            }

            if (path == null || path.equals("/")) {

                List<Patient> patients =
                        patientDAO.getAllPatients();

                response.getWriter().write(
                        patientsToJson(patients)
                );

                return;
            }

            int patientId =
                    Integer.parseInt(
                            path.substring(1)
                    );

            Patient patient =
                    patientDAO.getPatientById(
                            patientId
                    );

            if (patient == null) {

                response.setStatus(404);

                response.getWriter().write(
                        "{\"success\":false,\"message\":\"Patient not found\"}"
                );

                return;
            }

            response.getWriter().write(
                    patientToJson(patient)
            );

        } catch (NumberFormatException e) {

            response.setStatus(400);

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"Invalid patient ID\"}"
            );

        } catch (Exception e) {

            response.setStatus(500);

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"Server error\"}"
            );
        }
    }

    private String patientsToJson(
            List<Patient> patients) {

        StringBuilder json =
                new StringBuilder("[");

        for (int i = 0;
             i < patients.size();
             i++) {

            if (i > 0) {
                json.append(",");
            }

            json.append(
                    patientToJson(
                            patients.get(i)
                    )
            );
        }

        json.append("]");

        return json.toString();
    }

    private String patientToJson(
            Patient p) {

        return "{"
                + "\"patientId\":"
                + p.getPatientId()
                + ","
                + "\"patientCode\":\""
                + escape(p.getPatientCode())
                + "\","
                + "\"name\":\""
                + escape(p.getName())
                + "\","
                + "\"contactNumber\":\""
                + escape(p.getContactNumber())
                + "\","
                + "\"email\":\""
                + escape(p.getEmail())
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
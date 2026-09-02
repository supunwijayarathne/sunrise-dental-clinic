package com.sunrise.webservice;

import java.io.IOException;
import java.util.List;

import com.sunrise.dao.DentistDAO;
import com.sunrise.model.Dentist;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/api/dentists/*")
public class DentistWebService extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private DentistDAO dentistDAO;

    @Override
    public void init() {
        dentistDAO = new DentistDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {

            String path =
                    request.getPathInfo();

            String keyword =
                    request.getParameter("keyword");

            if (keyword != null &&
                !keyword.trim().isEmpty()) {

                List<Dentist> dentists =
                        dentistDAO.searchDentists(
                                keyword.trim()
                        );

                response.getWriter().write(
                        dentistsToJson(dentists)
                );

                return;
            }

            if (path == null || path.equals("/")) {

                List<Dentist> dentists =
                        dentistDAO.getAllDentists();

                response.getWriter().write(
                        dentistsToJson(dentists)
                );

                return;
            }

            int dentistId =
                    Integer.parseInt(
                            path.substring(1)
                    );

            Dentist dentist =
                    dentistDAO.getDentistById(
                            dentistId
                    );

            if (dentist == null) {

                response.setStatus(404);

                response.getWriter().write(
                        "{\"success\":false,\"message\":\"Dentist not found\"}"
                );

                return;
            }

            response.getWriter().write(
                    dentistToJson(dentist)
            );

        } catch (NumberFormatException e) {

            response.setStatus(400);

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"Invalid dentist ID\"}"
            );

        } catch (Exception e) {

            response.setStatus(500);

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"Server error\"}"
            );
        }
    }

    private String dentistsToJson(
            List<Dentist> dentists) {

        StringBuilder json =
                new StringBuilder("[");

        for (int i = 0;
             i < dentists.size();
             i++) {

            if (i > 0) {
                json.append(",");
            }

            json.append(
                    dentistToJson(
                            dentists.get(i)
                    )
            );
        }

        json.append("]");

        return json.toString();
    }

    private String dentistToJson(
            Dentist d) {

        return "{"
                + "\"dentistId\":"
                + d.getDentistId()
                + ","
                + "\"dentistName\":\""
                + escape(d.getDentistName())
                + "\","
                + "\"specialization\":\""
                + escape(d.getSpecialization())
                + "\","
                + "\"consultationFee\":"
                + d.getConsultationFee()
                + ","
                + "\"phoneNumber\":\""
                + escape(d.getPhoneNumber())
                + "\","
                + "\"email\":\""
                + escape(d.getEmail())
                + "\","
                + "\"active\":"
                + d.isActive()
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
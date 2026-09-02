package com.sunrise.webservice;

import java.io.IOException;
import java.util.List;

import com.sunrise.dao.TreatmentDAO;
import com.sunrise.model.Treatment;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/api/treatments/*")
public class TreatmentWebService extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private TreatmentDAO treatmentDAO;

    @Override
    public void init() {
        treatmentDAO = new TreatmentDAO();
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

                List<Treatment> treatments =
                        treatmentDAO.searchTreatments(
                                keyword.trim()
                        );

                response.getWriter().write(
                        treatmentsToJson(treatments)
                );

                return;
            }

            if (path == null || path.equals("/")) {

                List<Treatment> treatments =
                        treatmentDAO.getAllTreatments();

                response.getWriter().write(
                        treatmentsToJson(treatments)
                );

                return;
            }

            int treatmentId =
                    Integer.parseInt(
                            path.substring(1)
                    );

            Treatment treatment =
                    treatmentDAO.getTreatmentById(
                            treatmentId
                    );

            if (treatment == null) {

                response.setStatus(404);

                response.getWriter().write(
                        "{\"success\":false,\"message\":\"Treatment not found\"}"
                );

                return;
            }

            response.getWriter().write(
                    treatmentToJson(treatment)
            );

        } catch (NumberFormatException e) {

            response.setStatus(400);

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"Invalid treatment ID\"}"
            );

        } catch (Exception e) {

            response.setStatus(500);

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"Server error\"}"
            );
        }
    }

    private String treatmentsToJson(
            List<Treatment> treatments) {

        StringBuilder json =
                new StringBuilder("[");

        for (int i = 0;
             i < treatments.size();
             i++) {

            if (i > 0) {
                json.append(",");
            }

            json.append(
                    treatmentToJson(
                            treatments.get(i)
                    )
            );
        }

        json.append("]");

        return json.toString();
    }

    private String treatmentToJson(
            Treatment t) {

        return "{"
                + "\"treatmentId\":"
                + t.getTreatmentId()
                + ","
                + "\"treatmentName\":\""
                + escape(t.getTreatmentName())
                + "\","
                + "\"description\":\""
                + escape(t.getDescription())
                + "\","
                + "\"treatmentFee\":"
                + t.getTreatmentFee()
                + ","
                + "\"active\":"
                + t.isActive()
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
package com.sunrise.webservice;

import java.io.IOException;
import java.util.List;

import com.sunrise.dao.DentistScheduleDAO;
import com.sunrise.model.DentistSchedule;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/api/schedules/*")
public class DentistScheduleWebService extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private DentistScheduleDAO scheduleDAO;

    @Override
    public void init() {
        scheduleDAO =
                new DentistScheduleDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {

            String dentistIdParam =
                    request.getParameter(
                            "dentistId"
                    );

            if (dentistIdParam == null) {

                response.setStatus(400);

                response.getWriter().write(
                        "{\"success\":false,\"message\":\"dentistId is required\"}"
                );

                return;
            }

            int dentistId =
                    Integer.parseInt(
                            dentistIdParam
                    );

            List<DentistSchedule> schedules =
                    scheduleDAO.getSchedulesByDentist(
                            dentistId
                    );

            response.getWriter().write(
                    schedulesToJson(schedules)
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

    private String schedulesToJson(
            List<DentistSchedule> schedules) {

        StringBuilder json =
                new StringBuilder("[");

        for (int i = 0;
             i < schedules.size();
             i++) {

            if (i > 0) {
                json.append(",");
            }

            DentistSchedule s =
                    schedules.get(i);

            json.append("{")
                    .append("\"scheduleId\":")
                    .append(s.getScheduleId())
                    .append(",")
                    .append("\"dentistId\":")
                    .append(s.getDentistId())
                    .append(",")
                    .append("\"dayOfWeek\":\"")
                    .append(escape(
                            s.getDayOfWeek()
                    ))
                    .append("\",")
                    .append("\"startTime\":\"")
                    .append(s.getStartTime())
                    .append("\",")
                    .append("\"endTime\":\"")
                    .append(s.getEndTime())
                    .append("\",")
                    .append("\"slotDuration\":")
                    .append(s.getSlotDuration())
                    .append(",")
                    .append("\"active\":")
                    .append(s.isActive())
                    .append("}");
        }

        json.append("]");

        return json.toString();
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
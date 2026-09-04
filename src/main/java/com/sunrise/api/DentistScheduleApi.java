package com.sunrise.api;

import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sunrise.model.DentistSchedule;
import com.sunrise.service.DentistScheduleService;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/api/schedules/*")
public class DentistScheduleApi extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private DentistScheduleService dentistScheduleService;


    // =========================================================
    // INITIALIZE
    // =========================================================

    @Override
    public void init() {

        dentistScheduleService =
                new DentistScheduleService();
    }


    // =========================================================
    // OPTIONS / CORS
    // =========================================================

    @Override
    protected void doOptions(
            HttpServletRequest r,
            HttpServletResponse s) {

        ApiUtil.cors(s);
        ApiUtil.noContent(s);
    }


    // =========================================================
    // GET
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest r,
            HttpServletResponse s) throws IOException {

        ApiUtil.json(s);
        ApiUtil.cors(s);

        try {

            String dentistIdValue =
                    r.getParameter("dentistId");

            String day =
                    r.getParameter("day");


            // =====================================================
            // VALIDATE DENTIST ID
            // =====================================================

            if (ApiUtil.blank(dentistIdValue)) {

                ApiUtil.error(
                        s,
                        400,
                        "dentistId is required"
                );

                return;
            }


            int dentistId;

            try {

                dentistId =
                        Integer.parseInt(
                                dentistIdValue
                        );

            } catch (NumberFormatException e) {

                ApiUtil.error(
                        s,
                        400,
                        "Invalid dentist ID"
                );

                return;
            }


            // =====================================================
            // GET SCHEDULES
            // =====================================================

            List<DentistSchedule> schedules;


            if (ApiUtil.blank(day)) {

                schedules =
                        dentistScheduleService
                                .getSchedulesByDentist(
                                        dentistId
                                );

            } else {

                schedules =
                        dentistScheduleService
                                .getSchedulesByDentistAndDay(
                                        dentistId,
                                        day.trim().toUpperCase()
                                );
            }


            s.getWriter().write(
                    listJson(schedules)
            );

        } catch (Exception e) {

            e.printStackTrace();

            ApiUtil.error(
                    s,
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
            HttpServletRequest r,
            HttpServletResponse s) throws IOException {

        ApiUtil.json(s);
        ApiUtil.cors(s);

        r.setCharacterEncoding("UTF-8");

        try {

            String path =
                    r.getPathInfo();

            String dentistIdValue = null;


            // =====================================================
            // GET DENTIST ID FROM PATH
            // /api/schedules/{dentistId}
            // =====================================================

            if (!ApiUtil.blank(path)
                    && path.length() > 1) {

                dentistIdValue =
                        path.substring(1);

            } else {

                dentistIdValue =
                        r.getParameter(
                                "dentistId"
                        );
            }


            // =====================================================
            // VALIDATE DENTIST ID
            // =====================================================

            if (ApiUtil.blank(dentistIdValue)) {

                ApiUtil.error(
                        s,
                        400,
                        "dentistId is required"
                );

                return;
            }


            int dentistId;

            try {

                dentistId =
                        Integer.parseInt(
                                dentistIdValue
                        );

            } catch (NumberFormatException e) {

                ApiUtil.error(
                        s,
                        400,
                        "Invalid dentist ID"
                );

                return;
            }


            // =====================================================
            // READ BODY
            // =====================================================

            String body =
                    r.getReader()
                            .lines()
                            .reduce(
                                    "",
                                    (a, b) -> a + b
                            );


            Map<String, List<String>> params =
                    parseFormData(body);


            List<String> days =
                    params.get("dayOfWeek");

            List<String> starts =
                    params.get("startTime");

            List<String> ends =
                    params.get("endTime");

            List<String> durations =
                    params.get("slotDuration");


            // =====================================================
            // VALIDATE ARRAYS
            // =====================================================

            if (days == null
                    || starts == null
                    || ends == null
                    || durations == null) {

                ApiUtil.error(
                        s,
                        400,
                        "Schedule arrays dayOfWeek, startTime, endTime and slotDuration are required"
                );

                return;
            }


            if (days.size() != starts.size()
                    || days.size() != ends.size()
                    || days.size() != durations.size()) {

                ApiUtil.error(
                        s,
                        400,
                        "Schedule arrays must have equal lengths"
                );

                return;
            }


            // =====================================================
            // CREATE SCHEDULE LIST
            // =====================================================

            List<DentistSchedule> schedules =
                    new ArrayList<>();


            for (int i = 0;
                 i < days.size();
                 i++) {

                String day =
                        days.get(i)
                                .trim()
                                .toUpperCase();


                LocalTime start;

                LocalTime end;

                int duration;


                try {

                    start =
                            LocalTime.parse(
                                    starts.get(i).trim()
                            );

                    end =
                            LocalTime.parse(
                                    ends.get(i).trim()
                            );

                    duration =
                            Integer.parseInt(
                                    durations.get(i).trim()
                            );

                } catch (Exception e) {

                    ApiUtil.error(
                            s,
                            400,
                            "Invalid schedule time or slot duration"
                    );

                    return;
                }


                // =================================================
                // BASIC VALIDATION
                // =================================================

                if (duration <= 0) {

                    ApiUtil.error(
                            s,
                            400,
                            "slotDuration must be greater than zero"
                    );

                    return;
                }


                if (!end.isAfter(start)) {

                    ApiUtil.error(
                            s,
                            400,
                            "End time must be after start time"
                    );

                    return;
                }


                schedules.add(
                        new DentistSchedule(
                                dentistId,
                                day,
                                start,
                                end,
                                duration,
                                true
                        )
                );
            }


            // =====================================================
            // SAVE THROUGH SERVICE
            // =====================================================

            if (dentistScheduleService
                    .replaceDentistSchedule(
                            dentistId,
                            schedules
                    )) {

                s.setStatus(
                        HttpServletResponse.SC_OK
                );

                s.getWriter().write(
                        listJson(schedules)
                );

            } else {

                ApiUtil.error(
                        s,
                        400,
                        "Schedule could not be saved"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            ApiUtil.error(
                    s,
                    400,
                    "Invalid schedule data"
            );
        }
    }


    // =========================================================
    // FORM DATA PARSER
    // SUPPORTS REPEATED VALUES
    // =========================================================

    private Map<String, List<String>> parseFormData(
            String body) {

        Map<String, List<String>> params =
                new HashMap<>();


        if (body == null
                || body.trim().isEmpty()) {

            return params;
        }


        String[] pairs =
                body.split("&");


        for (String pair : pairs) {

            String[] parts =
                    pair.split("=", 2);


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


            params
                    .computeIfAbsent(
                            key,
                            k -> new ArrayList<>()
                    )
                    .add(value);
        }


        return params;
    }


    // =========================================================
    // JSON
    // =========================================================

    private String listJson(
            List<DentistSchedule> schedules) {

        StringBuilder b =
                new StringBuilder("[");


        for (int i = 0;
             i < schedules.size();
             i++) {

            if (i > 0) {
                b.append(',');
            }


            DentistSchedule d =
                    schedules.get(i);


            b.append("{");


            b.append("\"scheduleId\":")
                    .append(
                            d.getScheduleId()
                    );


            b.append(",\"dentistId\":")
                    .append(
                            d.getDentistId()
                    );


            b.append(",\"dayOfWeek\":")
                    .append(
                            ApiUtil.str(
                                    d.getDayOfWeek()
                            )
                    );


            b.append(",\"startTime\":")
                    .append(
                            ApiUtil.time(
                                    d.getStartTime()
                            )
                    );


            b.append(",\"endTime\":")
                    .append(
                            ApiUtil.time(
                                    d.getEndTime()
                            )
                    );


            b.append(",\"slotDuration\":")
                    .append(
                            d.getSlotDuration()
                    );


            b.append(",\"active\":")
                    .append(
                            d.isActive()
                    );


            b.append("}");
        }


        return b.append(']')
                .toString();
    }
}
package com.sunrise.controller;

import java.io.IOException;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import com.sunrise.dao.DentistDAO;
import com.sunrise.dao.DentistScheduleDAO;
import com.sunrise.model.Dentist;
import com.sunrise.model.DentistSchedule;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/dentists/*")
public class DentistController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private DentistDAO dentistDAO;
    private DentistScheduleDAO scheduleDAO;


    @Override
    public void init() {

        dentistDAO = new DentistDAO();

        scheduleDAO =
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

            listDentists(
                    request,
                    response
            );

        }

        else if (path.equals("/add")) {

            showAddForm(
                    request,
                    response
            );

        }

        else if (path.equals("/view")) {

            viewDentist(
                    request,
                    response
            );

        }

        else if (path.equals("/edit")) {

            showEditForm(
                    request,
                    response
            );

        }

        else if (path.equals("/schedule")) {

            showSchedule(
                    request,
                    response
            );

        }

        else {

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

            addDentist(
                    request,
                    response
            );

        }

        else if ("/edit".equals(path)) {

            updateDentist(
                    request,
                    response
            );

        }

        else if ("/schedule/save".equals(path)) {

            saveSchedule(
                    request,
                    response
            );

        }

        else {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND
            );
        }
    }


    // =========================================================
    // LIST
    // =========================================================

    private void listDentists(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String keyword =
                request.getParameter("keyword");

        List<Dentist> dentists;

        if (keyword != null
                && !keyword.trim().isEmpty()) {

            keyword = keyword.trim();

            dentists =
                    dentistDAO.searchDentists(
                            keyword
                    );

        } else {

            dentists =
                    dentistDAO.getAllDentists();
        }

        request.setAttribute(
                "dentists",
                dentists
        );

        request.setAttribute(
                "keyword",
                keyword
        );

        request.getRequestDispatcher(
                "/WEB-INF/views/dentists/dentist-list.jsp"
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

        request.setAttribute(
                "formMode",
                "add"
        );

        request.getRequestDispatcher(
                "/WEB-INF/views/dentists/dentist-form.jsp"
        ).forward(
                request,
                response
        );
    }


    // =========================================================
    // ADD DENTIST
    // =========================================================

    private void addDentist(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String dentistName =
                clean(
                    request.getParameter(
                        "dentistName"
                    )
                );

        String specialization =
                clean(
                    request.getParameter(
                        "specialization"
                    )
                );

        String feeText =
                clean(
                    request.getParameter(
                        "consultationFee"
                    )
                );

        String phoneNumber =
                clean(
                    request.getParameter(
                        "phoneNumber"
                    )
                );

        String email =
                clean(
                    request.getParameter(
                        "email"
                    )
                );

        boolean active =
                "true".equals(
                    request.getParameter(
                        "active"
                    )
                );


        double consultationFee;

        try {

            consultationFee =
                    Double.parseDouble(
                        feeText
                    );

        } catch (Exception e) {

            Dentist dentist =
                    new Dentist(
                        dentistName,
                        specialization,
                        0,
                        phoneNumber,
                        email,
                        active
                    );

            showFormWithError(
                request,
                response,
                dentist,
                "Please enter a valid consultation fee.",
                "add"
            );

            return;
        }


        String error =
                validateDentist(
                    dentistName,
                    specialization,
                    consultationFee,
                    phoneNumber,
                    email
                );


        if (error != null) {

            Dentist dentist =
                    new Dentist(
                        dentistName,
                        specialization,
                        consultationFee,
                        phoneNumber,
                        email,
                        active
                    );

            showFormWithError(
                request,
                response,
                dentist,
                error,
                "add"
            );

            return;
        }


        Dentist dentist =
                new Dentist(
                    dentistName,
                    specialization,
                    consultationFee,
                    phoneNumber,
                    email,
                    active
                );


        boolean success =
                dentistDAO.addDentist(
                    dentist
                );


        if (success) {

            response.sendRedirect(
                request.getContextPath()
                + "/dentists?success=1"
            );

        } else {

            showFormWithError(
                request,
                response,
                dentist,
                "Unable to add dentist. Please try again.",
                "add"
            );
        }
    }


    // =========================================================
    // VIEW DENTIST
    // =========================================================

    private void viewDentist(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int dentistId =
                    Integer.parseInt(
                        request.getParameter("id")
                    );

            Dentist dentist =
                    dentistDAO.getDentistById(
                        dentistId
                    );


            if (dentist == null) {

                response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Dentist not found."
                );

                return;
            }


            request.setAttribute(
                "dentist",
                dentist
            );


            request.getRequestDispatcher(
                "/WEB-INF/views/dentists/dentist-details.jsp"
            ).forward(
                request,
                response
            );

        } catch (NumberFormatException e) {

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid dentist ID."
            );
        }
    }


    // =========================================================
    // SHOW EDIT
    // =========================================================

    private void showEditForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int dentistId =
                    Integer.parseInt(
                        request.getParameter("id")
                    );

            Dentist dentist =
                    dentistDAO.getDentistById(
                        dentistId
                    );


            if (dentist == null) {

                response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Dentist not found."
                );

                return;
            }


            request.setAttribute(
                "dentist",
                dentist
            );

            request.setAttribute(
                "formMode",
                "edit"
            );


            request.getRequestDispatcher(
                "/WEB-INF/views/dentists/dentist-form.jsp"
            ).forward(
                request,
                response
            );

        } catch (NumberFormatException e) {

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid dentist ID."
            );
        }
    }


    // =========================================================
    // UPDATE DENTIST
    // =========================================================

    private void updateDentist(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int dentistId =
                    Integer.parseInt(
                        request.getParameter("dentistId")
                    );

            String dentistName =
                    clean(
                        request.getParameter(
                            "dentistName"
                        )
                    );

            String specialization =
                    clean(
                        request.getParameter(
                            "specialization"
                        )
                    );

            String feeText =
                    clean(
                        request.getParameter(
                            "consultationFee"
                        )
                    );

            String phoneNumber =
                    clean(
                        request.getParameter(
                            "phoneNumber"
                        )
                    );

            String email =
                    clean(
                        request.getParameter(
                            "email"
                        )
                    );

            boolean active =
                    "true".equals(
                        request.getParameter(
                            "active"
                        )
                    );


            Dentist dentist =
                    dentistDAO.getDentistById(
                        dentistId
                    );


            if (dentist == null) {

                response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Dentist not found."
                );

                return;
            }


            double consultationFee;

            try {

                consultationFee =
                        Double.parseDouble(
                            feeText
                        );

            } catch (Exception e) {

                dentist.setDentistName(
                    dentistName
                );

                dentist.setSpecialization(
                    specialization
                );

                dentist.setPhoneNumber(
                    phoneNumber
                );

                dentist.setEmail(
                    email
                );

                dentist.setActive(
                    active
                );


                showFormWithError(
                    request,
                    response,
                    dentist,
                    "Please enter a valid consultation fee.",
                    "edit"
                );

                return;
            }


            String error =
                    validateDentist(
                        dentistName,
                        specialization,
                        consultationFee,
                        phoneNumber,
                        email
                    );


            if (error != null) {

                dentist.setDentistName(
                    dentistName
                );

                dentist.setSpecialization(
                    specialization
                );

                dentist.setConsultationFee(
                    consultationFee
                );

                dentist.setPhoneNumber(
                    phoneNumber
                );

                dentist.setEmail(
                    email
                );

                dentist.setActive(
                    active
                );


                showFormWithError(
                    request,
                    response,
                    dentist,
                    error,
                    "edit"
                );

                return;
            }


            dentist.setDentistName(
                dentistName
            );

            dentist.setSpecialization(
                specialization
            );

            dentist.setConsultationFee(
                consultationFee
            );

            dentist.setPhoneNumber(
                phoneNumber
            );

            dentist.setEmail(
                email
            );

            dentist.setActive(
                active
            );


            boolean success =
                    dentistDAO.updateDentist(
                        dentist
                    );


            if (success) {

                response.sendRedirect(
                    request.getContextPath()
                    + "/dentists/view?id="
                    + dentistId
                    + "&updated=1"
                );

            } else {

                showFormWithError(
                    request,
                    response,
                    dentist,
                    "Unable to update dentist.",
                    "edit"
                );
            }

        } catch (NumberFormatException e) {

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid dentist ID."
            );
        }
    }


    // =========================================================
    // SHOW SCHEDULE
    // =========================================================

    private void showSchedule(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int dentistId =
                    Integer.parseInt(
                        request.getParameter("id")
                    );


            Dentist dentist =
                    dentistDAO.getDentistById(
                        dentistId
                    );


            if (dentist == null) {

                response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Dentist not found."
                );

                return;
            }


            List<DentistSchedule> schedules =
                    scheduleDAO.getSchedulesByDentist(
                        dentistId
                    );


            request.setAttribute(
                "dentist",
                dentist
            );

            request.setAttribute(
                "schedules",
                schedules
            );


            request.getRequestDispatcher(
                "/WEB-INF/views/dentists/dentist-schedule.jsp"
            ).forward(
                request,
                response
            );

        } catch (NumberFormatException e) {

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid dentist ID."
            );
        }
    }


    // =========================================================
    // SAVE SCHEDULE
    // =========================================================

    private void saveSchedule(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int dentistId =
                    Integer.parseInt(
                        request.getParameter(
                            "dentistId"
                        )
                    );


            Dentist dentist =
                    dentistDAO.getDentistById(
                        dentistId
                    );


            if (dentist == null) {

                response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Dentist not found."
                );

                return;
            }


            String[] days =
                    request.getParameterValues(
                        "dayOfWeek"
                    );

            String[] starts =
                    request.getParameterValues(
                        "startTime"
                    );

            String[] ends =
                    request.getParameterValues(
                        "endTime"
                    );

            String[] durations =
                    request.getParameterValues(
                        "slotDuration"
                    );
            


            List<DentistSchedule> schedules =
                    new ArrayList<>();


            if (days != null) {

                if (starts == null
                        || ends == null
                        || durations == null
                        || days.length != starts.length
                        || days.length != ends.length
                        || days.length != durations.length) {

                    showScheduleError(
                        request,
                        response,
                        dentist,
                        "Invalid schedule information."
                    );

                    return;
                }


                for (int i = 0;
                     i < days.length;
                     i++) {

                    String day =
                            clean(days[i]);

                    String start =
                            clean(starts[i]);

                    String end =
                            clean(ends[i]);

                    String duration =
                            clean(durations[i]);


                    if (day.isEmpty()
                            || start.isEmpty()
                            || end.isEmpty()
                            || duration.isEmpty()) {

                        continue;
                    }


                    LocalTime startTime;

                    LocalTime endTime;

                    int slotDuration;


                    try {

                        startTime =
                            LocalTime.parse(
                                start
                            );

                        endTime =
                            LocalTime.parse(
                                end
                            );

                        slotDuration =
                            Integer.parseInt(
                                duration
                            );

                    } catch (Exception e) {

                        showScheduleError(
                            request,
                            response,
                            dentist,
                            "Please enter valid schedule times."
                        );

                        return;
                    }


                    if (!isValidDay(day)) {

                        showScheduleError(
                            request,
                            response,
                            dentist,
                            "Invalid working day."
                        );

                        return;
                    }


                    if (!endTime.isAfter(startTime)) {

                        showScheduleError(
                            request,
                            response,
                            dentist,
                            "End time must be after start time."
                        );

                        return;
                    }


                    if (slotDuration <= 0
                            || slotDuration > 240) {

                        showScheduleError(
                            request,
                            response,
                            dentist,
                            "Slot duration must be between 1 and 240 minutes."
                        );

                        return;
                    }


                    schedules.add(
                        new DentistSchedule(
                            dentistId,
                            day,
                            startTime,
                            endTime,
                            slotDuration,
                            true
                        )
                    );
                }
            }


            // Check overlapping periods

            for (int i = 0;
                 i < schedules.size();
                 i++) {

                DentistSchedule first =
                        schedules.get(i);


                for (int j = i + 1;
                     j < schedules.size();
                     j++) {

                    DentistSchedule second =
                            schedules.get(j);


                    if (!first.getDayOfWeek()
                            .equals(second.getDayOfWeek())) {

                        continue;
                    }


                    boolean overlaps =
                            first.getStartTime()
                                .isBefore(
                                    second.getEndTime()
                                )
                            &&
                            second.getStartTime()
                                .isBefore(
                                    first.getEndTime()
                                );


                    if (overlaps) {

                        showScheduleError(
                            request,
                            response,
                            dentist,
                            "Working periods cannot overlap on the same day."
                        );

                        return;
                    }
                }
            }


            boolean success =
                    scheduleDAO.replaceDentistSchedule(
                        dentistId,
                        schedules
                    );


            if (success) {

                response.sendRedirect(
                    request.getContextPath()
                    + "/dentists/schedule?id="
                    + dentistId
                    + "&saved=1"
                );

            } else {

                showScheduleError(
                    request,
                    response,
                    dentist,
                    "Unable to save dentist schedule."
                );
            }

        } catch (NumberFormatException e) {

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid dentist ID."
            );
        }
    }


    // =========================================================
    // VALIDATE DAY
    // =========================================================

    private boolean isValidDay(
            String day) {

        return day.equals("MONDAY")
                || day.equals("TUESDAY")
                || day.equals("WEDNESDAY")
                || day.equals("THURSDAY")
                || day.equals("FRIDAY")
                || day.equals("SATURDAY")
                || day.equals("SUNDAY");
    }


    // =========================================================
    // SCHEDULE ERROR
    // =========================================================

    private void showScheduleError(
            HttpServletRequest request,
            HttpServletResponse response,
            Dentist dentist,
            String error)
            throws ServletException, IOException {

        List<DentistSchedule> schedules =
                scheduleDAO.getSchedulesByDentist(
                    dentist.getDentistId()
                );


        request.setAttribute(
            "dentist",
            dentist
        );

        request.setAttribute(
            "schedules",
            schedules
        );

        request.setAttribute(
            "error",
            error
        );


        request.getRequestDispatcher(
            "/WEB-INF/views/dentists/dentist-schedule.jsp"
        ).forward(
            request,
            response
        );
    }


    // =========================================================
    // VALIDATION
    // =========================================================

    private String validateDentist(
            String dentistName,
            String specialization,
            double consultationFee,
            String phoneNumber,
            String email) {

        if (dentistName.isEmpty()) {
            return "Dentist name is required.";
        }

        if (dentistName.length() < 2) {
            return "Dentist name must contain at least 2 characters.";
        }

        if (!dentistName.matches(
                "[a-zA-Z .'-]+")) {

            return "Dentist name contains invalid characters.";
        }

        if (specialization.isEmpty()) {
            return "Specialization is required.";
        }

        if (consultationFee < 0) {
            return "Consultation fee cannot be negative.";
        }

        if (phoneNumber.isEmpty()) {
            return "Phone number is required.";
        }

        if (!phoneNumber.matches(
                "^(\\+94|0)?7[0-9]{8}$")) {

            return "Please enter a valid Sri Lankan mobile number.";
        }

        if (!email.isEmpty()) {

            if (!email.matches(
                    "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {

                return "Please enter a valid email address.";
            }
        }

        return null;
    }


    // =========================================================
    // FORM ERROR
    // =========================================================

    private void showFormWithError(
            HttpServletRequest request,
            HttpServletResponse response,
            Dentist dentist,
            String error,
            String formMode)
            throws ServletException, IOException {

        request.setAttribute(
            "dentist",
            dentist
        );

        request.setAttribute(
            "formMode",
            formMode
        );

        request.setAttribute(
            "error",
            error
        );

        request.getRequestDispatcher(
            "/WEB-INF/views/dentists/dentist-form.jsp"
        ).forward(
            request,
            response
        );
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
}
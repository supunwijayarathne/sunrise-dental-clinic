package com.sunrise.controller;

import java.io.IOException;
import java.util.List;

import com.sunrise.dao.TreatmentDAO;
import com.sunrise.model.Treatment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/treatments/*")
public class TreatmentController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private TreatmentDAO treatmentDAO;

    @Override
    public void init() {
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

            listTreatments(request, response);

        } else if (path.equals("/add")) {

            showAddForm(request, response);

        } else if (path.equals("/view")) {

            viewTreatment(request, response);

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

            addTreatment(request, response);

        } else if ("/edit".equals(path)) {

            updateTreatment(request, response);

        } else {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND
            );
        }
    }


    // =========================================================
    // LIST / SEARCH
    // =========================================================

    private void listTreatments(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String keyword =
                request.getParameter("keyword");

        List<Treatment> treatments;

        if (keyword != null
                && !keyword.trim().isEmpty()) {

            keyword = keyword.trim();

            treatments =
                    treatmentDAO.searchTreatments(keyword);

        } else {

            treatments =
                    treatmentDAO.getAllTreatments();
        }

        request.setAttribute(
                "treatments",
                treatments
        );

        request.setAttribute(
                "keyword",
                keyword
        );

        request.getRequestDispatcher(
                "/WEB-INF/views/treatments/treatment-list.jsp"
        ).forward(request, response);
    }


    // =========================================================
    // ADD FORM
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
                "/WEB-INF/views/treatments/treatment-form.jsp"
        ).forward(request, response);
    }


    // =========================================================
    // ADD
    // =========================================================

    private void addTreatment(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String treatmentName =
                request.getParameter("treatmentName");

        String description =
                request.getParameter("description");

        String feeText =
                request.getParameter("treatmentFee");

        String activeText =
                request.getParameter("active");


        treatmentName =
                treatmentName != null
                ? treatmentName.trim()
                : "";

        description =
                description != null
                ? description.trim()
                : "";

        boolean active =
                "true".equals(activeText);


        double treatmentFee;

        try {

            treatmentFee =
                    Double.parseDouble(feeText);

        } catch (Exception e) {

            Treatment treatment =
                    new Treatment(
                            treatmentName,
                            description,
                            0,
                            active
                    );

            showFormWithError(
                    request,
                    response,
                    treatment,
                    "Please enter a valid treatment fee.",
                    "add"
            );

            return;
        }


        String error =
                validateTreatment(
                        treatmentName,
                        description,
                        treatmentFee
                );


        if (error != null) {

            Treatment treatment =
                    new Treatment(
                            treatmentName,
                            description,
                            treatmentFee,
                            active
                    );

            showFormWithError(
                    request,
                    response,
                    treatment,
                    error,
                    "add"
            );

            return;
        }


        Treatment treatment =
                new Treatment(
                        treatmentName,
                        description,
                        treatmentFee,
                        active
                );


        boolean success =
                treatmentDAO.addTreatment(treatment);


        if (success) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/treatments?success=1"
            );

        } else {

            showFormWithError(
                    request,
                    response,
                    treatment,
                    "Unable to add treatment.",
                    "add"
            );
        }
    }


    // =========================================================
    // VIEW
    // =========================================================

    private void viewTreatment(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int treatmentId =
                    Integer.parseInt(
                            request.getParameter("id")
                    );

            Treatment treatment =
                    treatmentDAO.getTreatmentById(
                            treatmentId
                    );


            if (treatment == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Treatment not found."
                );

                return;
            }


            request.setAttribute(
                    "treatment",
                    treatment
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/treatments/treatment-details.jsp"
            ).forward(request, response);


        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid treatment ID."
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

            int treatmentId =
                    Integer.parseInt(
                            request.getParameter("id")
                    );

            Treatment treatment =
                    treatmentDAO.getTreatmentById(
                            treatmentId
                    );


            if (treatment == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Treatment not found."
                );

                return;
            }


            request.setAttribute(
                    "treatment",
                    treatment
            );

            request.setAttribute(
                    "formMode",
                    "edit"
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/treatments/treatment-form.jsp"
            ).forward(request, response);


        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid treatment ID."
            );
        }
    }


    // =========================================================
    // UPDATE
    // =========================================================

    private void updateTreatment(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int treatmentId =
                    Integer.parseInt(
                            request.getParameter("treatmentId")
                    );


            String treatmentName =
                    request.getParameter("treatmentName");

            String description =
                    request.getParameter("description");

            String feeText =
                    request.getParameter("treatmentFee");

            String activeText =
                    request.getParameter("active");


            treatmentName =
                    treatmentName != null
                    ? treatmentName.trim()
                    : "";

            description =
                    description != null
                    ? description.trim()
                    : "";

            boolean active =
                    "true".equals(activeText);


            Treatment treatment =
                    treatmentDAO.getTreatmentById(
                            treatmentId
                    );


            if (treatment == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Treatment not found."
                );

                return;
            }


            double treatmentFee;

            try {

                treatmentFee =
                        Double.parseDouble(feeText);

            } catch (Exception e) {

                treatment.setTreatmentName(
                        treatmentName
                );

                treatment.setDescription(
                        description
                );

                treatment.setActive(active);


                showFormWithError(
                        request,
                        response,
                        treatment,
                        "Please enter a valid treatment fee.",
                        "edit"
                );

                return;
            }


            String error =
                    validateTreatment(
                            treatmentName,
                            description,
                            treatmentFee
                    );


            if (error != null) {

                treatment.setTreatmentName(
                        treatmentName
                );

                treatment.setDescription(
                        description
                );

                treatment.setTreatmentFee(
                        treatmentFee
                );

                treatment.setActive(active);


                showFormWithError(
                        request,
                        response,
                        treatment,
                        error,
                        "edit"
                );

                return;
            }


            treatment.setTreatmentName(
                    treatmentName
            );

            treatment.setDescription(
                    description
            );

            treatment.setTreatmentFee(
                    treatmentFee
            );

            treatment.setActive(active);


            boolean success =
                    treatmentDAO.updateTreatment(
                            treatment
                    );


            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/treatments/view?id="
                        + treatmentId
                        + "&updated=1"
                );

            } else {

                showFormWithError(
                        request,
                        response,
                        treatment,
                        "Unable to update treatment.",
                        "edit"
                );
            }


        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid treatment ID."
            );
        }
    }


    // =========================================================
    // VALIDATION
    // =========================================================

    private String validateTreatment(
            String treatmentName,
            String description,
            double treatmentFee) {

        if (treatmentName.isEmpty()) {

            return "Treatment name is required.";
        }

        if (treatmentName.length() < 2) {

            return "Treatment name must contain at least 2 characters.";
        }

        if (description.isEmpty()) {

            return "Treatment description is required.";
        }

        if (treatmentFee < 0) {

            return "Treatment fee cannot be negative.";
        }

        return null;
    }


    // =========================================================
    // FORM ERROR HANDLER
    // =========================================================

    private void showFormWithError(
            HttpServletRequest request,
            HttpServletResponse response,
            Treatment treatment,
            String error,
            String formMode)
            throws ServletException, IOException {

        request.setAttribute(
                "treatment",
                treatment
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
                "/WEB-INF/views/treatments/treatment-form.jsp"
        ).forward(request, response);
    }
}
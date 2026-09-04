package com.sunrise.api;

import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sunrise.model.Treatment;
import com.sunrise.service.TreatmentService;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/api/treatments/*")
public class TreatmentApi extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private TreatmentService treatmentService;


    // =========================================================
    // INITIALIZE
    // =========================================================

    @Override
    public void init() {

        treatmentService = new TreatmentService();
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

            String path =
                    r.getPathInfo();

            String keyword =
                    r.getParameter("keyword");


            // =====================================================
            // SEARCH TREATMENTS
            // GET /api/treatments?keyword=
            // =====================================================

            if (!ApiUtil.blank(keyword)) {

                List<Treatment> treatments =
                        treatmentService.searchTreatments(
                                keyword.trim()
                        );

                s.getWriter().write(
                        listJson(treatments)
                );

                return;
            }


            // =====================================================
            // GET ALL TREATMENTS
            // GET /api/treatments
            // =====================================================

            if (path == null
                    || "/".equals(path)) {

                List<Treatment> treatments =
                        treatmentService.getAllTreatments();

                s.getWriter().write(
                        listJson(treatments)
                );

                return;
            }


            // =====================================================
            // GET TREATMENT BY ID
            // GET /api/treatments/{id}
            // =====================================================

            int treatmentId;

            try {

                treatmentId =
                        Integer.parseInt(
                                path.substring(1)
                        );

            } catch (NumberFormatException e) {

                ApiUtil.error(
                        s,
                        400,
                        "Invalid treatment ID"
                );

                return;
            }


            Treatment treatment =
                    treatmentService.getTreatmentById(
                            treatmentId
                    );


            if (treatment == null) {

                ApiUtil.error(
                        s,
                        404,
                        "Treatment not found"
                );

                return;
            }


            s.getWriter().write(
                    oneJson(treatment)
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
    // POST
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest r,
            HttpServletResponse s) throws IOException {

        ApiUtil.json(s);
        ApiUtil.cors(s);

        r.setCharacterEncoding("UTF-8");

        try {

            // =====================================================
            // READ FORM DATA
            // =====================================================

            String body =
                    r.getReader()
                            .lines()
                            .reduce(
                                    "",
                                    (a, b) -> a + b
                            );


            Map<String, String> params =
                    parseFormData(body);


            String name =
                    params.get("treatmentName");

            String description =
                    params.get("description");

            String feeValue =
                    params.get("treatmentFee");

            String activeValue =
                    params.get("active");


            // =====================================================
            // VALIDATE NAME
            // =====================================================

            if (ApiUtil.blank(name)) {

                ApiUtil.error(
                        s,
                        400,
                        "Treatment name is required"
                );

                return;
            }


            // =====================================================
            // VALIDATE FEE
            // =====================================================

            if (ApiUtil.blank(feeValue)) {

                ApiUtil.error(
                        s,
                        400,
                        "Treatment fee is required"
                );

                return;
            }


            double fee;

            try {

                fee =
                        Double.parseDouble(
                                feeValue.trim()
                        );

            } catch (NumberFormatException e) {

                ApiUtil.error(
                        s,
                        400,
                        "Invalid treatment fee"
                );

                return;
            }


            if (fee < 0) {

                ApiUtil.error(
                        s,
                        400,
                        "Treatment fee cannot be negative"
                );

                return;
            }


            // =====================================================
            // ACTIVE VALUE
            // =====================================================

            boolean active = true;

            if (!ApiUtil.blank(activeValue)) {

                active =
                        Boolean.parseBoolean(
                                activeValue
                        );
            }


            // =====================================================
            // CREATE TREATMENT
            // =====================================================

            Treatment treatment =
                    new Treatment();


            treatment.setTreatmentName(
                    name.trim()
            );


            if (ApiUtil.blank(description)) {

                treatment.setDescription(null);

            } else {

                treatment.setDescription(
                        description.trim()
                );
            }


            treatment.setTreatmentFee(
                    fee
            );


            treatment.setActive(
                    active
            );


            // =====================================================
            // SAVE THROUGH SERVICE
            // =====================================================

            if (treatmentService.createTreatment(
                    treatment
            )) {

                s.setStatus(
                        HttpServletResponse.SC_CREATED
                );

                s.getWriter().write(
                        oneJson(treatment)
                );

            } else {

                ApiUtil.error(
                        s,
                        400,
                        "Treatment could not be created"
                );
            }

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


            // =====================================================
            // VALIDATE ID
            // =====================================================

            if (path == null
                    || "/".equals(path)) {

                ApiUtil.error(
                        s,
                        400,
                        "Treatment ID is required"
                );

                return;
            }


            int treatmentId;

            try {

                treatmentId =
                        Integer.parseInt(
                                path.substring(1)
                        );

            } catch (NumberFormatException e) {

                ApiUtil.error(
                        s,
                        400,
                        "Invalid treatment ID"
                );

                return;
            }


            // =====================================================
            // FIND EXISTING TREATMENT
            // =====================================================

            Treatment treatment =
                    treatmentService.getTreatmentById(
                            treatmentId
                    );


            if (treatment == null) {

                ApiUtil.error(
                        s,
                        404,
                        "Treatment not found"
                );

                return;
            }


            // =====================================================
            // READ PUT BODY
            // =====================================================

            String body =
                    r.getReader()
                            .lines()
                            .reduce(
                                    "",
                                    (a, b) -> a + b
                            );


            Map<String, String> params =
                    parseFormData(body);


            String name =
                    params.get("treatmentName");

            String description =
                    params.get("description");

            String feeValue =
                    params.get("treatmentFee");

            String activeValue =
                    params.get("active");


            // =====================================================
            // UPDATE NAME
            // =====================================================

            if (name != null
                    && !name.trim().isEmpty()) {

                treatment.setTreatmentName(
                        name.trim()
                );
            }


            // =====================================================
            // UPDATE DESCRIPTION
            // =====================================================

            if (description != null) {

                treatment.setDescription(
                        description.trim()
                );
            }


            // =====================================================
            // UPDATE FEE
            // =====================================================

            if (feeValue != null
                    && !feeValue.trim().isEmpty()) {

                double fee;

                try {

                    fee =
                            Double.parseDouble(
                                    feeValue.trim()
                            );

                } catch (NumberFormatException e) {

                    ApiUtil.error(
                            s,
                            400,
                            "Invalid treatment fee"
                    );

                    return;
                }


                if (fee < 0) {

                    ApiUtil.error(
                            s,
                            400,
                            "Treatment fee cannot be negative"
                    );

                    return;
                }


                treatment.setTreatmentFee(
                        fee
                );
            }


            // =====================================================
            // UPDATE ACTIVE
            // =====================================================

            if (activeValue != null) {

                treatment.setActive(
                        Boolean.parseBoolean(
                                activeValue
                        )
                );
            }


            // =====================================================
            // UPDATE THROUGH SERVICE
            // =====================================================

            if (treatmentService.updateTreatment(
                    treatment
            )) {

                s.setStatus(
                        HttpServletResponse.SC_OK
                );

                s.getWriter().write(
                        oneJson(treatment)
                );

            } else {

                ApiUtil.error(
                        s,
                        400,
                        "Treatment could not be updated"
                );
            }

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
    // PARSE x-www-form-urlencoded DATA
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


        for (String pair : pairs) {

            String[] parts =
                    pair.split("=", 2);


            if (parts.length == 2) {

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
        }


        return params;
    }


    // =========================================================
    // JSON LIST
    // =========================================================

    private String listJson(
            List<Treatment> treatments) {

        StringBuilder b =
                new StringBuilder("[");


        for (int i = 0;
             i < treatments.size();
             i++) {

            if (i > 0) {
                b.append(',');
            }

            b.append(
                    oneJson(
                            treatments.get(i)
                    )
            );
        }


        return b.append(']')
                .toString();
    }


    // =========================================================
    // JSON ONE
    // =========================================================

    private String oneJson(
            Treatment treatment) {

        return "{"
                + "\"treatmentId\":"
                + treatment.getTreatmentId()

                + ",\"treatmentName\":"
                + ApiUtil.str(
                        treatment.getTreatmentName()
                )

                + ",\"description\":"
                + ApiUtil.nullable(
                        treatment.getDescription()
                )

                + ",\"treatmentFee\":"
                + treatment.getTreatmentFee()

                + ",\"active\":"
                + treatment.isActive()

                + "}";
    }
}
package com.sunrise.api;

import java.io.IOException;
import java.util.List;

import com.sunrise.model.Patient;
import com.sunrise.service.PatientService;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/api/patients/*")
public class PatientApi extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private PatientService patientService;


    // =========================================================
    // INITIALIZE
    // =========================================================

    @Override
    public void init() {

        patientService = new PatientService();
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

            String path = r.getPathInfo();
            String keyword = r.getParameter("keyword");


            // =====================================================
            // SEARCH PATIENTS
            // GET /api/patients?keyword=
            // =====================================================

            if (!ApiUtil.blank(keyword)) {

                List<Patient> patients =
                        patientService.searchPatients(
                                keyword.trim()
                        );

                s.getWriter().write(
                        listJson(patients)
                );

                return;
            }


            // =====================================================
            // GET ALL PATIENTS
            // GET /api/patients
            // =====================================================

            if (path == null || "/".equals(path)) {

                List<Patient> patients =
                        patientService.getAllPatients();

                s.getWriter().write(
                        listJson(patients)
                );

                return;
            }


            // =====================================================
            // GET PATIENT BY ID
            // GET /api/patients/{id}
            // =====================================================

            int patientId;

            try {

                patientId =
                        Integer.parseInt(
                                path.substring(1)
                        );

            } catch (NumberFormatException e) {

                ApiUtil.error(
                        s,
                        400,
                        "Invalid patient ID"
                );

                return;
            }


            Patient patient =
                    patientService.getPatientById(
                            patientId
                    );


            if (patient == null) {

                ApiUtil.error(
                        s,
                        404,
                        "Patient not found"
                );

                return;
            }


            s.getWriter().write(
                    oneJson(patient)
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


            String patientCode =
                    params.get("patientCode");

            String name =
                    params.get("name");

            String address =
                    params.get("address");

            String phone =
                    params.get("contactNumber");

            String email =
                    params.get("email");


            // =====================================================
            // VALIDATION
            // =====================================================

            if (ApiUtil.blank(patientCode)) {

                ApiUtil.error(
                        s,
                        400,
                        "Patient code is required"
                );

                return;
            }


            if (ApiUtil.blank(name)
                    || ApiUtil.blank(address)
                    || ApiUtil.blank(phone)) {

                ApiUtil.error(
                        s,
                        400,
                        "Name, address and contact number are required"
                );

                return;
            }


            // =====================================================
            // CREATE PATIENT OBJECT
            // =====================================================

            Patient patient =
                    new Patient();

            patient.setPatientCode(
                    patientCode.trim()
            );

            patient.setName(
                    name.trim()
            );

            patient.setAddress(
                    address.trim()
            );

            patient.setContactNumber(
                    phone.trim()
            );


            if (ApiUtil.blank(email)) {

                patient.setEmail(null);

            } else {

                patient.setEmail(
                        email.trim()
                );
            }


            // =====================================================
            // CREATE THROUGH SERVICE
            // =====================================================

            if (patientService.createPatient(patient)) {

                s.setStatus(
                        HttpServletResponse.SC_CREATED
                );

                s.getWriter().write(
                        oneJson(patient)
                );

            } else {

                ApiUtil.error(
                        s,
                        400,
                        "Patient could not be created"
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
                        "Patient ID is required"
                );

                return;
            }


            int patientId;

            try {

                patientId =
                        Integer.parseInt(
                                path.substring(1)
                        );

            } catch (NumberFormatException e) {

                ApiUtil.error(
                        s,
                        400,
                        "Invalid patient ID"
                );

                return;
            }


            // =====================================================
            // FIND EXISTING PATIENT
            // =====================================================

            Patient patient =
                    patientService.getPatientById(
                            patientId
                    );


            if (patient == null) {

                ApiUtil.error(
                        s,
                        404,
                        "Patient not found"
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
                    params.get("name");

            String address =
                    params.get("address");

            String contactNumber =
                    params.get("contactNumber");

            String email =
                    params.get("email");


            // =====================================================
            // UPDATE VALUES
            // =====================================================

            if (name != null
                    && !name.trim().isEmpty()) {

                patient.setName(
                        name.trim()
                );
            }


            if (address != null
                    && !address.trim().isEmpty()) {

                patient.setAddress(
                        address.trim()
                );
            }


            if (contactNumber != null
                    && !contactNumber.trim().isEmpty()) {

                patient.setContactNumber(
                        contactNumber.trim()
                );
            }


            if (email != null) {

                patient.setEmail(
                        email.trim()
                );
            }


            // =====================================================
            // UPDATE THROUGH SERVICE
            // =====================================================

            if (patientService.updatePatient(patient)) {

                s.setStatus(
                        HttpServletResponse.SC_OK
                );

                s.getWriter().write(
                        oneJson(patient)
                );

            } else {

                ApiUtil.error(
                        s,
                        400,
                        "Patient could not be updated"
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
    // LIST JSON
    // =========================================================

    private String listJson(
            List<Patient> patients) {

        StringBuilder b =
                new StringBuilder("[");


        for (int i = 0;
             i < patients.size();
             i++) {

            if (i > 0) {
                b.append(",");
            }

            b.append(
                    oneJson(
                            patients.get(i)
                    )
            );
        }


        return b.append("]")
                .toString();
    }


    // =========================================================
    // SINGLE PATIENT JSON
    // =========================================================

    private String oneJson(
            Patient patient) {

        return "{"
                + "\"patientId\":"
                + patient.getPatientId()

                + ",\"patientCode\":"
                + ApiUtil.str(
                        patient.getPatientCode()
                )

                + ",\"name\":"
                + ApiUtil.str(
                        patient.getName()
                )

                + ",\"address\":"
                + ApiUtil.str(
                        patient.getAddress()
                )

                + ",\"contactNumber\":"
                + ApiUtil.str(
                        patient.getContactNumber()
                )

                + ",\"email\":"
                + ApiUtil.nullable(
                        patient.getEmail()
                )

                + "}";
    }
}
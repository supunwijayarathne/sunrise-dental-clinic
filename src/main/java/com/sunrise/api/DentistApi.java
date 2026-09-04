package com.sunrise.api;

import java.io.IOException;
import java.util.List;

import com.sunrise.model.Dentist;
import com.sunrise.service.DentistService;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/api/dentists/*")
public class DentistApi extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private DentistService dentistService;


    // =========================================================
    // INITIALIZE
    // =========================================================

    @Override
    public void init() {

        dentistService = new DentistService();
    }


    // =========================================================
    // OPTIONS / CORS
    // =========================================================

    @Override
    protected void doOptions(
            HttpServletRequest request,
            HttpServletResponse response) {

        ApiUtil.cors(response);
        ApiUtil.noContent(response);
    }


    // =========================================================
    // GET
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        ApiUtil.json(response);
        ApiUtil.cors(response);

        try {

            String path =
                    request.getPathInfo();

            String keyword =
                    request.getParameter("keyword");


            // =====================================================
            // SEARCH
            // GET /api/dentists?keyword=
            // =====================================================

            if (!ApiUtil.blank(keyword)) {

                List<Dentist> dentists =
                        dentistService.searchDentists(
                                keyword.trim()
                        );

                response.getWriter().write(
                        listJson(dentists)
                );

                return;
            }


            // =====================================================
            // GET ALL
            // GET /api/dentists
            // =====================================================

            if (path == null
                    || "/".equals(path)) {

                List<Dentist> dentists =
                        dentistService.getAllDentists();

                response.getWriter().write(
                        listJson(dentists)
                );

                return;
            }


            // =====================================================
            // GET BY ID
            // GET /api/dentists/{id}
            // =====================================================

            int dentistId;

            try {

                dentistId =
                        Integer.parseInt(
                                path.substring(1)
                        );

            } catch (NumberFormatException e) {

                ApiUtil.error(
                        response,
                        400,
                        "Invalid dentist ID"
                );

                return;
            }


            Dentist dentist =
                    dentistService.getDentistById(
                            dentistId
                    );


            if (dentist == null) {

                ApiUtil.error(
                        response,
                        404,
                        "Dentist not found"
                );

                return;
            }


            response.getWriter().write(
                    oneJson(dentist)
            );

        } catch (Exception e) {

            e.printStackTrace();

            ApiUtil.error(
                    response,
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
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        ApiUtil.json(response);
        ApiUtil.cors(response);

        request.setCharacterEncoding("UTF-8");

        try {

            String dentistName =
                    request.getParameter(
                            "dentistName"
                    );

            String specialization =
                    request.getParameter(
                            "specialization"
                    );

            String phoneNumber =
                    request.getParameter(
                            "phoneNumber"
                    );

            String email =
                    request.getParameter(
                            "email"
                    );

            String feeValue =
                    request.getParameter(
                            "consultationFee"
                    );

            String activeValue =
                    request.getParameter(
                            "active"
                    );


            // =====================================================
            // VALIDATE FEE
            // =====================================================

            double consultationFee;

            try {

                consultationFee =
                        Double.parseDouble(
                                feeValue
                        );

            } catch (Exception e) {

                ApiUtil.error(
                        response,
                        400,
                        "Invalid consultation fee"
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
            // CREATE OBJECT
            // =====================================================

            Dentist dentist =
                    new Dentist();

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


            // =====================================================
            // CREATE THROUGH SERVICE
            // =====================================================

            if (dentistService.createDentist(dentist)) {

                response.setStatus(
                        HttpServletResponse.SC_CREATED
                );

                response.getWriter().write(
                        oneJson(dentist)
                );

            } else {

                ApiUtil.error(
                        response,
                        400,
                        "Dentist name, specialization and a valid consultation fee are required"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            ApiUtil.error(
                    response,
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
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        ApiUtil.json(response);
        ApiUtil.cors(response);

        request.setCharacterEncoding("UTF-8");

        try {

            String path =
                    request.getPathInfo();


            // =====================================================
            // VALIDATE ID
            // =====================================================

            if (path == null
                    || "/".equals(path)) {

                ApiUtil.error(
                        response,
                        400,
                        "Dentist ID is required"
                );

                return;
            }


            int dentistId;

            try {

                dentistId =
                        Integer.parseInt(
                                path.substring(1)
                        );

            } catch (NumberFormatException e) {

                ApiUtil.error(
                        response,
                        400,
                        "Invalid dentist ID"
                );

                return;
            }


            // =====================================================
            // FIND EXISTING DENTIST
            // =====================================================

            Dentist dentist =
                    dentistService.getDentistById(
                            dentistId
                    );


            if (dentist == null) {

                ApiUtil.error(
                        response,
                        404,
                        "Dentist not found"
                );

                return;
            }


            // =====================================================
            // READ PUT PARAMETERS
            // =====================================================

            String dentistName =
                    request.getParameter(
                            "dentistName"
                    );

            String specialization =
                    request.getParameter(
                            "specialization"
                    );

            String consultationFee =
                    request.getParameter(
                            "consultationFee"
                    );

            String phoneNumber =
                    request.getParameter(
                            "phoneNumber"
                    );

            String email =
                    request.getParameter(
                            "email"
                    );

            String active =
                    request.getParameter(
                            "active"
                    );


            // =====================================================
            // UPDATE VALUES
            // =====================================================

            if (dentistName != null) {

                dentist.setDentistName(
                        dentistName.trim()
                );
            }


            if (specialization != null) {

                dentist.setSpecialization(
                        specialization.trim()
                );
            }


            if (!ApiUtil.blank(consultationFee)) {

                dentist.setConsultationFee(
                        Double.parseDouble(
                                consultationFee
                        )
                );
            }


            if (phoneNumber != null) {

                dentist.setPhoneNumber(
                        phoneNumber.trim()
                );
            }


            if (email != null) {

                dentist.setEmail(
                        email.trim()
                );
            }


            if (active != null) {

                dentist.setActive(
                        Boolean.parseBoolean(
                                active
                        )
                );
            }


            // =====================================================
            // UPDATE THROUGH SERVICE
            // =====================================================

            if (dentistService.updateDentist(dentist)) {

                response.setStatus(
                        HttpServletResponse.SC_OK
                );

                response.getWriter().write(
                        oneJson(dentist)
                );

            } else {

                ApiUtil.error(
                        response,
                        400,
                        "Dentist could not be updated"
                );
            }

        } catch (NumberFormatException e) {

            ApiUtil.error(
                    response,
                    400,
                    "Invalid consultation fee"
            );

        } catch (Exception e) {

            e.printStackTrace();

            ApiUtil.error(
                    response,
                    500,
                    "Server error"
            );
        }
    }


    // =========================================================
    // LIST JSON
    // =========================================================

    private String listJson(
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
                    oneJson(
                            dentists.get(i)
                    )
            );
        }


        return json.append("]")
                .toString();
    }


    // =========================================================
    // SINGLE DENTIST JSON
    // =========================================================

    private String oneJson(
            Dentist dentist) {

        return "{"
                + "\"dentistId\":"
                + dentist.getDentistId()

                + ",\"dentistName\":"
                + ApiUtil.str(
                        dentist.getDentistName()
                )

                + ",\"specialization\":"
                + ApiUtil.str(
                        dentist.getSpecialization()
                )

                + ",\"consultationFee\":"
                + dentist.getConsultationFee()

                + ",\"phoneNumber\":"
                + ApiUtil.str(
                        dentist.getPhoneNumber()
                )

                + ",\"email\":"
                + ApiUtil.nullable(
                        dentist.getEmail()
                )

                + ",\"active\":"
                + dentist.isActive()

                + "}";
    }
}
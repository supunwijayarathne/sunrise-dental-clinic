package com.sunrise.api;

import java.io.BufferedReader;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sunrise.model.Bill;
import com.sunrise.service.BillingService;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/api/billing/*")
public class BillingApi extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private BillingService billingService;

    // =========================================================
    // INITIALIZE
    // =========================================================

    @Override
    public void init() {

        billingService =
                new BillingService();
    }

    // =========================================================
    // OPTIONS
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

            String appointmentId =
                    request.getParameter(
                            "appointmentId"
                    );

            String patientId =
                    request.getParameter(
                            "patientId"
                    );

            String keyword =
                    request.getParameter(
                            "keyword"
                    );

            String billType =
                    request.getParameter(
                            "billType"
                    );

            // =================================================
            // GET BILL BY APPOINTMENT
            // =================================================

            if (!ApiUtil.blank(appointmentId)) {

                int id =
                        Integer.parseInt(
                                appointmentId
                        );

                Bill bill =
                        billingService
                                .getBillByAppointmentId(id);

                if (bill == null) {

                    ApiUtil.error(
                            response,
                            404,
                            "Bill not found"
                    );

                    return;
                }

                response.getWriter().write(
                        one(bill)
                );

                return;
            }

            // =================================================
            // GET BILLS BY PATIENT
            // =================================================

            if (!ApiUtil.blank(patientId)) {

                int id =
                        Integer.parseInt(
                                patientId
                        );

                List<Bill> bills =
                        billingService
                                .getBillsByPatient(id);

                response.getWriter().write(
                        list(bills)
                );

                return;
            }

            // =================================================
            // SEARCH / BILL TYPE FILTER
            // =================================================

            if (!ApiUtil.blank(keyword)
                    || !ApiUtil.blank(billType)) {

                String searchKeyword =
                        ApiUtil.blank(keyword)
                                ? ""
                                : keyword.trim();

                String searchBillType =
                        ApiUtil.blank(billType)
                                ? "ALL"
                                : billType.trim();

                List<Bill> bills =
                        billingService.searchBills(
                                searchKeyword,
                                searchBillType
                        );

                response.getWriter().write(
                        list(bills)
                );

                return;
            }

            // =================================================
            // GET ALL BILLS
            // =================================================

            if (path == null
                    || "/".equals(path)
                    || path.isEmpty()) {

                List<Bill> bills =
                        billingService.getAllBills();

                response.getWriter().write(
                        list(bills)
                );

                return;
            }

            // =================================================
            // GET BILL BY ID
            // =================================================

            int billId =
                    Integer.parseInt(
                            path.substring(1)
                    );

            Bill bill =
                    billingService.getBillById(
                            billId
                    );

            if (bill == null) {

                ApiUtil.error(
                        response,
                        404,
                        "Bill not found"
                );

                return;
            }

            response.getWriter().write(
                    one(bill)
            );

        } catch (NumberFormatException e) {

            ApiUtil.error(
                    response,
                    400,
                    "Invalid billing ID"
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

        request.setCharacterEncoding(
                "UTF-8"
        );

        try {

            // =================================================
            // READ REQUEST BODY
            // =================================================

            StringBuilder body =
                    new StringBuilder();

            String line;

            try (BufferedReader reader =
                         request.getReader()) {

                while ((line =
                        reader.readLine()) != null) {

                    body.append(line);
                }
            }

            Map<String, String> params =
                    parseFormData(
                            body.toString()
                    );

            // =================================================
            // READ PARAMETERS
            // =================================================

            String appointmentId =
                    params.get(
                            "appointmentId"
                    );

            String treatmentId =
                    params.get(
                            "treatmentId"
                    );

            String patientId =
                    params.get(
                            "patientId"
                    );

            String billType =
                    params.get(
                            "billType"
                    );

            String billNumber =
                    params.get(
                            "billNumber"
                    );

            String consultationFee =
                    params.get(
                            "consultationFee"
                    );

            String treatmentFee =
                    params.get(
                            "treatmentFee"
                    );

            // =================================================
            // REQUIRED VALIDATION
            // =================================================

            if (ApiUtil.blank(patientId)
                    || ApiUtil.blank(billType)
                    || ApiUtil.blank(billNumber)) {

                ApiUtil.error(
                        response,
                        400,
                        "patientId, billType and billNumber are required"
                );

                return;
            }

            if (ApiUtil.blank(consultationFee)
                    || ApiUtil.blank(treatmentFee)) {

                ApiUtil.error(
                        response,
                        400,
                        "consultationFee and treatmentFee are required"
                );

                return;
            }

            // =================================================
            // PARSE IDS
            // =================================================

            Integer appointment =
                    ApiUtil.blank(appointmentId)
                            ? null
                            : Integer.valueOf(
                                    appointmentId
                              );

            Integer treatment =
                    ApiUtil.blank(treatmentId)
                            ? null
                            : Integer.valueOf(
                                    treatmentId
                              );

            int patient =
                    Integer.parseInt(
                            patientId
                    );

            // =================================================
            // PARSE FEES
            // =================================================

            double consultation =
                    Double.parseDouble(
                            consultationFee
                    );

            double treatmentAmount =
                    Double.parseDouble(
                            treatmentFee
                    );

            // =================================================
            // GET LOGGED-IN USER
            // =================================================

            HttpSession session =
                    request.getSession(false);

            if (session == null
                    || session.getAttribute(
                            "userId"
                       ) == null) {

                ApiUtil.error(
                        response,
                        401,
                        "User is not authenticated"
                );

                return;
            }

            Object userIdObject =
                    session.getAttribute(
                            "userId"
                    );

            int createdBy;

            if (userIdObject instanceof Integer) {

                createdBy =
                        (Integer) userIdObject;

            } else {

                createdBy =
                        Integer.parseInt(
                                userIdObject.toString()
                        );
            }

            // =================================================
            // CREATE BILL MODEL
            // =================================================

            Bill bill =
                    new Bill(
                            billNumber,
                            appointment,
                            patient,
                            treatment,
                            billType,
                            consultation,
                            treatmentAmount,
                            consultation
                                    + treatmentAmount,
                            createdBy
                    );

            // =================================================
            // CHECK DUPLICATE BILL NUMBER
            // =================================================

            if (billingService.billNumberExists(
                    billNumber
            )) {

                ApiUtil.error(
                        response,
                        409,
                        "Bill number already exists"
                );

                return;
            }

            // =================================================
            // CHECK DUPLICATE APPOINTMENT BILL
            // =================================================

            if (appointment != null
                    && billingService
                            .appointmentAlreadyBilled(
                                    appointment
                            )) {

                ApiUtil.error(
                        response,
                        409,
                        "Appointment is already billed"
                );

                return;
            }

            // =================================================
            // CREATE BILL THROUGH SERVICE
            // =================================================

            if (billingService.createBill(
                    bill
            )) {

                response.setStatus(
                        HttpServletResponse.SC_CREATED
                );

                response.getWriter().write(
                        one(bill)
                );

                return;
            }

            // =================================================
            // CREATION FAILED
            // =================================================

            ApiUtil.error(
                    response,
                    400,
                    "Bill could not be created"
            );

        } catch (NumberFormatException e) {

            ApiUtil.error(
                    response,
                    400,
                    "Invalid billing value"
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
    // CONVERT LIST TO JSON
    // =========================================================

    private String list(
            List<Bill> bills) {

        StringBuilder json =
                new StringBuilder("[");

        for (int i = 0;
             i < bills.size();
             i++) {

            if (i > 0) {
                json.append(",");
            }

            json.append(
                    one(
                            bills.get(i)
                    )
            );
        }

        json.append("]");

        return json.toString();
    }

    // =========================================================
    // CONVERT BILL TO JSON
    // =========================================================

    private String one(
            Bill bill) {

        return "{"
                + "\"billId\":"
                + bill.getBillId()
                + ","

                + "\"billNumber\":"
                + ApiUtil.str(
                        bill.getBillNumber()
                  )
                + ","

                + "\"appointmentId\":"
                + (
                    bill.getAppointmentId() == null
                        ? "null"
                        : bill.getAppointmentId()
                  )
                + ","

                + "\"patientId\":"
                + bill.getPatientId()
                + ","

                + "\"treatmentId\":"
                + (
                    bill.getTreatmentId() == null
                        ? "null"
                        : bill.getTreatmentId()
                  )
                + ","

                + "\"billType\":"
                + ApiUtil.str(
                        bill.getBillType()
                  )
                + ","

                + "\"consultationFee\":"
                + bill.getConsultationFee()
                + ","

                + "\"treatmentFee\":"
                + bill.getTreatmentFee()
                + ","

                + "\"totalAmount\":"
                + bill.getTotalAmount()

                + "}";
    }

    // =========================================================
    // PARSE FORM DATA
    // =========================================================

    private Map<String, String> parseFormData(
            String body) {

        Map<String, String> params =
                new HashMap<>();

        if (body == null
                || body.isEmpty()) {

            return params;
        }

        String[] pairs =
                body.split("&");

        for (String pair : pairs) {

            String[] keyValue =
                    pair.split(
                            "=",
                            2
                    );

            String key =
                    URLDecoder.decode(
                            keyValue[0],
                            StandardCharsets.UTF_8
                    );

            String value = "";

            if (keyValue.length > 1) {

                value =
                        URLDecoder.decode(
                                keyValue[1],
                                StandardCharsets.UTF_8
                        );
            }

            params.put(
                    key,
                    value
            );
        }

        return params;
    }
}
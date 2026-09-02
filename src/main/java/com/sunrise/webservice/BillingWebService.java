package com.sunrise.webservice;

import java.io.IOException;
import java.util.List;

import com.sunrise.dao.BillDAO;
import com.sunrise.model.Bill;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/api/billing/*")
public class BillingWebService extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private BillDAO billDAO;

    @Override
    public void init() {
        billDAO = new BillDAO();
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

            String appointment =
                    request.getParameter(
                            "appointmentId"
                    );

            if (appointment != null) {

                int appointmentId =
                        Integer.parseInt(
                                appointment
                        );

                Bill bill =
                        billDAO.getBillByAppointmentId(
                                appointmentId
                        );

                if (bill == null) {

                    response.setStatus(404);

                    response.getWriter().write(
                            "{\"success\":false,\"message\":\"Bill not found\"}"
                    );

                    return;
                }

                response.getWriter().write(
                        billToJson(bill)
                );

                return;
            }

            if (path == null || path.equals("/")) {

                List<Bill> bills =
                        billDAO.getAllBills();

                response.getWriter().write(
                        billsToJson(bills)
                );

                return;
            }

            int billId =
                    Integer.parseInt(
                            path.substring(1)
                    );

            Bill bill =
                    billDAO.getBillById(
                            billId
                    );

            if (bill == null) {

                response.setStatus(404);

                response.getWriter().write(
                        "{\"success\":false,\"message\":\"Bill not found\"}"
                );

                return;
            }

            response.getWriter().write(
                    billToJson(bill)
            );

        } catch (NumberFormatException e) {

            response.setStatus(400);

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"Invalid billing ID\"}"
            );

        } catch (Exception e) {

            response.setStatus(500);

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"Server error\"}"
            );
        }
    }

    private String billsToJson(
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
                    billToJson(
                            bills.get(i)
                    )
            );
        }

        json.append("]");

        return json.toString();
    }

    private String billToJson(
            Bill b) {

        return "{"
                + "\"billId\":"
                + b.getBillId()
                + ","
                + "\"billNumber\":\""
                + escape(b.getBillNumber())
                + "\","
                + "\"appointmentId\":"
                + nullableInteger(
                        b.getAppointmentId()
                )
                + ","
                + "\"patientId\":"
                + b.getPatientId()
                + ","
                + "\"billType\":\""
                + escape(b.getBillType())
                + "\","
                + "\"consultationFee\":"
                + b.getConsultationFee()
                + ","
                + "\"treatmentFee\":"
                + b.getTreatmentFee()
                + ","
                + "\"totalAmount\":"
                + b.getTotalAmount()
                + "}";
    }

    private String nullableInteger(
            Integer value) {

        return value == null
                ? "null"
                : value.toString();
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
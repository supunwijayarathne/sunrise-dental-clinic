package com.sunrise.api;

import java.io.IOException;

import com.sunrise.model.ReportAppointment;
import com.sunrise.model.ReportBill;
import com.sunrise.model.ReportStats;
import com.sunrise.model.ReportTreatment;
import com.sunrise.service.ReportService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/api/reports/*")
public class ReportApi extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ReportService reportService;

    @Override
    public void init() {
        reportService = new ReportService();
    }

    /**
     * Handle CORS preflight requests.
     */
    @Override
    protected void doOptions(
            HttpServletRequest request,
            HttpServletResponse response) {

        ApiUtil.cors(response);
        ApiUtil.noContent(response);
    }

    /**
     * GET /api/reports?startDate=yyyy-MM-dd&endDate=yyyy-MM-dd
     *
     * Generates report statistics for the selected date range.
     *
     * Admin access only.
     */
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        ApiUtil.json(response);
        ApiUtil.cors(response);

        /*
         * Check authentication
         */
        HttpSession session = request.getSession(false);

        if (session == null
                || !"Admin".equalsIgnoreCase(
                        String.valueOf(session.getAttribute("role")))) {

            ApiUtil.error(
                    response,
                    403,
                    "Access denied. Admin role required."
            );

            return;
        }

        /*
         * Read query parameters
         */
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        /*
         * Validate required parameters
         */
        if (ApiUtil.blank(startDate)
                || ApiUtil.blank(endDate)) {

            ApiUtil.error(
                    response,
                    400,
                    "startDate and endDate are required"
            );

            return;
        }

        try {

            /*
             * Service layer handles validation
             * and communicates with ReportDAO.
             */
            ReportStats reportStats =
                    reportService.getReportStats(
                            startDate,
                            endDate
                    );

            response.getWriter().write(
                    buildReportJson(reportStats)
            );

        } catch (IllegalArgumentException e) {

            ApiUtil.error(
                    response,
                    400,
                    e.getMessage()
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

    /**
     * Convert ReportStats into JSON.
     */
    private String buildReportJson(ReportStats reportStats) {

        StringBuilder json = new StringBuilder();

        json.append("{");

        /*
         * Summary statistics
         */
        json.append("\"totalBills\":")
                .append(reportStats.getTotalBills());

        json.append(",\"appointmentBills\":")
                .append(reportStats.getAppointmentBills());

        json.append(",\"walkInBills\":")
                .append(reportStats.getWalkInBills());

        json.append(",\"totalAppointments\":")
                .append(reportStats.getTotalAppointments());

        json.append(",\"scheduledAppointments\":")
                .append(reportStats.getScheduledAppointments());

        json.append(",\"completedAppointments\":")
                .append(reportStats.getCompletedAppointments());

        json.append(",\"cancelledAppointments\":")
                .append(reportStats.getCancelledAppointments());

        json.append(",\"noShowAppointments\":")
                .append(reportStats.getNoShowAppointments());

        json.append(",\"billedAppointments\":")
                .append(reportStats.getBilledAppointments());

        /*
         * Revenue
         */
        json.append(",\"totalRevenue\":")
                .append(reportStats.getTotalRevenue());

        json.append(",\"appointmentRevenue\":")
                .append(reportStats.getAppointmentRevenue());

        json.append(",\"walkInRevenue\":")
                .append(reportStats.getWalkInRevenue());

        /*
         * Revenue chart data
         */
        json.append(",\"revenueDates\":")
                .append(buildStringArray(
                        reportStats.getRevenueDates()
                ));

        json.append(",\"dailyRevenue\":")
                .append(buildDoubleArray(
                        reportStats.getDailyRevenue()
                ));

        /*
         * Bills
         */
        json.append(",\"bills\":[");

        for (int i = 0;
             i < reportStats.getBills().size();
             i++) {

            if (i > 0) {
                json.append(",");
            }

            ReportBill bill =
                    reportStats.getBills().get(i);

            json.append("{");

            json.append("\"billNumber\":")
                    .append(ApiUtil.str(
                            bill.getBillNumber()
                    ));

            json.append(",\"createdAt\":")
                    .append(ApiUtil.str(
                            String.valueOf(
                                    bill.getCreatedAt()
                            )
                    ));

            json.append(",\"billType\":")
                    .append(ApiUtil.str(
                            bill.getBillType()
                    ));

            json.append(",\"patientName\":")
                    .append(ApiUtil.str(
                            bill.getPatientName()
                    ));

            json.append(",\"treatmentName\":")
                    .append(ApiUtil.str(
                            bill.getTreatmentName()
                    ));

            json.append(",\"consultationFee\":")
                    .append(bill.getConsultationFee());

            json.append(",\"treatmentFee\":")
                    .append(bill.getTreatmentFee());

            json.append(",\"totalAmount\":")
                    .append(bill.getTotalAmount());

            json.append("}");
        }

        json.append("]");

        /*
         * Appointments
         */
        json.append(",\"appointments\":[");

        for (int i = 0;
             i < reportStats.getAppointments().size();
             i++) {

            if (i > 0) {
                json.append(",");
            }

            ReportAppointment appointment =
                    reportStats.getAppointments().get(i);

            json.append("{");

            json.append("\"appointmentNumber\":")
                    .append(ApiUtil.str(
                            appointment.getAppointmentNumber()
                    ));

            json.append(",\"appointmentDate\":")
                    .append(ApiUtil.date(
                            appointment.getAppointmentDate()
                    ));

            json.append(",\"appointmentTime\":")
                    .append(ApiUtil.time(
                            appointment.getAppointmentTime()
                    ));

            json.append(",\"patientName\":")
                    .append(ApiUtil.str(
                            appointment.getPatientName()
                    ));

            json.append(",\"dentistName\":")
                    .append(ApiUtil.str(
                            appointment.getDentistName()
                    ));

            json.append(",\"treatmentName\":")
                    .append(ApiUtil.str(
                            appointment.getTreatmentName()
                    ));

            json.append(",\"status\":")
                    .append(ApiUtil.str(
                            appointment.getStatus()
                    ));

            json.append("}");
        }

        json.append("]");

        /*
         * Treatments
         */
        json.append(",\"treatments\":[");

        for (int i = 0;
             i < reportStats.getTreatments().size();
             i++) {

            if (i > 0) {
                json.append(",");
            }

            ReportTreatment treatment =
                    reportStats.getTreatments().get(i);

            json.append("{");

            json.append("\"treatmentName\":")
                    .append(ApiUtil.str(
                            treatment.getTreatmentName()
                    ));

            json.append(",\"completedCount\":")
                    .append(treatment.getCompletedCount());

            json.append("}");
        }

        json.append("]");

        /*
         * Close JSON object
         */
        json.append("}");

        return json.toString();
    }

    /**
     * Convert List<String> into JSON array.
     */
    private String buildStringArray(
            java.util.List<String> values) {

        StringBuilder json =
                new StringBuilder("[");

        if (values != null) {

            for (int i = 0; i < values.size(); i++) {

                if (i > 0) {
                    json.append(",");
                }

                json.append(
                        ApiUtil.str(values.get(i))
                );
            }
        }

        json.append("]");

        return json.toString();
    }

    /**
     * Convert List<Double> into JSON array.
     */
    private String buildDoubleArray(
            java.util.List<Double> values) {

        StringBuilder json =
                new StringBuilder("[");

        if (values != null) {

            for (int i = 0; i < values.size(); i++) {

                if (i > 0) {
                    json.append(",");
                }

                json.append(values.get(i));
            }
        }

        json.append("]");

        return json.toString();
    }
}
package com.sunrise.controller;

import java.io.IOException;
import java.time.Year;
import java.util.List;

import com.sunrise.dao.AppointmentDAO;
import com.sunrise.dao.BillDAO;
import com.sunrise.dao.DentistDAO;
import com.sunrise.dao.PatientDAO;
import com.sunrise.dao.TreatmentDAO;

import com.sunrise.model.Appointment;
import com.sunrise.model.Bill;
import com.sunrise.model.Dentist;
import com.sunrise.model.Patient;
import com.sunrise.model.Treatment;
import com.sunrise.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/bills/*")
public class BillingController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private BillDAO billDAO;
    private AppointmentDAO appointmentDAO;
    private PatientDAO patientDAO;
    private DentistDAO dentistDAO;
    private TreatmentDAO treatmentDAO;


    // =========================================================
    // INITIALIZE
    // =========================================================

    @Override
    public void init() {

        billDAO = new BillDAO();
        appointmentDAO = new AppointmentDAO();
        patientDAO = new PatientDAO();
        dentistDAO = new DentistDAO();
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

            listBills(request, response);

        } else if (path.equals("/add")) {

            showAddForm(request, response);

        } else if (path.equals("/view")) {

            viewBill(request, response);

        } else if (path.equals("/print")) {

            printBill(request, response);

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

            addBill(request, response);

        } else {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND
            );
        }
    }


    // =========================================================
    // LIST / SEARCH
    // =========================================================

    private void listBills(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String keyword =
                request.getParameter("keyword");

        List<Bill> bills;

        if (keyword != null
                && !keyword.trim().isEmpty()) {

            keyword = keyword.trim();

            bills =
                    billDAO.searchBills(keyword);

        } else {

            bills =
                    billDAO.getAllBills();
        }

        request.setAttribute(
                "bills",
                bills
        );

        request.setAttribute(
                "keyword",
                keyword
        );

        request.getRequestDispatcher(
                "/WEB-INF/views/bills/bill-list.jsp"
        ).forward(request, response);
    }


    // =========================================================
    // SHOW ADD FORM
    // =========================================================

    private void showAddForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        loadBillFormData(request);

        generateBillNumber(request);

        request.setAttribute(
                "formMode",
                "add"
        );

        request.getRequestDispatcher(
                "/WEB-INF/views/bills/bill-form.jsp"
        ).forward(request, response);
    }


    // =========================================================
    // ADD BILL
    // =========================================================

    private void addBill(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String appointmentIdText =
                clean(
                        request.getParameter(
                                "appointmentId"
                        )
                );


        int appointmentId;

        try {

            appointmentId =
                    Integer.parseInt(
                            appointmentIdText
                    );

        } catch (NumberFormatException e) {

            showAddError(
                    request,
                    response,
                    "Please select a valid appointment."
            );

            return;
        }


        // =====================================================
        // CHECK APPOINTMENT
        // =====================================================

        Appointment appointment =
                appointmentDAO.getAppointmentById(
                        appointmentId
                );

        if (appointment == null) {

            showAddError(
                    request,
                    response,
                    "Selected appointment does not exist."
            );

            return;
        }


        // =====================================================
        // CHECK DUPLICATE BILL
        // =====================================================

        if (billDAO.appointmentAlreadyBilled(
                appointmentId)) {

            showAddError(
                    request,
                    response,
                    "This appointment has already been billed."
            );

            return;
        }


        // =====================================================
        // GET DENTIST
        // =====================================================

        Dentist dentist =
                dentistDAO.getDentistById(
                        appointment.getDentistId()
                );

        if (dentist == null) {

            showAddError(
                    request,
                    response,
                    "Unable to find the dentist for this appointment."
            );

            return;
        }


        // =====================================================
        // GET TREATMENT
        // =====================================================

        Treatment treatment =
                treatmentDAO.getTreatmentById(
                        appointment.getTreatmentId()
                );

        if (treatment == null) {

            showAddError(
                    request,
                    response,
                    "Unable to find the treatment for this appointment."
            );

            return;
        }


        // =====================================================
        // CALCULATE FEES
        // =====================================================

        double consultationFee =
                dentist.getConsultationFee();

        double treatmentFee =
                treatment.getTreatmentFee();

        double totalAmount =
                consultationFee + treatmentFee;


        // =====================================================
        // GET LOGGED-IN USER
        // =====================================================

        HttpSession session =
                request.getSession(false);

        if (session == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login"
            );

            return;
        }


        User loggedUser =
                (User) session.getAttribute(
                        "loggedUser"
                );

        if (loggedUser == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login"
            );

            return;
        }


        int createdBy =
                loggedUser.getUserId();


        // =====================================================
        // GENERATE BILL NUMBER
        // =====================================================

        int nextBillId =
                billDAO.getNextBillId();

        if (nextBillId <= 0) {

            showAddError(
                    request,
                    response,
                    "Unable to generate bill number."
            );

            return;
        }


        String billNumber =
                "BILL-"
                + Year.now().getValue()
                + "-"
                + String.format(
                        "%04d",
                        nextBillId
                );


        // =====================================================
        // CREATE BILL
        // =====================================================

        Bill bill =
                new Bill(
                        billNumber,
                        appointmentId,
                        consultationFee,
                        treatmentFee,
                        totalAmount,
                        createdBy
                );


        boolean success =
                billDAO.addBill(bill);


        if (success) {

            Bill savedBill =
                    billDAO.getBillByAppointmentId(
                            appointmentId
                    );

            response.sendRedirect(
                    request.getContextPath()
                    + "/bills/view?id="
                    + savedBill.getBillId()
                    + "&success=1"
            );

        } else {

            showAddError(
                    request,
                    response,
                    "Unable to create bill."
            );
        }
    }


    // =========================================================
    // VIEW BILL
    // =========================================================

    private void viewBill(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int billId =
                    Integer.parseInt(
                            request.getParameter("id")
                    );


            Bill bill =
                    billDAO.getBillById(
                            billId
                    );


            if (bill == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Bill not found."
                );

                return;
            }


            loadBillDetails(
                    request,
                    bill
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/bills/bill-details.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid bill ID."
            );
        }
    }


    // =========================================================
    // PRINT BILL
    // =========================================================

    private void printBill(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int billId =
                    Integer.parseInt(
                            request.getParameter("id")
                    );


            Bill bill =
                    billDAO.getBillById(
                            billId
                    );


            if (bill == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Bill not found."
                );

                return;
            }


            loadBillDetails(
                    request,
                    bill
            );


            request.getRequestDispatcher(
                    "/WEB-INF/views/bills/bill-print.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid bill ID."
            );
        }
    }


    // =========================================================
    // LOAD BILL DETAILS
    // =========================================================

    private void loadBillDetails(
            HttpServletRequest request,
            Bill bill) {

        Appointment appointment =
                appointmentDAO.getAppointmentById(
                        bill.getAppointmentId()
                );


        Patient patient = null;
        Dentist dentist = null;
        Treatment treatment = null;


        if (appointment != null) {

            patient =
                    patientDAO.getPatientById(
                            appointment.getPatientId()
                    );

            dentist =
                    dentistDAO.getDentistById(
                            appointment.getDentistId()
                    );

            treatment =
                    treatmentDAO.getTreatmentById(
                            appointment.getTreatmentId()
                    );
        }


        request.setAttribute(
                "bill",
                bill
        );

        request.setAttribute(
                "appointment",
                appointment
        );

        request.setAttribute(
                "patient",
                patient
        );

        request.setAttribute(
                "dentist",
                dentist
        );

        request.setAttribute(
                "treatment",
                treatment
        );
    }


    // =========================================================
    // LOAD FORM DATA
    // =========================================================

    private void loadBillFormData(
            HttpServletRequest request) {

        List<Appointment> appointments =
                appointmentDAO.getAllAppointments();

        request.setAttribute(
                "appointments",
                appointments
        );
    }


    // =========================================================
    // GENERATE DISPLAY BILL NUMBER
    // =========================================================

    private void generateBillNumber(
            HttpServletRequest request) {

        int nextBillId =
                billDAO.getNextBillId();

        if (nextBillId > 0) {

            String billNumber =
                    "BILL-"
                    + Year.now().getValue()
                    + "-"
                    + String.format(
                            "%04d",
                            nextBillId
                    );

            request.setAttribute(
                    "generatedBillNumber",
                    billNumber
            );
        }
    }


    // =========================================================
    // SHOW ADD ERROR
    // =========================================================

    private void showAddError(
            HttpServletRequest request,
            HttpServletResponse response,
            String error)
            throws ServletException, IOException {

        loadBillFormData(request);

        generateBillNumber(request);

        request.setAttribute(
                "formMode",
                "add"
        );

        request.setAttribute(
                "error",
                error
        );

        request.getRequestDispatcher(
                "/WEB-INF/views/bills/bill-form.jsp"
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
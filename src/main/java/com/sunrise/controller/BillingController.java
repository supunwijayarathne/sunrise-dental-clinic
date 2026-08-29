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
    // INIT
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


        if (path == null || "/".equals(path)) {

            listBills(request, response);

        }

        else if ("/add".equals(path)) {

            showAddForm(request, response);

        }

        else if ("/view".equals(path)) {

            viewBill(request, response);

        }

        else if ("/print".equals(path)) {

            printBill(request, response);

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

        String path = request.getPathInfo();


        if ("/add".equals(path)) {

            addBill(request, response);

        }

        else {

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
                clean(request.getParameter("keyword"));

        String billType =
                clean(request.getParameter("billType"));


        List<Bill> bills;


        if (!keyword.isEmpty()) {

            bills = billDAO.searchBills(
                    keyword,
                    billType
            );

        }

        else if (!billType.isEmpty()
                && !"ALL".equalsIgnoreCase(billType)) {

            bills = billDAO.searchBills(
                    "",
                    billType
            );

        }

        else {

            bills = billDAO.getAllBills();
        }


        request.setAttribute(
                "bills",
                bills
        );

        request.setAttribute(
                "keyword",
                keyword
        );

        request.setAttribute(
                "billType",
                billType
        );


        request.getRequestDispatcher(
                "/WEB-INF/views/bills/bill-list.jsp"
        ).forward(
                request,
                response
        );
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
        ).forward(
                request,
                response
        );
    }


    // =========================================================
    // ADD BILL
    // =========================================================

    private void addBill(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        String billType =
                clean(request.getParameter("billType"));


        // =====================================================
        // VALID BILL TYPE
        // =====================================================

        if (!"APPOINTMENT".equals(billType)
                && !"WALK_IN".equals(billType)) {

            showAddError(
                    request,
                    response,
                    "Please select a valid bill type."
            );

            return;
        }


        // =====================================================
        // LOGGED USER
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
        // VARIABLES
        // =====================================================

        Integer appointmentId = null;

        Integer treatmentId = null;

        int patientId;

        double consultationFee;

        double treatmentFee;


        // =====================================================
        // APPOINTMENT BILL
        // =====================================================

        if ("APPOINTMENT".equals(billType)) {


            String appointmentIdText =
                    clean(
                            request.getParameter(
                                    "appointmentId"
                            )
                    );


            // -------------------------------------------------
            // APPOINTMENT ID
            // -------------------------------------------------

            try {

                appointmentId =
                        Integer.parseInt(
                                appointmentIdText
                        );

            }

            catch (NumberFormatException e) {

                showAddError(
                        request,
                        response,
                        "Please select a valid appointment."
                );

                return;
            }


            // -------------------------------------------------
            // GET APPOINTMENT
            // -------------------------------------------------

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


            // -------------------------------------------------
            // CHECK ALREADY BILLED
            // -------------------------------------------------

            if (billDAO.appointmentAlreadyBilled(
                    appointmentId)) {

                showAddError(
                        request,
                        response,
                        "This appointment has already been billed."
                );

                return;
            }


            // -------------------------------------------------
            // PATIENT
            // -------------------------------------------------

            patientId =
                    appointment.getPatientId();


            Patient patient =
                    patientDAO.getPatientById(
                            patientId
                    );


            if (patient == null) {

                showAddError(
                        request,
                        response,
                        "Unable to find the patient for this appointment."
                );

                return;
            }


            // -------------------------------------------------
            // TREATMENT
            // -------------------------------------------------

            treatmentId =
                    appointment.getTreatmentId();


            Treatment treatment =
                    treatmentDAO.getTreatmentById(
                            treatmentId
                    );


            if (treatment == null) {

                showAddError(
                        request,
                        response,
                        "Unable to find the treatment for this appointment."
                );

                return;
            }


            // -------------------------------------------------
            // DENTIST
            // -------------------------------------------------

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


            // -------------------------------------------------
            // FEES
            // -------------------------------------------------

            consultationFee =
                    dentist.getConsultationFee();


            treatmentFee =
                    treatment.getTreatmentFee();
        }


        // =====================================================
        // WALK-IN / CUSTOM BILL
        // =====================================================

        else {


            String patientIdText =
                    clean(
                            request.getParameter(
                                    "patientId"
                            )
                    );


            String treatmentIdText =
                    clean(
                            request.getParameter(
                                    "treatmentId"
                            )
                    );


            String consultationFeeText =
                    clean(
                            request.getParameter(
                                    "consultationFee"
                            )
                    );


            // -------------------------------------------------
            // PATIENT ID
            // -------------------------------------------------

            try {

                patientId =
                        Integer.parseInt(
                                patientIdText
                        );

            }

            catch (NumberFormatException e) {

                showAddError(
                        request,
                        response,
                        "Please select a valid patient."
                );

                return;
            }


            // -------------------------------------------------
            // CHECK PATIENT
            // -------------------------------------------------

            Patient patient =
                    patientDAO.getPatientById(
                            patientId
                    );


            if (patient == null) {

                showAddError(
                        request,
                        response,
                        "Selected patient does not exist."
                );

                return;
            }


            // -------------------------------------------------
            // TREATMENT ID
            // -------------------------------------------------

            try {

                treatmentId =
                        Integer.parseInt(
                                treatmentIdText
                        );

            }

            catch (NumberFormatException e) {

                showAddError(
                        request,
                        response,
                        "Please select a valid treatment."
                );

                return;
            }


            // -------------------------------------------------
            // GET TREATMENT
            // -------------------------------------------------

            Treatment treatment =
                    treatmentDAO.getTreatmentById(
                            treatmentId
                    );


            if (treatment == null) {

                showAddError(
                        request,
                        response,
                        "Selected treatment does not exist."
                );

                return;
            }


            // -------------------------------------------------
            // CONSULTATION FEE
            // -------------------------------------------------

            try {

                consultationFee =
                        Double.parseDouble(
                                consultationFeeText
                        );

            }

            catch (NumberFormatException e) {

                showAddError(
                        request,
                        response,
                        "Please enter a valid consultation fee."
                );

                return;
            }


            if (consultationFee < 0) {

                showAddError(
                        request,
                        response,
                        "Consultation fee cannot be negative."
                );

                return;
            }


            // -------------------------------------------------
            // TREATMENT FEE
            // -------------------------------------------------

            treatmentFee =
                    treatment.getTreatmentFee();
        }


        // =====================================================
        // TOTAL
        // =====================================================

        double totalAmount =
                consultationFee + treatmentFee;


        // =====================================================
        // BILL NUMBER
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
                        patientId,
                        treatmentId,
                        billType,
                        consultationFee,
                        treatmentFee,
                        totalAmount,
                        createdBy
                );


        boolean success =
                billDAO.addBill(bill);


        // =====================================================
        // SUCCESS
        // =====================================================

        if (success) {


            Bill savedBill = null;


            if (appointmentId != null) {

                savedBill =
                        billDAO.getBillByAppointmentId(
                                appointmentId
                        );
            }


            else {

                savedBill =
                        findBillByNumber(
                                billNumber
                        );
            }


            if (savedBill != null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/bills/view?id="
                        + savedBill.getBillId()
                        + "&success=1"
                );

            }

            else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/bills?success=1"
                );
            }

        }


        else {

            showAddError(
                    request,
                    response,
                    "Unable to create bill."
            );
        }
    }


    // =========================================================
    // FIND BILL BY NUMBER
    // =========================================================

    private Bill findBillByNumber(
            String billNumber) {


        if (billNumber == null
                || billNumber.isEmpty()) {

            return null;
        }


        List<Bill> bills =
                billDAO.searchBills(
                        billNumber,
                        "ALL"
                );


        for (Bill bill : bills) {

            if (billNumber.equals(
                    bill.getBillNumber())) {

                return bill;
            }
        }


        return null;
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
                            request.getParameter(
                                    "id"
                            )
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


        }

        catch (NumberFormatException e) {

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
                            request.getParameter(
                                    "id"
                            )
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


        }

        catch (NumberFormatException e) {

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


        // -----------------------------------------------------
        // PATIENT
        // -----------------------------------------------------

        Patient patient =
                patientDAO.getPatientById(
                        bill.getPatientId()
                );


        // -----------------------------------------------------
        // TREATMENT
        // -----------------------------------------------------

        Treatment treatment = null;


        if (bill.getTreatmentId() != null) {

            treatment =
                    treatmentDAO.getTreatmentById(
                            bill.getTreatmentId()
                    );
        }


        // -----------------------------------------------------
        // APPOINTMENT
        // -----------------------------------------------------

        Appointment appointment = null;

        Dentist dentist = null;


        if (bill.getAppointmentId() != null) {


            appointment =
                    appointmentDAO.getAppointmentById(
                            bill.getAppointmentId()
                    );


            if (appointment != null) {

                dentist =
                        dentistDAO.getDentistById(
                                appointment.getDentistId()
                        );
            }
        }


        // -----------------------------------------------------
        // SEND TO JSP
        // -----------------------------------------------------

        request.setAttribute(
                "bill",
                bill
        );


        request.setAttribute(
                "patient",
                patient
        );


        request.setAttribute(
                "treatment",
                treatment
        );


        request.setAttribute(
                "appointment",
                appointment
        );


        request.setAttribute(
                "dentist",
                dentist
        );
    }


    // =========================================================
    // LOAD FORM DATA
    // =========================================================

    private void loadBillFormData(
            HttpServletRequest request) {


        List<Appointment> appointments =
                appointmentDAO.getAllAppointments();


        List<Patient> patients =
                patientDAO.getAllPatients();


        List<Treatment> treatments =
                treatmentDAO.getAllTreatments();


        List<Dentist> dentists =
                dentistDAO.getAllDentists();


        // -----------------------------------------------------
        // APPOINTMENTS
        // -----------------------------------------------------

        request.setAttribute(
                "appointments",
                appointments
        );


        // -----------------------------------------------------
        // PATIENTS
        // -----------------------------------------------------

        request.setAttribute(
                "patients",
                patients
        );


        // -----------------------------------------------------
        // TREATMENTS
        // -----------------------------------------------------

        request.setAttribute(
                "treatments",
                treatments
        );


        // -----------------------------------------------------
        // DENTISTS
        // -----------------------------------------------------

        request.setAttribute(
                "dentists",
                dentists
        );
    }


    // =========================================================
    // GENERATE BILL NUMBER
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
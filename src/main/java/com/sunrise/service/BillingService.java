package com.sunrise.service;

import java.util.List;

import com.sunrise.dao.BillDAO;
import com.sunrise.model.Bill;

/**
 * Service layer for billing operations.
 *
 * Responsibilities:
 * - Validate billing data
 * - Apply billing business rules
 * - Delegate database operations to BillDAO
 *
 * Architecture:
 * API -> Service -> DAO -> Database
 */
public class BillingService {

    private final BillDAO billDAO;

    public BillingService() {
        this.billDAO = new BillDAO();
    }

    // =========================================================
    // GET ALL BILLS
    // =========================================================

    public List<Bill> getAllBills() {

        return billDAO.getAllBills();
    }

    // =========================================================
    // GET BILL BY ID
    // =========================================================

    public Bill getBillById(int billId) {

        if (billId <= 0) {
            return null;
        }

        return billDAO.getBillById(billId);
    }

    // =========================================================
    // GET BILL BY APPOINTMENT
    // =========================================================

    public Bill getBillByAppointmentId(int appointmentId) {

        if (appointmentId <= 0) {
            return null;
        }

        return billDAO.getBillByAppointmentId(
                appointmentId
        );
    }

    // =========================================================
    // GET BILLS BY PATIENT
    // =========================================================

    public List<Bill> getBillsByPatient(int patientId) {

        if (patientId <= 0) {
            return List.of();
        }

        return billDAO.getBillsByPatient(
                patientId
        );
    }

    // =========================================================
    // SEARCH BILLS
    // =========================================================

    public List<Bill> searchBills(
            String keyword,
            String billType) {

        if (keyword == null) {
            keyword = "";
        }

        keyword = keyword.trim();

        if (billType == null
                || billType.trim().isEmpty()) {

            billType = "ALL";

        } else {

            billType = billType.trim();
        }

        return billDAO.searchBills(
                keyword,
                billType
        );
    }

    // =========================================================
    // CREATE BILL
    // =========================================================

    public boolean createBill(Bill bill) {

        if (bill == null) {
            return false;
        }

        // -----------------------------------------------------
        // Required bill number
        // -----------------------------------------------------

        if (bill.getBillNumber() == null
                || bill.getBillNumber().trim().isEmpty()) {

            return false;
        }

        // -----------------------------------------------------
        // Patient is required
        // -----------------------------------------------------

        if (bill.getPatientId() <= 0) {
            return false;
        }

        // -----------------------------------------------------
        // Bill type is required
        // -----------------------------------------------------

        if (bill.getBillType() == null
                || bill.getBillType().trim().isEmpty()) {

            return false;
        }

        // -----------------------------------------------------
        // Fees cannot be negative
        // -----------------------------------------------------

        if (bill.getConsultationFee() < 0
                || bill.getTreatmentFee() < 0) {

            return false;
        }

        // -----------------------------------------------------
        // Created by must be valid
        // -----------------------------------------------------

        if (bill.getCreatedBy() <= 0) {
            return false;
        }

        // -----------------------------------------------------
        // Normalise text
        // -----------------------------------------------------

        bill.setBillNumber(
                bill.getBillNumber().trim()
        );

        bill.setBillType(
                bill.getBillType().trim().toUpperCase()
        );

        // -----------------------------------------------------
        // Calculate total amount in service layer
        // -----------------------------------------------------

        double totalAmount =
                bill.getConsultationFee()
                + bill.getTreatmentFee();

        bill.setTotalAmount(
                totalAmount
        );

        // -----------------------------------------------------
        // Duplicate bill number validation
        // -----------------------------------------------------

        if (billDAO.billNumberExists(
                bill.getBillNumber())) {

            return false;
        }

        // -----------------------------------------------------
        // Appointment billing validation
        //
        // One appointment should only have one bill.
        // -----------------------------------------------------

        if (bill.getAppointmentId() != null
                && bill.getAppointmentId() > 0) {

            if (billDAO.appointmentAlreadyBilled(
                    bill.getAppointmentId())) {

                return false;
            }
        }

        // -----------------------------------------------------
        // Create bill
        // -----------------------------------------------------

        return billDAO.addBill(bill);
    }

    // =========================================================
    // CHECK BILL NUMBER
    // =========================================================

    public boolean billNumberExists(
            String billNumber) {

        if (billNumber == null
                || billNumber.trim().isEmpty()) {

            return false;
        }

        return billDAO.billNumberExists(
                billNumber.trim()
        );
    }

    // =========================================================
    // CHECK APPOINTMENT BILLING
    // =========================================================

    public boolean appointmentAlreadyBilled(
            int appointmentId) {

        if (appointmentId <= 0) {
            return false;
        }

        return billDAO.appointmentAlreadyBilled(
                appointmentId
        );
    }

    // =========================================================
    // GET BILL COUNT
    // =========================================================

    public int getBillCount() {

        return billDAO.getBillCount();
    }
}
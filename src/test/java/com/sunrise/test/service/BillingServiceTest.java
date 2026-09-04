package com.sunrise.test.service;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.sunrise.model.Bill;
import com.sunrise.service.BillingService;

class BillingServiceTest {

    private BillingService billingService;

    @BeforeEach
    void setUp() {
        billingService = new BillingService();
    }

    // =========================================================
    // GET BILL BY ID
    // =========================================================

    @Test
    void getBillByIdShouldReturnNullForInvalidId() {

        Bill result =
                billingService.getBillById(0);

        assertNull(result);
    }

    @Test
    void getBillByIdShouldReturnNullForNegativeId() {

        Bill result =
                billingService.getBillById(-1);

        assertNull(result);
    }

    // =========================================================
    // GET BILL BY APPOINTMENT
    // =========================================================

    @Test
    void getBillByAppointmentIdShouldReturnNullForInvalidId() {

        Bill result =
                billingService.getBillByAppointmentId(0);

        assertNull(result);
    }

    // =========================================================
    // GET BILLS BY PATIENT
    // =========================================================

    @Test
    void getBillsByPatientShouldReturnEmptyListForInvalidId() {

        List<Bill> result =
                billingService.getBillsByPatient(0);

        assertNotNull(result);
        assertTrue(result.isEmpty());
    }

    // =========================================================
    // SEARCH BILLS
    // =========================================================

    @Test
    void searchBillsShouldHandleNullKeyword() {

        List<Bill> result =
                billingService.searchBills(
                        null,
                        null
                );

        assertNotNull(result);
    }

    @Test
    void searchBillsShouldHandleBlankBillType() {

        List<Bill> result =
                billingService.searchBills(
                        "",
                        "   "
                );

        assertNotNull(result);
    }

    // =========================================================
    // CREATE BILL
    // =========================================================

    @Test
    void createBillShouldRejectNullBill() {

        assertFalse(
                billingService.createBill(null)
        );
    }

    @Test
    void createBillShouldRejectMissingBillNumber() {

        Bill bill = new Bill();

        bill.setBillNumber("");
        bill.setPatientId(1);
        bill.setBillType("APPOINTMENT");
        bill.setConsultationFee(2500);
        bill.setTreatmentFee(5000);
        bill.setCreatedBy(1);

        assertFalse(
                billingService.createBill(bill)
        );
    }

    @Test
    void createBillShouldRejectInvalidPatientId() {

        Bill bill = new Bill();

        bill.setBillNumber("TEST-BILL-001");
        bill.setPatientId(0);
        bill.setBillType("APPOINTMENT");
        bill.setConsultationFee(2500);
        bill.setTreatmentFee(5000);
        bill.setCreatedBy(1);

        assertFalse(
                billingService.createBill(bill)
        );
    }

    @Test
    void createBillShouldRejectMissingBillType() {

        Bill bill = new Bill();

        bill.setBillNumber("TEST-BILL-002");
        bill.setPatientId(1);
        bill.setBillType("");
        bill.setConsultationFee(2500);
        bill.setTreatmentFee(5000);
        bill.setCreatedBy(1);

        assertFalse(
                billingService.createBill(bill)
        );
    }

    @Test
    void createBillShouldRejectNegativeConsultationFee() {

        Bill bill = new Bill();

        bill.setBillNumber("TEST-BILL-003");
        bill.setPatientId(1);
        bill.setBillType("APPOINTMENT");
        bill.setConsultationFee(-100);
        bill.setTreatmentFee(5000);
        bill.setCreatedBy(1);

        assertFalse(
                billingService.createBill(bill)
        );
    }

    @Test
    void createBillShouldRejectNegativeTreatmentFee() {

        Bill bill = new Bill();

        bill.setBillNumber("TEST-BILL-004");
        bill.setPatientId(1);
        bill.setBillType("APPOINTMENT");
        bill.setConsultationFee(2500);
        bill.setTreatmentFee(-100);
        bill.setCreatedBy(1);

        assertFalse(
                billingService.createBill(bill)
        );
    }

    @Test
    void createBillShouldRejectInvalidCreatedBy() {

        Bill bill = new Bill();

        bill.setBillNumber("TEST-BILL-005");
        bill.setPatientId(1);
        bill.setBillType("APPOINTMENT");
        bill.setConsultationFee(2500);
        bill.setTreatmentFee(5000);
        bill.setCreatedBy(0);

        assertFalse(
                billingService.createBill(bill)
        );
    }

    // =========================================================
    // BILL NUMBER CHECK
    // =========================================================

    @Test
    void billNumberExistsShouldReturnFalseForBlankNumber() {

        assertFalse(
                billingService.billNumberExists("")
        );
    }

    @Test
    void billNumberExistsShouldReturnFalseForNullNumber() {

        assertFalse(
                billingService.billNumberExists(null)
        );
    }

    // =========================================================
    // APPOINTMENT BILLING CHECK
    // =========================================================

    @Test
    void appointmentAlreadyBilledShouldReturnFalseForInvalidId() {

        assertFalse(
                billingService.appointmentAlreadyBilled(0)
        );
    }

    // =========================================================
    // BILL COUNT
    // =========================================================

    @Test
    void getBillCountShouldReturnNonNegativeValue() {

        int count =
                billingService.getBillCount();

        assertTrue(count >= 0);
    }
}
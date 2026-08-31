package com.sunrise.test;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import com.sunrise.model.Bill;

public class BillTest {

    @Test
    public void testBillDetails() {

        Bill bill = new Bill();

        bill.setBillId(1);
        bill.setBillNumber("BILL-001");
        bill.setAppointmentId(1);
        bill.setPatientId(1);
        bill.setBillType("APPOINTMENT");
        bill.setConsultationFee(2500.00);
        bill.setTreatmentFee(5000.00);
        bill.setTotalAmount(7500.00);

        assertEquals(1, bill.getBillId());
        assertEquals("BILL-001", bill.getBillNumber());
        assertEquals(1, bill.getAppointmentId());
        assertEquals(1, bill.getPatientId());
        assertEquals("APPOINTMENT", bill.getBillType());
        assertEquals(2500.00, bill.getConsultationFee());
        assertEquals(5000.00, bill.getTreatmentFee());
        assertEquals(7500.00, bill.getTotalAmount());
    }
}
package com.sunrise.model;

import java.sql.Timestamp;

public class Bill {

    private int billId;
    private String billNumber;
    private int appointmentId;

    private double consultationFee;
    private double treatmentFee;
    private double totalAmount;

    private int createdBy;
    private Timestamp createdAt;


    // =========================================================
    // DEFAULT CONSTRUCTOR
    // =========================================================

    public Bill() {
    }


    // =========================================================
    // CONSTRUCTOR FOR CREATING BILL
    // =========================================================

    public Bill(
            String billNumber,
            int appointmentId,
            double consultationFee,
            double treatmentFee,
            double totalAmount,
            int createdBy) {

        this.billNumber = billNumber;
        this.appointmentId = appointmentId;
        this.consultationFee = consultationFee;
        this.treatmentFee = treatmentFee;
        this.totalAmount = totalAmount;
        this.createdBy = createdBy;
    }


    // =========================================================
    // FULL CONSTRUCTOR
    // =========================================================

    public Bill(
            int billId,
            String billNumber,
            int appointmentId,
            double consultationFee,
            double treatmentFee,
            double totalAmount,
            int createdBy,
            Timestamp createdAt) {

        this.billId = billId;
        this.billNumber = billNumber;
        this.appointmentId = appointmentId;
        this.consultationFee = consultationFee;
        this.treatmentFee = treatmentFee;
        this.totalAmount = totalAmount;
        this.createdBy = createdBy;
        this.createdAt = createdAt;
    }


    // =========================================================
    // GETTERS AND SETTERS
    // =========================================================

    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }


    public String getBillNumber() {
        return billNumber;
    }

    public void setBillNumber(String billNumber) {
        this.billNumber = billNumber;
    }


    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }


    public double getConsultationFee() {
        return consultationFee;
    }

    public void setConsultationFee(double consultationFee) {
        this.consultationFee = consultationFee;
    }


    public double getTreatmentFee() {
        return treatmentFee;
    }

    public void setTreatmentFee(double treatmentFee) {
        this.treatmentFee = treatmentFee;
    }


    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }


    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }


    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
package com.sunrise.model;

import java.sql.Timestamp;

public class Bill {

    private int billId;
    private Integer treatmentId;
    private String billNumber;
    private Integer appointmentId;
    private int patientId;
    private String billType;
    private double consultationFee;
    private double treatmentFee;
    private double totalAmount;
    private int createdBy;
    private Timestamp createdAt;

    public Bill() {
    }

    public Bill(
            String billNumber,
            Integer appointmentId,
            int patientId,
            Integer treatmentId,
            String billType,
            double consultationFee,
            double treatmentFee,
            double totalAmount,
            int createdBy) {

        this.billNumber = billNumber;
        this.appointmentId = appointmentId;
        this.patientId = patientId;
        this.treatmentId = treatmentId;
        this.billType = billType;
        this.consultationFee = consultationFee;
        this.treatmentFee = treatmentFee;
        this.totalAmount = totalAmount;
        this.createdBy = createdBy;
    }

    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }
    public Integer getTreatmentId() {
        return treatmentId;
    }

    public void setTreatmentId(Integer treatmentId) {
        this.treatmentId = treatmentId;
    }

    public String getBillNumber() {
        return billNumber;
    }

    public void setBillNumber(String billNumber) {
        this.billNumber = billNumber;
    }

    public Integer getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(Integer appointmentId) {
        this.appointmentId = appointmentId;
    }

    public int getPatientId() {
        return patientId;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    public String getBillType() {
        return billType;
    }

    public void setBillType(String billType) {
        this.billType = billType;
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
package com.sunrise.model;

import java.sql.Timestamp;

public class ReportBill {

    private String billNumber;

    private Timestamp createdAt;

    private String billType;

    private String patientName;

    private String treatmentName;

    private double consultationFee;

    private double treatmentFee;

    private double totalAmount;


    public ReportBill() {
    }


    public String getBillNumber() {
        return billNumber;
    }

    public void setBillNumber(
            String billNumber) {

        this.billNumber =
                billNumber;
    }


    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(
            Timestamp createdAt) {

        this.createdAt =
                createdAt;
    }


    public String getBillType() {
        return billType;
    }

    public void setBillType(
            String billType) {

        this.billType =
                billType;
    }


    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(
            String patientName) {

        this.patientName =
                patientName;
    }


    public String getTreatmentName() {
        return treatmentName;
    }

    public void setTreatmentName(
            String treatmentName) {

        this.treatmentName =
                treatmentName;
    }


    public double getConsultationFee() {
        return consultationFee;
    }

    public void setConsultationFee(
            double consultationFee) {

        this.consultationFee =
                consultationFee;
    }


    public double getTreatmentFee() {
        return treatmentFee;
    }

    public void setTreatmentFee(
            double treatmentFee) {

        this.treatmentFee =
                treatmentFee;
    }


    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(
            double totalAmount) {

        this.totalAmount =
                totalAmount;
    }
}
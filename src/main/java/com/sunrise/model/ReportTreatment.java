package com.sunrise.model;

public class ReportTreatment {

    private String treatmentName;
    private int completedCount;


    // =========================================================
    // DEFAULT CONSTRUCTOR
    // =========================================================

    public ReportTreatment() {
    }


    // =========================================================
    // CONSTRUCTOR
    // =========================================================

    public ReportTreatment(
            String treatmentName,
            int completedCount) {

        this.treatmentName = treatmentName;
        this.completedCount = completedCount;
    }


    // =========================================================
    // GETTERS / SETTERS
    // =========================================================

    public String getTreatmentName() {
        return treatmentName;
    }

    public void setTreatmentName(
            String treatmentName) {

        this.treatmentName =
                treatmentName;
    }


    public int getCompletedCount() {
        return completedCount;
    }

    public void setCompletedCount(
            int completedCount) {

        this.completedCount =
                completedCount;
    }
}
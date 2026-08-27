package com.sunrise.model;

public class Treatment {

    private int treatmentId;
    private String treatmentName;
    private String description;
    private double treatmentFee;
    private boolean active;

    // Default constructor
    public Treatment() {
    }

    // Constructor for adding treatment
    public Treatment(String treatmentName,
                     String description,
                     double treatmentFee,
                     boolean active) {

        this.treatmentName = treatmentName;
        this.description = description;
        this.treatmentFee = treatmentFee;
        this.active = active;
    }

    // Full constructor
    public Treatment(int treatmentId,
                     String treatmentName,
                     String description,
                     double treatmentFee,
                     boolean active) {

        this.treatmentId = treatmentId;
        this.treatmentName = treatmentName;
        this.description = description;
        this.treatmentFee = treatmentFee;
        this.active = active;
    }

    public int getTreatmentId() {
        return treatmentId;
    }

    public void setTreatmentId(int treatmentId) {
        this.treatmentId = treatmentId;
    }

    public String getTreatmentName() {
        return treatmentName;
    }

    public void setTreatmentName(String treatmentName) {
        this.treatmentName = treatmentName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getTreatmentFee() {
        return treatmentFee;
    }

    public void setTreatmentFee(double treatmentFee) {
        this.treatmentFee = treatmentFee;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
}
package com.sunrise.model;

public class Dentist {

    private int dentistId;
    private String dentistName;
    private String specialization;
    private double consultationFee;
    private String phoneNumber;
    private String email;
    private boolean active;

    // Default constructor
    public Dentist() {
    }

    // Constructor for adding a dentist
    public Dentist(String dentistName,
                   String specialization,
                   double consultationFee,
                   String phoneNumber,
                   String email,
                   boolean active) {

        this.dentistName = dentistName;
        this.specialization = specialization;
        this.consultationFee = consultationFee;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.active = active;
    }

    // Full constructor
    public Dentist(int dentistId,
                   String dentistName,
                   String specialization,
                   double consultationFee,
                   String phoneNumber,
                   String email,
                   boolean active) {

        this.dentistId = dentistId;
        this.dentistName = dentistName;
        this.specialization = specialization;
        this.consultationFee = consultationFee;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.active = active;
    }

    public int getDentistId() {
        return dentistId;
    }

    public void setDentistId(int dentistId) {
        this.dentistId = dentistId;
    }

    public String getDentistName() {
        return dentistName;
    }

    public void setDentistName(String dentistName) {
        this.dentistName = dentistName;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public double getConsultationFee() {
        return consultationFee;
    }

    public void setConsultationFee(double consultationFee) {
        this.consultationFee = consultationFee;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
}
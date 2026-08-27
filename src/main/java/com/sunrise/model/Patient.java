package com.sunrise.model;

import java.time.LocalDateTime;

public class Patient {

    private int patientId;
    private String patientCode;
    private String name;
    private String address;
    private String contactNumber;
    private String email;
    private LocalDateTime createdAt;

    // Default constructor
    public Patient() {
    }

    // Constructor used when creating a new patient
    public Patient(String patientCode, String name, String address,
                   String contactNumber, String email) {

        this.patientCode = patientCode;
        this.name = name;
        this.address = address;
        this.contactNumber = contactNumber;
        this.email = email;
    }

    // Full constructor
    public Patient(int patientId, String patientCode, String name,
                   String address, String contactNumber, String email,
                   LocalDateTime createdAt) {

        this.patientId = patientId;
        this.patientCode = patientCode;
        this.name = name;
        this.address = address;
        this.contactNumber = contactNumber;
        this.email = email;
        this.createdAt = createdAt;
    }

    public int getPatientId() {
        return patientId;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    public String getPatientCode() {
        return patientCode;
    }

    public void setPatientCode(String patientCode) {
        this.patientCode = patientCode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
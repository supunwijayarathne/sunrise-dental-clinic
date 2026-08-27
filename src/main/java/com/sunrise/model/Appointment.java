package com.sunrise.model;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalTime;

public class Appointment {

    private int appointmentId;
    private String appointmentNumber;

    private int patientId;
    private int dentistId;
    private int treatmentId;

    private LocalDate appointmentDate;
    private LocalTime appointmentTime;

    private String status;
    private String notes;

    private int createdBy;

    private Timestamp createdAt;
    private Timestamp updatedAt;


    // =========================================================
    // DEFAULT CONSTRUCTOR
    // =========================================================

    public Appointment() {
    }


    // =========================================================
    // CONSTRUCTOR FOR CREATING APPOINTMENT
    // =========================================================

    public Appointment(
            String appointmentNumber,
            int patientId,
            int dentistId,
            int treatmentId,
            LocalDate appointmentDate,
            LocalTime appointmentTime,
            String status,
            String notes,
            int createdBy) {

        this.appointmentNumber = appointmentNumber;
        this.patientId = patientId;
        this.dentistId = dentistId;
        this.treatmentId = treatmentId;
        this.appointmentDate = appointmentDate;
        this.appointmentTime = appointmentTime;
        this.status = status;
        this.notes = notes;
        this.createdBy = createdBy;
    }


    // =========================================================
    // FULL CONSTRUCTOR
    // =========================================================

    public Appointment(
            int appointmentId,
            String appointmentNumber,
            int patientId,
            int dentistId,
            int treatmentId,
            LocalDate appointmentDate,
            LocalTime appointmentTime,
            String status,
            String notes,
            int createdBy,
            Timestamp createdAt,
            Timestamp updatedAt) {

        this.appointmentId = appointmentId;
        this.appointmentNumber = appointmentNumber;
        this.patientId = patientId;
        this.dentistId = dentistId;
        this.treatmentId = treatmentId;
        this.appointmentDate = appointmentDate;
        this.appointmentTime = appointmentTime;
        this.status = status;
        this.notes = notes;
        this.createdBy = createdBy;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }


    // =========================================================
    // GETTERS AND SETTERS
    // =========================================================

    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }


    public String getAppointmentNumber() {
        return appointmentNumber;
    }

    public void setAppointmentNumber(String appointmentNumber) {
        this.appointmentNumber = appointmentNumber;
    }


    public int getPatientId() {
        return patientId;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }


    public int getDentistId() {
        return dentistId;
    }

    public void setDentistId(int dentistId) {
        this.dentistId = dentistId;
    }


    public int getTreatmentId() {
        return treatmentId;
    }

    public void setTreatmentId(int treatmentId) {
        this.treatmentId = treatmentId;
    }


    public LocalDate getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(LocalDate appointmentDate) {
        this.appointmentDate = appointmentDate;
    }


    public LocalTime getAppointmentTime() {
        return appointmentTime;
    }

    public void setAppointmentTime(LocalTime appointmentTime) {
        this.appointmentTime = appointmentTime;
    }


    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
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


    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}
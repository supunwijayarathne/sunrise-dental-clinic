package com.sunrise.model;

import java.util.ArrayList;
import java.util.List;

public class ReportStats {

    // =========================================================
    // BILL DATA
    // =========================================================

    private int totalBills;

    private int appointmentBills;

    private int walkInBills;


    // =========================================================
    // APPOINTMENT DATA
    // =========================================================

    private int totalAppointments;

    private int scheduledAppointments;

    private int completedAppointments;

    private int cancelledAppointments;

    private int noShowAppointments;

    private int billedAppointments;


    // =========================================================
    // REVENUE
    // =========================================================

    private double totalRevenue;

    private double appointmentRevenue;

    private double walkInRevenue;


    // =========================================================
    // DAILY REVENUE
    // =========================================================

    private List<String> revenueDates =
            new ArrayList<>();

    private List<Double> dailyRevenue =
            new ArrayList<>();


    // =========================================================
    // BILL DETAILS
    // =========================================================

    private List<ReportBill> bills =
            new ArrayList<>();


    // =========================================================
    // APPOINTMENT DETAILS
    // =========================================================

    private List<ReportAppointment> appointments =
            new ArrayList<>();


    // =========================================================
    // TREATMENT REPORT
    // =========================================================

    private List<ReportTreatment> treatments =
            new ArrayList<>();


    // =========================================================
    // BILL GETTERS / SETTERS
    // =========================================================

    public int getTotalBills() {
        return totalBills;
    }

    public void setTotalBills(int totalBills) {
        this.totalBills = totalBills;
    }


    public int getAppointmentBills() {
        return appointmentBills;
    }

    public void setAppointmentBills(
            int appointmentBills) {

        this.appointmentBills =
                appointmentBills;
    }


    public int getWalkInBills() {
        return walkInBills;
    }

    public void setWalkInBills(
            int walkInBills) {

        this.walkInBills =
                walkInBills;
    }


    // =========================================================
    // APPOINTMENT GETTERS / SETTERS
    // =========================================================

    public int getTotalAppointments() {
        return totalAppointments;
    }

    public void setTotalAppointments(
            int totalAppointments) {

        this.totalAppointments =
                totalAppointments;
    }


    public int getScheduledAppointments() {
        return scheduledAppointments;
    }

    public void setScheduledAppointments(
            int scheduledAppointments) {

        this.scheduledAppointments =
                scheduledAppointments;
    }


    public int getCompletedAppointments() {
        return completedAppointments;
    }

    public void setCompletedAppointments(
            int completedAppointments) {

        this.completedAppointments =
                completedAppointments;
    }


    public int getCancelledAppointments() {
        return cancelledAppointments;
    }

    public void setCancelledAppointments(
            int cancelledAppointments) {

        this.cancelledAppointments =
                cancelledAppointments;
    }


    public int getNoShowAppointments() {
        return noShowAppointments;
    }

    public void setNoShowAppointments(
            int noShowAppointments) {

        this.noShowAppointments =
                noShowAppointments;
    }


    public int getBilledAppointments() {
        return billedAppointments;
    }

    public void setBilledAppointments(
            int billedAppointments) {

        this.billedAppointments =
                billedAppointments;
    }


    // =========================================================
    // REVENUE GETTERS / SETTERS
    // =========================================================

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(
            double totalRevenue) {

        this.totalRevenue =
                totalRevenue;
    }


    public double getAppointmentRevenue() {
        return appointmentRevenue;
    }

    public void setAppointmentRevenue(
            double appointmentRevenue) {

        this.appointmentRevenue =
                appointmentRevenue;
    }


    public double getWalkInRevenue() {
        return walkInRevenue;
    }

    public void setWalkInRevenue(
            double walkInRevenue) {

        this.walkInRevenue =
                walkInRevenue;
    }


    // =========================================================
    // DAILY REVENUE GETTERS / SETTERS
    // =========================================================

    public List<String> getRevenueDates() {
        return revenueDates;
    }

    public void setRevenueDates(
            List<String> revenueDates) {

        this.revenueDates =
                revenueDates;
    }


    public List<Double> getDailyRevenue() {
        return dailyRevenue;
    }

    public void setDailyRevenue(
            List<Double> dailyRevenue) {

        this.dailyRevenue =
                dailyRevenue;
    }


    // =========================================================
    // BILL DETAILS
    // =========================================================

    public List<ReportBill> getBills() {
        return bills;
    }

    public void setBills(
            List<ReportBill> bills) {

        this.bills = bills;
    }


    // =========================================================
    // APPOINTMENT DETAILS
    // =========================================================

    public List<ReportAppointment> getAppointments() {
        return appointments;
    }

    public void setAppointments(
            List<ReportAppointment> appointments) {

        this.appointments =
                appointments;
    }


    // =========================================================
    // TREATMENT REPORT
    // =========================================================

    public List<ReportTreatment> getTreatments() {
        return treatments;
    }

    public void setTreatments(
            List<ReportTreatment> treatments) {

        this.treatments =
                treatments;
    }
}
package com.sunrise.model;

public class DashboardStats {

    private int totalPatients;

    private int totalDentists;

    private int totalTreatments;

    private int todayAppointments;

    private int totalAppointments;

    private int scheduledAppointments;

    private int completedAppointments;

    private int cancelledAppointments;

    private int totalBills;

    private int todayBills;

    private double todayRevenue;


    public DashboardStats() {
    }


    public int getTotalPatients() {
        return totalPatients;
    }

    public void setTotalPatients(int totalPatients) {
        this.totalPatients = totalPatients;
    }


    public int getTotalDentists() {
        return totalDentists;
    }

    public void setTotalDentists(int totalDentists) {
        this.totalDentists = totalDentists;
    }


    public int getTotalTreatments() {
        return totalTreatments;
    }

    public void setTotalTreatments(int totalTreatments) {
        this.totalTreatments = totalTreatments;
    }


    public int getTodayAppointments() {
        return todayAppointments;
    }

    public void setTodayAppointments(int todayAppointments) {
        this.todayAppointments = todayAppointments;
    }


    public int getTotalAppointments() {
        return totalAppointments;
    }

    public void setTotalAppointments(int totalAppointments) {
        this.totalAppointments = totalAppointments;
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


    public int getTotalBills() {
        return totalBills;
    }

    public void setTotalBills(int totalBills) {
        this.totalBills = totalBills;
    }


    public int getTodayBills() {
        return todayBills;
    }

    public void setTodayBills(int todayBills) {
        this.todayBills = todayBills;
    }


    public double getTodayRevenue() {
        return todayRevenue;
    }

    public void setTodayRevenue(double todayRevenue) {
        this.todayRevenue = todayRevenue;
    }
}
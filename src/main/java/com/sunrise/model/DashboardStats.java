package com.sunrise.model;

public class DashboardStats {

    private int totalPatients;
    private int totalDentists;
    private int totalTreatments;
    private int todayAppointments;
    private int totalBills;

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

    public int getTotalBills() {
        return totalBills;
    }

    public void setTotalBills(int totalBills) {
        this.totalBills = totalBills;
    }
}
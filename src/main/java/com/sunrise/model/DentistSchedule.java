package com.sunrise.model;

import java.time.LocalTime;

public class DentistSchedule {

    private int scheduleId;
    private int dentistId;
    private String dayOfWeek;
    private LocalTime startTime;
    private LocalTime endTime;
    private int slotDuration;
    private boolean active;

    public DentistSchedule() {
    }

    public DentistSchedule(
            int dentistId,
            String dayOfWeek,
            LocalTime startTime,
            LocalTime endTime,
            int slotDuration,
            boolean active) {

        this.dentistId = dentistId;
        this.dayOfWeek = dayOfWeek;
        this.startTime = startTime;
        this.endTime = endTime;
        this.slotDuration = slotDuration;
        this.active = active;
    }

    public DentistSchedule(
            int scheduleId,
            int dentistId,
            String dayOfWeek,
            LocalTime startTime,
            LocalTime endTime,
            int slotDuration,
            boolean active) {

        this.scheduleId = scheduleId;
        this.dentistId = dentistId;
        this.dayOfWeek = dayOfWeek;
        this.startTime = startTime;
        this.endTime = endTime;
        this.slotDuration = slotDuration;
        this.active = active;
    }

    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public int getDentistId() {
        return dentistId;
    }

    public void setDentistId(int dentistId) {
        this.dentistId = dentistId;
    }

    public String getDayOfWeek() {
        return dayOfWeek;
    }

    public void setDayOfWeek(String dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
    }

    public LocalTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }

    public LocalTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalTime endTime) {
        this.endTime = endTime;
    }

    public int getSlotDuration() {
        return slotDuration;
    }

    public void setSlotDuration(int slotDuration) {
        this.slotDuration = slotDuration;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
}
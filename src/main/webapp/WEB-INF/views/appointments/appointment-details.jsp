<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.sunrise.model.Appointment" %>
<%@ page import="com.sunrise.model.Patient" %>
<%@ page import="com.sunrise.model.Dentist" %>
<%@ page import="com.sunrise.model.Treatment" %>

<%
    Appointment appointment =
        (Appointment) request.getAttribute("appointment");

    Patient patient =
        (Patient) request.getAttribute("patient");

    Dentist dentist =
        (Dentist) request.getAttribute("dentist");

    Treatment treatment =
        (Treatment) request.getAttribute("treatment");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>
    Appointment Details - Sunrise Dental Clinic
</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f5f7fa;
    color: #222;
}

.container {
    max-width: 800px;
    margin: 40px auto;
    background: white;
    padding: 35px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
}

.header h1 {
    margin-top: 0;
    margin-bottom: 8px;
}

.header p {
    color: #666;
}

.appointment-number {
    display: inline-block;
    margin-top: 10px;
    padding: 9px 13px;
    background: #f0f2f4;
    border-radius: 6px;
    font-weight: bold;
}

.section {
    margin-top: 30px;
}

.section-title {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 10px;
}

.detail {
    padding: 16px 0;
    border-bottom: 1px solid #e5e5e5;
}

.label {
    font-size: 13px;
    font-weight: bold;
    color: #777;
    margin-bottom: 6px;
}

.value {
    font-size: 17px;
}

.notes {
    line-height: 1.6;
}

.status {
    font-weight: bold;
}

.scheduled {
    color: #1769aa;
}

.completed {
    color: #16803c;
}

.cancelled {
    color: #b00020;
}

.no-show {
    color: #a15c00;
}

.billed {
    color: #6a1b9a;
}

.success {
    background: #e6f7e9;
    color: #176b2c;
    padding: 13px;
    margin-top: 20px;
    border-radius: 6px;
}

.actions {
    margin-top: 30px;
}

.edit-button {
    display: inline-block;
    padding: 11px 18px;
    background: #222;
    color: white;
    text-decoration: none;
    border-radius: 6px;
    margin-right: 8px;
}

.back-button {
    display: inline-block;
    padding: 11px 18px;
    border: 1px solid #ccc;
    color: #222;
    text-decoration: none;
    border-radius: 6px;
}

</style>

</head>

<body>

<div class="container">


<!-- HEADER -->

<div class="header">

<h1>
    Appointment Details
</h1>

<p>
    Complete information about this appointment.
</p>

<div class="appointment-number">

    <%= appointment.getAppointmentNumber() %>

</div>

</div>


<!-- SUCCESS -->

<% if ("1".equals(request.getParameter("updated"))) { %>

<div class="success">

    Appointment updated successfully.

</div>

<% } %>


<!-- APPOINTMENT INFORMATION -->

<div class="section">

<div class="section-title">
    Appointment Information
</div>


<div class="detail">

<div class="label">
    Appointment ID
</div>

<div class="value">

    <%= appointment.getAppointmentId() %>

</div>

</div>


<div class="detail">

<div class="label">
    Date
</div>

<div class="value">

    <%= appointment.getAppointmentDate() %>

</div>

</div>


<div class="detail">

<div class="label">
    Time
</div>

<div class="value">

    <%= appointment.getAppointmentTime() %>

</div>

</div>


<div class="detail">

<div class="label">
    Status
</div>

<div class="value">

<%
    String status =
        appointment.getStatus();

    String statusClass =
        status.toLowerCase().replace("_", "-");
%>

<span class="status <%= statusClass %>">

    <%= status.replace("_", " ") %>

</span>

</div>

</div>

</div>


<!-- PATIENT -->

<div class="section">

<div class="section-title">
    Patient
</div>


<div class="detail">

<div class="label">
    Patient Code
</div>

<div class="value">

<%= patient != null
    ? patient.getPatientCode()
    : "N/A" %>

</div>

</div>


<div class="detail">

<div class="label">
    Patient Name
</div>

<div class="value">

<%= patient != null
    ? patient.getName()
    : "N/A" %>

</div>

</div>


<div class="detail">

<div class="label">
    Contact Number
</div>

<div class="value">

<%= patient != null
    ? patient.getContactNumber()
    : "N/A" %>

</div>

</div>

</div>


<!-- DENTIST -->

<div class="section">

<div class="section-title">
    Dentist
</div>


<div class="detail">

<div class="label">
    Dentist Name
</div>

<div class="value">

<%= dentist != null
    ? dentist.getDentistName()
    : "N/A" %>

</div>

</div>


<div class="detail">

<div class="label">
    Specialization
</div>

<div class="value">

<%= dentist != null
    ? dentist.getSpecialization()
    : "N/A" %>

</div>

</div>

</div>


<!-- TREATMENT -->

<div class="section">

<div class="section-title">
    Treatment
</div>


<div class="detail">

<div class="label">
    Treatment Name
</div>

<div class="value">

<%= treatment != null
    ? treatment.getTreatmentName()
    : "N/A" %>

</div>

</div>


<div class="detail">

<div class="label">
    Treatment Fee
</div>

<div class="value">

<% if (treatment != null) { %>

    LKR
    <%= String.format(
        "%.2f",
        treatment.getTreatmentFee()
    ) %>

<% } else { %>

    N/A

<% } %>

</div>

</div>

</div>


<!-- NOTES -->

<div class="section">

<div class="section-title">
    Notes
</div>


<div class="detail">

<div class="value notes">

<%= appointment.getNotes() != null
    && !appointment.getNotes().isBlank()
    ? appointment.getNotes()
    : "No additional notes." %>

</div>

</div>

</div>


<!-- TIMESTAMPS -->

<div class="section">

<div class="section-title">
    System Information
</div>


<div class="detail">

<div class="label">
    Created By
</div>

<div class="value">

    User ID:
    <%= appointment.getCreatedBy() %>

</div>

</div>


<div class="detail">

<div class="label">
    Created At
</div>

<div class="value">

    <%= appointment.getCreatedAt() != null
        ? appointment.getCreatedAt()
        : "N/A" %>

</div>

</div>


<div class="detail">

<div class="label">
    Last Updated
</div>

<div class="value">

    <%= appointment.getUpdatedAt() != null
        ? appointment.getUpdatedAt()
        : "N/A" %>

</div>

</div>

</div>


<!-- ACTIONS -->

<div class="actions">

<a
    class="edit-button"
    href="<%= request.getContextPath() %>/appointments/edit?id=<%= appointment.getAppointmentId() %>">

    Edit Appointment

</a>

<a
    class="back-button"
    href="<%= request.getContextPath() %>/appointments">

    ← Back to Appointments

</a>

</div>


</div>

</body>

</html>
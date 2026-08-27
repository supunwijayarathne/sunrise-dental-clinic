<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.sunrise.model.Appointment" %>
<%@ page import="com.sunrise.model.Patient" %>
<%@ page import="com.sunrise.model.Dentist" %>
<%@ page import="com.sunrise.model.Treatment" %>

<%
    Appointment appointment =
        (Appointment) request.getAttribute("appointment");

    List<Patient> patients =
        (List<Patient>) request.getAttribute("patients");

    List<Dentist> dentists =
        (List<Dentist>) request.getAttribute("dentists");

    List<Treatment> treatments =
        (List<Treatment>) request.getAttribute("treatments");

    String formMode =
        (String) request.getAttribute("formMode");

    boolean editMode =
        "edit".equals(formMode);

    String title =
        editMode ? "Edit Appointment" : "Book Appointment";

    String buttonText =
        editMode ? "Update Appointment" : "Book Appointment";
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>
    <%= title %> - Sunrise Dental Clinic
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
    max-width: 750px;
    margin: 40px auto;
    background: white;
    padding: 35px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
}

h1 {
    margin-top: 0;
    margin-bottom: 8px;
}

.description {
    color: #666;
    margin-bottom: 30px;
}

.form-group {
    margin-bottom: 20px;
}

label {
    display: block;
    margin-bottom: 7px;
    font-weight: bold;
}

input,
select,
textarea {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
    font-family: Arial, sans-serif;
}

textarea {
    min-height: 110px;
    resize: vertical;
}

input:focus,
select:focus,
textarea:focus {
    outline: none;
    border-color: #333;
}

.error {
    background: #ffe5e5;
    color: #a40000;
    padding: 13px;
    margin-bottom: 22px;
    border-radius: 6px;
}

.info-box {
    background: #f1f3f5;
    padding: 12px;
    border-radius: 6px;
    margin-bottom: 20px;
}

.required {
    color: #c00;
}

.optional {
    color: #888;
    font-size: 12px;
    font-weight: normal;
}

.actions {
    margin-top: 30px;
    display: flex;
    gap: 10px;
}

button {
    padding: 12px 20px;
    background: #222;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

button:hover {
    background: #444;
}

.cancel {
    padding: 12px 20px;
    border: 1px solid #ccc;
    color: #222;
    text-decoration: none;
    border-radius: 6px;
}

</style>

</head>

<body>

<div class="container">

<h1>
    <%= title %>
</h1>

<p class="description">

<%= editMode
    ? "Update the appointment details."
    : "Create a new patient appointment." %>

</p>


<!-- ERROR -->

<% if (request.getAttribute("error") != null) { %>

<div class="error">

    <%= request.getAttribute("error") %>

</div>

<% } %>


<!-- APPOINTMENT ID -->

<% if (editMode) { %>

<div class="info-box">

    Appointment ID:

    <strong>
        <%= appointment.getAppointmentId() %>
    </strong>

    <br><br>

    Appointment Number:

    <strong>
        <%= appointment.getAppointmentNumber() %>
    </strong>

</div>

<% } %>


<form
    method="post"
    action="<%= request.getContextPath() %>/appointments/<%= editMode ? "edit" : "add" %>"
>


<!-- HIDDEN ID -->

<% if (editMode) { %>

<input
    type="hidden"
    name="appointmentId"
    value="<%= appointment.getAppointmentId() %>"
>

<% } %>


<!-- APPOINTMENT NUMBER -->

<% if (!editMode) { %>

<div class="form-group">

<label for="appointmentNumber">

    Appointment Number
    <span class="required">*</span>

</label>

<input
    type="text"
    id="appointmentNumber"
    name="appointmentNumber"
    maxlength="30"
    placeholder="e.g. APT-2026-001"
    required
>

</div>

<% } %>


<!-- PATIENT -->

<div class="form-group">

<label for="patientId">

    Patient
    <span class="required">*</span>

</label>

<select
    id="patientId"
    name="patientId"
    required
>

<option value="">
    -- Select Patient --
</option>


<% if (patients != null) { %>

<% for (Patient patient : patients) { %>

<option
    value="<%= patient.getPatientId() %>"

    <%= appointment != null
        && appointment.getPatientId()
        == patient.getPatientId()
        ? "selected"
        : "" %>
>

    <%= patient.getPatientCode() %>
    -
    <%= patient.getName() %>

</option>

<% } %>

<% } %>

</select>

</div>


<!-- DENTIST -->

<div class="form-group">

<label for="dentistId">

    Dentist
    <span class="required">*</span>

</label>

<select
    id="dentistId"
    name="dentistId"
    required
>

<option value="">
    -- Select Dentist --
</option>


<% if (dentists != null) { %>

<% for (Dentist dentist : dentists) { %>

<option
    value="<%= dentist.getDentistId() %>"

    <%= appointment != null
        && appointment.getDentistId()
        == dentist.getDentistId()
        ? "selected"
        : "" %>
>

    <%= dentist.getDentistName() %>
    -
    <%= dentist.getSpecialization() %>

</option>

<% } %>

<% } %>

</select>

</div>


<!-- TREATMENT -->

<div class="form-group">

<label for="treatmentId">

    Treatment
    <span class="required">*</span>

</label>

<select
    id="treatmentId"
    name="treatmentId"
    required
>

<option value="">
    -- Select Treatment --
</option>


<% if (treatments != null) { %>

<% for (Treatment treatment : treatments) { %>

<option
    value="<%= treatment.getTreatmentId() %>"

    <%= appointment != null
        && appointment.getTreatmentId()
        == treatment.getTreatmentId()
        ? "selected"
        : "" %>
>

    <%= treatment.getTreatmentName() %>
    -
    LKR
    <%= String.format(
        "%.2f",
        treatment.getTreatmentFee()
    ) %>

</option>

<% } %>

<% } %>

</select>

</div>


<!-- DATE -->

<div class="form-group">

<label for="appointmentDate">

    Appointment Date
    <span class="required">*</span>

</label>

<input
    type="date"
    id="appointmentDate"
    name="appointmentDate"

    value="<%= appointment != null
        && appointment.getAppointmentDate() != null
        ? appointment.getAppointmentDate()
        : "" %>"

    required
>

</div>


<!-- TIME -->

<div class="form-group">

<label for="appointmentTime">

    Appointment Time
    <span class="required">*</span>

</label>

<input
    type="time"
    id="appointmentTime"
    name="appointmentTime"

    value="<%= appointment != null
        && appointment.getAppointmentTime() != null
        ? appointment.getAppointmentTime()
        : "" %>"

    required
>

</div>


<!-- STATUS -->

<div class="form-group">

<label for="status">

    Status
    <span class="required">*</span>

</label>

<select
    id="status"
    name="status"
    required
>

<option
    value="SCHEDULED"
    <%= appointment == null
        || "SCHEDULED".equals(appointment.getStatus())
        ? "selected"
        : "" %>
>
    Scheduled
</option>

<option
    value="COMPLETED"
    <%= appointment != null
        && "COMPLETED".equals(appointment.getStatus())
        ? "selected"
        : "" %>
>
    Completed
</option>

<option
    value="CANCELLED"
    <%= appointment != null
        && "CANCELLED".equals(appointment.getStatus())
        ? "selected"
        : "" %>
>
    Cancelled
</option>

<option
    value="NO_SHOW"
    <%= appointment != null
        && "NO_SHOW".equals(appointment.getStatus())
        ? "selected"
        : "" %>
>
    No Show
</option>

<option
    value="BILLED"
    <%= appointment != null
        && "BILLED".equals(appointment.getStatus())
        ? "selected"
        : "" %>
>
    Billed
</option>

</select>

</div>


<!-- NOTES -->

<div class="form-group">

<label for="notes">

    Notes
    <span class="optional">
        (Optional)
    </span>

</label>

<textarea
    id="notes"
    name="notes"
    maxlength="500"
    placeholder="Enter any additional notes..."
><%= appointment != null
    && appointment.getNotes() != null
    ? appointment.getNotes()
    : "" %></textarea>

</div>


<!-- ACTIONS -->

<div class="actions">

<button type="submit">

    <%= buttonText %>

</button>

<a
    class="cancel"
    href="<%= request.getContextPath() %>/appointments">

    Cancel

</a>

</div>

</form>

</div>

</body>

</html>
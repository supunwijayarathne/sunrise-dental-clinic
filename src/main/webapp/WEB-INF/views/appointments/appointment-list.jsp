<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.sunrise.model.Appointment" %>
<%@ page import="com.sunrise.model.Patient" %>
<%@ page import="com.sunrise.model.Dentist" %>
<%@ page import="com.sunrise.model.Treatment" %>

<%@ page import="com.sunrise.dao.PatientDAO" %>
<%@ page import="com.sunrise.dao.DentistDAO" %>
<%@ page import="com.sunrise.dao.TreatmentDAO" %>

<%
    List<Appointment> appointments =
        (List<Appointment>) request.getAttribute("appointments");

    String keyword =
        (String) request.getAttribute("keyword");

    PatientDAO patientDAO =
        new PatientDAO();

    DentistDAO dentistDAO =
        new DentistDAO();

    TreatmentDAO treatmentDAO =
        new TreatmentDAO();
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>
    Appointments - Sunrise Dental Clinic
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
    max-width: 1350px;
    margin: 40px auto;
    background: white;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.header h1 {
    margin: 0 0 7px;
}

.header p {
    color: #666;
}

.add-button {
    padding: 11px 18px;
    background: #222;
    color: white;
    text-decoration: none;
    border-radius: 6px;
}

.add-button:hover {
    background: #444;
}

.search-box {
    margin-top: 30px;
    padding: 18px;
    background: #f5f6f7;
    border-radius: 8px;
}

.search-form {
    display: flex;
    gap: 10px;
}

.search-input {
    flex: 1;
    padding: 11px;
    border: 1px solid #ccc;
    border-radius: 6px;
}

.search-button {
    padding: 11px 20px;
    background: #222;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

.clear-button {
    padding: 11px 18px;
    background: white;
    border: 1px solid #ccc;
    color: #222;
    text-decoration: none;
    border-radius: 6px;
}

.stats {
    margin-top: 25px;
    color: #555;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th {
    background: #f0f2f4;
    text-align: left;
    padding: 13px;
    white-space: nowrap;
}

td {
    padding: 13px;
    border-bottom: 1px solid #e5e5e5;
}

tr:hover {
    background: #fafafa;
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

.action-link {
    color: #222;
    text-decoration: none;
}

.action-link:hover {
    text-decoration: underline;
}

.success {
    background: #e6f7e9;
    color: #176b2c;
    padding: 13px;
    margin-top: 20px;
    border-radius: 6px;
}

.empty {
    text-align: center;
    padding: 50px;
    color: #777;
}

.back {
    display: inline-block;
    margin-top: 25px;
    color: #222;
}

</style>

</head>

<body>

<div class="container">


<!-- HEADER -->

<div class="header">

<div>

<h1>
    Appointments
</h1>

<p>
    Manage patient appointments and schedules.
</p>

</div>


<a
    class="add-button"
    href="<%= request.getContextPath() %>/appointments/add">

    + Book Appointment

</a>

</div>


<!-- SUCCESS -->

<% if ("1".equals(request.getParameter("success"))) { %>

<div class="success">

    Appointment created successfully.

</div>

<% } %>


<% if ("1".equals(request.getParameter("updated"))) { %>

<div class="success">

    Appointment updated successfully.

</div>

<% } %>


<!-- SEARCH -->

<div class="search-box">

<form
    class="search-form"
    method="get"
    action="<%= request.getContextPath() %>/appointments"
>

<input
    class="search-input"
    type="text"
    name="keyword"
    placeholder="Search appointment number, patient, dentist, treatment or status..."
    value="<%= keyword != null ? keyword : "" %>"
>

<button
    class="search-button"
    type="submit">

    Search

</button>


<% if (keyword != null
        && !keyword.trim().isEmpty()) { %>

<a
    class="clear-button"
    href="<%= request.getContextPath() %>/appointments">

    Clear

</a>

<% } %>

</form>

</div>


<!-- COUNT -->

<div class="stats">

Total Appointments:

<strong>
    <%= appointments != null ? appointments.size() : 0 %>
</strong>

</div>


<!-- TABLE -->

<% if (appointments != null && !appointments.isEmpty()) { %>

<table>

<thead>

<tr>

<th>Appointment No.</th>
<th>Patient</th>
<th>Dentist</th>
<th>Treatment</th>
<th>Date</th>
<th>Time</th>
<th>Status</th>
<th>Actions</th>

</tr>

</thead>


<tbody>

<% for (Appointment appointment : appointments) {

    Patient patient =
        patientDAO.getPatientById(
            appointment.getPatientId()
        );

    Dentist dentist =
        dentistDAO.getDentistById(
            appointment.getDentistId()
        );

    Treatment treatment =
        treatmentDAO.getTreatmentById(
            appointment.getTreatmentId()
        );
%>


<tr>

<td>

<strong>
    <%= appointment.getAppointmentNumber() %>
</strong>

</td>


<td>

<%= patient != null
    ? patient.getName()
    : "Unknown Patient" %>

</td>


<td>

<%= dentist != null
    ? dentist.getDentistName()
    : "Unknown Dentist" %>

</td>


<td>

<%= treatment != null
    ? treatment.getTreatmentName()
    : "Unknown Treatment" %>

</td>


<td>

<%= appointment.getAppointmentDate() %>

</td>


<td>

<%= appointment.getAppointmentTime() %>

</td>


<td>

<%
    String status =
        appointment.getStatus();

    String statusClass =
        status.toLowerCase().replace("_", "-");
%>

<span class="status <%= statusClass %>">

<%= status.replace("_", " ") %>

</span>

</td>


<td>

<a
    class="action-link"
    href="<%= request.getContextPath() %>/appointments/view?id=<%= appointment.getAppointmentId() %>">

    View

</a>

&nbsp; | &nbsp;

<a
    class="action-link"
    href="<%= request.getContextPath() %>/appointments/edit?id=<%= appointment.getAppointmentId() %>">

    Edit

</a>

</td>

</tr>


<% } %>

</tbody>

</table>


<% } else { %>

<div class="empty">

<% if (keyword != null
        && !keyword.trim().isEmpty()) { %>

    No appointments found for
    "<strong><%= keyword %></strong>".

<% } else { %>

    No appointments have been booked yet.

<% } %>

</div>

<% } %>


<a
    class="back"
    href="<%= request.getContextPath() %>/dashboard">

    ← Back to Dashboard

</a>


</div>

</body>

</html>
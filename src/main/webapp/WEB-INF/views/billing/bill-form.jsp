<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.sunrise.model.Appointment" %>

<%
    List<Appointment> appointments =
        (List<Appointment>) request.getAttribute("appointments");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>
    Create Bill - Sunrise Dental Clinic
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
    max-width: 650px;
    margin: 50px auto;
    background: white;
    padding: 35px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
}

h1 {
    margin-top: 0;
}

.description {
    color: #666;
    margin-bottom: 30px;
}

.form-group {
    margin-bottom: 22px;
}

label {
    display: block;
    margin-bottom: 7px;
    font-weight: bold;
}

input,
select {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
}

input:focus,
select:focus {
    outline: none;
    border-color: #222;
}

.error {
    background: #ffe5e5;
    color: #a40000;
    padding: 13px;
    margin-bottom: 22px;
    border-radius: 6px;
}

.info {
    background: #f1f3f5;
    padding: 15px;
    border-radius: 7px;
    margin-bottom: 25px;
    line-height: 1.6;
}

.required {
    color: #c00;
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
    Create Bill
</h1>

<p class="description">
    Generate a bill for a completed patient appointment.
</p>


<% if (request.getAttribute("error") != null) { %>

<div class="error">

    <%= request.getAttribute("error") %>

</div>

<% } %>


<div class="info">

<strong>Billing calculation</strong>

<br>

The system automatically calculates:

<br><br>

Consultation Fee + Treatment Fee = Total Amount

<br><br>

You cannot manually change the calculated fees.

</div>


<form
    method="post"
    action="<%= request.getContextPath() %>/bills/add"
>


<!-- BILL NUMBER -->

<div class="form-group">

<label for="billNumber">

    Bill Number
    <span class="required">*</span>

</label>

<input
    type="text"
    id="billNumber"
    name="billNumber"
    maxlength="30"
    placeholder="e.g. BILL-2026-001"
    required
>

</div>


<!-- APPOINTMENT -->

<div class="form-group">

<label for="appointmentId">

    Appointment
    <span class="required">*</span>

</label>

<select
    id="appointmentId"
    name="appointmentId"
    required
>

<option value="">
    -- Select Appointment --
</option>


<%
if (appointments != null) {

    for (Appointment appointment : appointments) {
%>

<option
    value="<%= appointment.getAppointmentId() %>"
>

    <%= appointment.getAppointmentNumber() %>
    -
    <%= appointment.getAppointmentDate() %>
    -
    <%= appointment.getAppointmentTime() %>

</option>

<%
    }
}
%>

</select>

</div>


<div class="actions">

<button type="submit">

    Generate Bill

</button>

<a
    class="cancel"
    href="<%= request.getContextPath() %>/bills">

    Cancel

</a>

</div>


</form>

</div>

</body>

</html>
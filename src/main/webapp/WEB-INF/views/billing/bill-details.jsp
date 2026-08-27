<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.sunrise.model.Bill" %>
<%@ page import="com.sunrise.model.Appointment" %>
<%@ page import="com.sunrise.model.Patient" %>
<%@ page import="com.sunrise.model.Dentist" %>
<%@ page import="com.sunrise.model.Treatment" %>

<%
    Bill bill =
        (Bill) request.getAttribute("bill");

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
    Bill Details - Sunrise Dental Clinic
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

.header {
    text-align: center;
    padding-bottom: 25px;
    border-bottom: 2px solid #222;
}

.header h1 {
    margin: 0;
}

.header p {
    color: #666;
}

.bill-number {
    margin-top: 15px;
    font-weight: bold;
}

.section {
    margin-top: 30px;
}

.section-title {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 12px;
}

.detail {
    display: flex;
    justify-content: space-between;
    padding: 12px 0;
    border-bottom: 1px solid #eee;
}

.label {
    color: #666;
}

.value {
    font-weight: bold;
}

.total {
    display: flex;
    justify-content: space-between;
    padding: 20px 0;
    margin-top: 10px;
    border-top: 2px solid #222;
    font-size: 20px;
    font-weight: bold;
}

.success {
    background: #e6f7e9;
    color: #176b2c;
    padding: 13px;
    margin-bottom: 20px;
    border-radius: 6px;
}

.actions {
    margin-top: 30px;
    display: flex;
    gap: 10px;
}

.print-button {
    padding: 11px 18px;
    background: #222;
    color: white;
    text-decoration: none;
    border-radius: 6px;
}

.back-button {
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


<div class="header">

<h1>
    Sunrise Dental Clinic
</h1>

<p>
    Patient Bill
</p>

<div class="bill-number">

    Bill No:
    <%= bill.getBillNumber() %>

</div>

</div>


<% if ("1".equals(request.getParameter("success"))) { %>

<div class="success">

    Bill created successfully.

</div>

<% } %>


<!-- PATIENT -->

<div class="section">

<div class="section-title">
    Patient Information
</div>


<div class="detail">

<span class="label">
    Patient Code
</span>

<span class="value">

<%= patient != null
    ? patient.getPatientCode()
    : "N/A" %>

</span>

</div>


<div class="detail">

<span class="label">
    Patient Name
</span>

<span class="value">

<%= patient != null
    ? patient.getName()
    : "N/A" %>

</span>

</div>

</div>


<!-- APPOINTMENT -->

<div class="section">

<div class="section-title">
    Appointment Information
</div>


<div class="detail">

<span class="label">
    Appointment Number
</span>

<span class="value">

<%= appointment != null
    ? appointment.getAppointmentNumber()
    : "N/A" %>

</span>

</div>


<div class="detail">

<span class="label">
    Appointment Date
</span>

<span class="value">

<%= appointment != null
    ? appointment.getAppointmentDate()
    : "N/A" %>

</span>

</div>


<div class="detail">

<span class="label">
    Appointment Time
</span>

<span class="value">

<%= appointment != null
    ? appointment.getAppointmentTime()
    : "N/A" %>

</span>

</div>

</div>


<!-- SERVICE -->

<div class="section">

<div class="section-title">
    Services
</div>


<div class="detail">

<span class="label">
    Dentist
</span>

<span class="value">

<%= dentist != null
    ? dentist.getDentistName()
    : "N/A" %>

</span>

</div>


<div class="detail">

<span class="label">
    Treatment
</span>

<span class="value">

<%= treatment != null
    ? treatment.getTreatmentName()
    : "N/A" %>

</span>

</div>


<div class="detail">

<span class="label">
    Consultation Fee
</span>

<span class="value">

LKR
<%= String.format(
    "%.2f",
    bill.getConsultationFee()
) %>

</span>

</div>


<div class="detail">

<span class="label">
    Treatment Fee
</span>

<span class="value">

LKR
<%= String.format(
    "%.2f",
    bill.getTreatmentFee()
) %>

</span>

</div>


<div class="total">

<span>
    Total Amount
</span>

<span>

LKR
<%= String.format(
    "%.2f",
    bill.getTotalAmount()
) %>

</span>

</div>

</div>


<!-- SYSTEM -->

<div class="section">

<div class="section-title">
    Bill Information
</div>


<div class="detail">

<span class="label">
    Created By
</span>

<span class="value">

User ID:
<%= bill.getCreatedBy() %>

</span>

</div>


<div class="detail">

<span class="label">
    Created At
</span>

<span class="value">

<%= bill.getCreatedAt() != null
    ? bill.getCreatedAt()
    : "N/A" %>

</span>

</div>

</div>


<div class="actions">

<a
    class="print-button"
    href="<%= request.getContextPath() %>/bills/print?id=<%= bill.getBillId() %>"
    target="_blank">

    Print Receipt

</a>

<a
    class="back-button"
    href="<%= request.getContextPath() %>/bills">

    ← Back to Bills

</a>

</div>


</div>

</body>

</html>
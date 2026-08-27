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
    Receipt - <%= bill.getBillNumber() %>
</title>

<style>

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: white;
    color: #222;
}

.receipt {
    width: 700px;
    margin: 30px auto;
    padding: 40px;
}

.header {
    text-align: center;
    border-bottom: 2px solid #222;
    padding-bottom: 20px;
}

.header h1 {
    margin: 0 0 8px;
}

.header p {
    margin: 4px 0;
    color: #666;
}

.bill-number {
    margin-top: 15px;
    font-weight: bold;
}

.info {
    margin-top: 25px;
}

.row {
    display: flex;
    justify-content: space-between;
    padding: 9px 0;
}

.label {
    color: #666;
}

.divider {
    border-top: 1px solid #ccc;
    margin: 15px 0;
}

.total {
    display: flex;
    justify-content: space-between;
    font-size: 20px;
    font-weight: bold;
    padding: 15px 0;
    border-top: 2px solid #222;
    border-bottom: 2px solid #222;
}

.footer {
    text-align: center;
    margin-top: 35px;
    color: #666;
    font-size: 13px;
}

.print-button {
    display: block;
    margin: 30px auto 0;
    padding: 11px 20px;
    background: #222;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

@media print {

    .print-button {
        display: none;
    }

    .receipt {
        margin: 0 auto;
    }

    body {
        background: white;
    }
}

</style>

</head>

<body>

<div class="receipt">


<div class="header">

<h1>
    Sunrise Dental Clinic
</h1>

<p>
    Patient Bill / Receipt
</p>

<div class="bill-number">

    Bill No:
    <%= bill.getBillNumber() %>

</div>

</div>


<!-- PATIENT -->

<div class="info">

<div class="row">

<span class="label">
    Patient Code
</span>

<span>
<%= patient != null
    ? patient.getPatientCode()
    : "N/A" %>
</span>

</div>


<div class="row">

<span class="label">
    Patient Name
</span>

<span>
<%= patient != null
    ? patient.getName()
    : "N/A" %>
</span>

</div>

</div>


<div class="divider"></div>


<!-- APPOINTMENT -->

<div class="info">

<div class="row">

<span class="label">
    Appointment No.
</span>

<span>
<%= appointment != null
    ? appointment.getAppointmentNumber()
    : "N/A" %>
</span>

</div>


<div class="row">

<span class="label">
    Date
</span>

<span>
<%= appointment != null
    ? appointment.getAppointmentDate()
    : "N/A" %>
</span>

</div>


<div class="row">

<span class="label">
    Time
</span>

<span>
<%= appointment != null
    ? appointment.getAppointmentTime()
    : "N/A" %>
</span>

</div>


<div class="row">

<span class="label">
    Dentist
</span>

<span>
<%= dentist != null
    ? dentist.getDentistName()
    : "N/A" %>
</span>

</div>


<div class="row">

<span class="label">
    Treatment
</span>

<span>
<%= treatment != null
    ? treatment.getTreatmentName()
    : "N/A" %>
</span>

</div>

</div>


<div class="divider"></div>


<!-- AMOUNTS -->

<div class="row">

<span class="label">
    Consultation Fee
</span>

<span>

LKR
<%= String.format(
    "%.2f",
    bill.getConsultationFee()
) %>

</span>

</div>


<div class="row">

<span class="label">
    Treatment Fee
</span>

<span>

LKR
<%= String.format(
    "%.2f",
    bill.getTreatmentFee()
) %>

</span>

</div>


<div class="total">

<span>
    TOTAL
</span>

<span>

LKR
<%= String.format(
    "%.2f",
    bill.getTotalAmount()
) %>

</span>

</div>


<div class="footer">

<p>
    Thank you for choosing Sunrise Dental Clinic.
</p>

<p>
    Generated on:
    <%= bill.getCreatedAt() %>
</p>

</div>


<button
    class="print-button"
    onclick="window.print()">

    Print Receipt

</button>


</div>

</body>

</html>
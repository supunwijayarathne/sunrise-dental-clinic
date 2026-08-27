<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.sunrise.model.Bill" %>
<%@ page import="com.sunrise.model.Appointment" %>
<%@ page import="com.sunrise.model.Patient" %>

<%@ page import="com.sunrise.dao.AppointmentDAO" %>
<%@ page import="com.sunrise.dao.PatientDAO" %>

<%
    List<Bill> bills =
        (List<Bill>) request.getAttribute("bills");

    String keyword =
        (String) request.getAttribute("keyword");

    AppointmentDAO appointmentDAO =
        new AppointmentDAO();

    PatientDAO patientDAO =
        new PatientDAO();
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>
    Bills - Sunrise Dental Clinic
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
    max-width: 1100px;
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
}

td {
    padding: 13px;
    border-bottom: 1px solid #e5e5e5;
}

tr:hover {
    background: #fafafa;
}

.total {
    font-weight: bold;
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


<div class="header">

<div>

<h1>
    Bills
</h1>

<p>
    Manage patient bills and receipts.
</p>

</div>


<a
    class="add-button"
    href="<%= request.getContextPath() %>/bills/add">

    + Create Bill

</a>

</div>


<% if ("1".equals(request.getParameter("success"))) { %>

<div class="success">

    Bill created successfully.

</div>

<% } %>


<!-- SEARCH -->

<div class="search-box">

<form
    class="search-form"
    method="get"
    action="<%= request.getContextPath() %>/bills"
>

<input
    class="search-input"
    type="text"
    name="keyword"
    placeholder="Search bill number, appointment or patient..."
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
    href="<%= request.getContextPath() %>/bills">

    Clear

</a>

<% } %>

</form>

</div>


<div class="stats">

Total Bills:

<strong>
    <%= bills != null ? bills.size() : 0 %>
</strong>

</div>


<% if (bills != null && !bills.isEmpty()) { %>

<table>

<thead>

<tr>

<th>Bill Number</th>
<th>Appointment</th>
<th>Patient</th>
<th>Consultation</th>
<th>Treatment</th>
<th>Total</th>
<th>Created</th>
<th>Actions</th>

</tr>

</thead>


<tbody>

<%
for (Bill bill : bills) {

    Appointment appointment =
        appointmentDAO.getAppointmentById(
            bill.getAppointmentId()
        );

    Patient patient = null;

    if (appointment != null) {

        patient =
            patientDAO.getPatientById(
                appointment.getPatientId()
            );
    }
%>


<tr>

<td>

<strong>
    <%= bill.getBillNumber() %>
</strong>

</td>


<td>

<%= appointment != null
    ? appointment.getAppointmentNumber()
    : "N/A" %>

</td>


<td>

<%= patient != null
    ? patient.getName()
    : "N/A" %>

</td>


<td>

LKR
<%= String.format(
    "%.2f",
    bill.getConsultationFee()
) %>

</td>


<td>

LKR
<%= String.format(
    "%.2f",
    bill.getTreatmentFee()
) %>

</td>


<td class="total">

LKR
<%= String.format(
    "%.2f",
    bill.getTotalAmount()
) %>

</td>


<td>

<%= bill.getCreatedAt() != null
    ? bill.getCreatedAt()
    : "N/A" %>

</td>


<td>

<a
    class="action-link"
    href="<%= request.getContextPath() %>/bills/view?id=<%= bill.getBillId() %>">

    View

</a>

&nbsp; | &nbsp;

<a
    class="action-link"
    href="<%= request.getContextPath() %>/bills/print?id=<%= bill.getBillId() %>"
    target="_blank">

    Print

</a>

</td>

</tr>


<%
}
%>

</tbody>

</table>


<% } else { %>

<div class="empty">

<% if (keyword != null
        && !keyword.trim().isEmpty()) { %>

    No bills found for
    "<strong><%= keyword %></strong>".

<% } else { %>

    No bills have been created yet.

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
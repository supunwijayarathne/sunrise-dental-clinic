<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.sunrise.model.Treatment" %>

<%
    Treatment treatment =
        (Treatment) request.getAttribute("treatment");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>
    Treatment Details - Sunrise Dental Clinic
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
    max-width: 700px;
    margin: 50px auto;
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

.treatment-id {
    display: inline-block;
    margin-top: 10px;
    padding: 8px 12px;
    background: #f0f2f4;
    border-radius: 6px;
    font-weight: bold;
}

.detail {
    padding: 18px 0;
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

.description {
    line-height: 1.6;
}

.fee {
    font-weight: bold;
}

.active {
    color: #16803c;
    font-weight: bold;
}

.inactive {
    color: #888;
    font-weight: bold;
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
    Treatment Details
</h1>

<p>
    Complete information about this dental treatment.
</p>

<div class="treatment-id">

    Treatment ID:
    <%= treatment.getTreatmentId() %>

</div>

</div>


<!-- SUCCESS -->

<% if ("1".equals(request.getParameter("updated"))) { %>

<div class="success">

    Treatment updated successfully.

</div>

<% } %>


<!-- NAME -->

<div class="detail">

<div class="label">
    Treatment Name
</div>

<div class="value">

    <%= treatment.getTreatmentName() %>

</div>

</div>


<!-- DESCRIPTION -->

<div class="detail">

<div class="label">
    Description
</div>

<div class="value description">

    <%= treatment.getDescription() %>

</div>

</div>


<!-- FEE -->

<div class="detail">

<div class="label">
    Treatment Fee
</div>

<div class="value fee">

    LKR
    <%= String.format(
        "%.2f",
        treatment.getTreatmentFee()
    ) %>

</div>

</div>


<!-- STATUS -->

<div class="detail">

<div class="label">
    Status
</div>

<div class="value">

<% if (treatment.isActive()) { %>

<span class="active">
    Active
</span>

<% } else { %>

<span class="inactive">
    Inactive
</span>

<% } %>

</div>

</div>


<!-- ACTIONS -->

<div class="actions">

<a
    class="edit-button"
    href="<%= request.getContextPath() %>/treatments/edit?id=<%= treatment.getTreatmentId() %>">

    Edit Treatment

</a>

<a
    class="back-button"
    href="<%= request.getContextPath() %>/treatments">

    ← Back to Treatments

</a>

</div>


</div>

</body>

</html>
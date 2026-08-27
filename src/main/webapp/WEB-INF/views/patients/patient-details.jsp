<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.sunrise.model.Patient" %>

<%
    Patient patient =
        (Patient) request.getAttribute("patient");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>
Patient Details - Sunrise Dental Clinic
</title>

<style>

    body {
        font-family: Arial, sans-serif;
        background: #f5f7fa;
        margin: 0;
        padding: 40px;
    }

    .container {
        max-width: 750px;
        margin: auto;
        background: white;
        padding: 35px;
        border-radius: 12px;
        box-sizing: border-box;
    }

    .header {
        margin-bottom: 30px;
    }

    .header h1 {
        margin: 0 0 8px 0;
    }

    .header p {
        margin: 0;
        color: #666;
    }

    .patient-code {
        display: inline-block;
        margin-top: 15px;
        padding: 7px 12px;
        background: #f1f1f1;
        border-radius: 6px;
        font-weight: bold;
    }

    .details {
        margin-top: 30px;
    }

    .detail-row {
        padding: 16px 0;
        border-bottom: 1px solid #e5e5e5;
    }

    .label {
        font-size: 13px;
        font-weight: bold;
        color: #666;
        margin-bottom: 6px;
    }

    .value {
        font-size: 16px;
        color: #222;
    }

    .actions {
        margin-top: 30px;
        display: flex;
        gap: 12px;
        align-items: center;
    }

    .button {
        display: inline-block;
        padding: 10px 16px;
        background: #222;
        color: white;
        text-decoration: none;
        border-radius: 6px;
    }

    .button:hover {
        background: #000;
    }

    .secondary-button {
        display: inline-block;
        padding: 10px 16px;
        border: 1px solid #ccc;
        color: #222;
        text-decoration: none;
        border-radius: 6px;
        background: white;
    }

    .secondary-button:hover {
        background: #f5f5f5;
    }

    .error {
        padding: 15px;
        background: #ffe5e5;
        color: #a00000;
        border-radius: 6px;
    }

</style>

</head>

<body>

<div class="container">

    <% if (patient == null) { %>

        <div class="error">
            Patient information could not be found.
        </div>

        <div class="actions">

            <a class="secondary-button"
               href="<%= request.getContextPath() %>/patients">
                ← Back to Patients
            </a>

        </div>

    <% } else { %>

        <div class="header">

            <h1>
                Patient Details
            </h1>

            <p>
                View registered patient information.
            </p>

            <div class="patient-code">
                <%= patient.getPatientCode() %>
            </div>

        </div>


        <div class="details">

            <div class="detail-row">

                <div class="label">
                    Patient Name
                </div>

                <div class="value">
                    <%= patient.getName() %>
                </div>

            </div>


            <div class="detail-row">

                <div class="label">
                    Contact Number
                </div>

                <div class="value">
                    <%= patient.getContactNumber() %>
                </div>

            </div>


            <div class="detail-row">

                <div class="label">
                    Email Address
                </div>

                <div class="value">

                    <%
                        if (patient.getEmail() == null
                                || patient.getEmail().isBlank()) {
                    %>

                        -

                    <% } else { %>

                        <%= patient.getEmail() %>

                    <% } %>

                </div>

            </div>


            <div class="detail-row">

                <div class="label">
                    Address
                </div>

                <div class="value">
                    <%= patient.getAddress() %>
                </div>

            </div>


            <div class="detail-row">

                <div class="label">
                    Registered Date
                </div>

                <div class="value">

                    <%
                        if (patient.getCreatedAt() == null) {
                    %>

                        -

                    <% } else { %>

                        <%= patient.getCreatedAt() %>

                    <% } %>

                </div>

            </div>

        </div>


        <div class="actions">

            <a class="button"
               href="<%= request.getContextPath() %>/patients/edit?id=<%= patient.getPatientId() %>">
                Edit Patient
            </a>

            <a class="secondary-button"
               href="<%= request.getContextPath() %>/patients">
                ← Back to Patients
            </a>
            
            <a class="button"
   href="<%= request.getContextPath() %>/patients/edit?id=<%= patient.getPatientId() %>">
    Edit Patient
</a>

        </div>

    <% } %>

</div>

</body>
</html>
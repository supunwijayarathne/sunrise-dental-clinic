<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.sunrise.model.Patient" %>

<%
    List<Patient> patients =
        (List<Patient>) request.getAttribute("patients");

    String keyword =
        (String) request.getAttribute("keyword");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>
Patients - Sunrise Dental Clinic
</title>

<style>

    body {
        font-family: Arial, sans-serif;
        background: #f5f7fa;
        margin: 0;
        padding: 40px;
    }

    .container {
        max-width: 1150px;
        margin: auto;
        background: white;
        padding: 30px;
        border-radius: 10px;
    }

    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .header h1 {
        margin-bottom: 5px;
    }

    .header p {
        color: #666;
    }

    .button {
        display: inline-block;
        padding: 10px 16px;
        background: #222;
        color: white;
        text-decoration: none;
        border-radius: 5px;
    }

    .search-section {
        margin-top: 25px;
        padding: 20px;
        background: #f5f5f5;
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
        border-radius: 5px;
        font-size: 14px;
    }

    .search-button {
        padding: 11px 20px;
        border: none;
        background: #222;
        color: white;
        border-radius: 5px;
        cursor: pointer;
    }

    .clear-button {
        padding: 11px 20px;
        background: white;
        color: #222;
        border: 1px solid #ccc;
        border-radius: 5px;
        text-decoration: none;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 25px;
    }

    th,
    td {
        text-align: left;
        padding: 12px;
        border-bottom: 1px solid #ddd;
    }

    th {
        background: #f0f2f5;
    }

    td a {
        color: #222;
    }

    .success {
        background: #e6f7e6;
        color: #176b17;
        padding: 12px;
        margin-top: 20px;
        border-radius: 5px;
    }

    .updated {
        background: #e6f7e6;
        color: #176b17;
        padding: 12px;
        margin-top: 20px;
        border-radius: 5px;
    }

    .empty {
        padding: 30px;
        text-align: center;
        color: #777;
    }

    .result-count {
        margin-top: 20px;
        color: #666;
    }

    .navigation {
        margin-top: 25px;
    }

</style>

</head>

<body>

<div class="container">

    <!-- HEADER -->

    <div class="header">

        <div>

            <h1>
                Patients
            </h1>

            <p>
                Manage registered clinic patients.
            </p>

        </div>

        <a
            class="button"
            href="<%= request.getContextPath() %>/patients/add">

            + Add Patient

        </a>

    </div>


    <!-- SUCCESS MESSAGE -->

    <% if ("1".equals(request.getParameter("success"))) { %>

        <div class="success">
            Patient registered successfully.
        </div>

    <% } %>


    <!-- UPDATE MESSAGE -->

    <% if ("1".equals(request.getParameter("updated"))) { %>

        <div class="updated">
            Patient updated successfully.
        </div>

    <% } %>


    <!-- SEARCH -->

    <div class="search-section">

        <form
            class="search-form"
            method="get"
            action="<%= request.getContextPath() %>/patients"
        >

            <input
                class="search-input"
                type="text"
                name="keyword"
                placeholder="Search by patient code, name or contact number..."
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
                    href="<%= request.getContextPath() %>/patients">

                    Clear

                </a>

            <% } %>

        </form>

    </div>


    <!-- RESULT COUNT -->

    <div class="result-count">

        <%
            if (keyword != null
                    && !keyword.trim().isEmpty()) {
        %>

            Search results for:
            <strong>
                <%= keyword %>
            </strong>

            —
            <%= patients != null ? patients.size() : 0 %>
            result(s)

        <% } else { %>

            Total patients:
            <strong>
                <%= patients != null ? patients.size() : 0 %>
            </strong>

        <% } %>

    </div>


    <!-- PATIENT TABLE -->

    <% if (patients != null && !patients.isEmpty()) { %>

        <table>

            <thead>

                <tr>

                    <th>
                        Patient Code
                    </th>

                    <th>
                        Name
                    </th>

                    <th>
                        Contact Number
                    </th>

                    <th>
                        Email
                    </th>

                    <th>
                        Address
                    </th>

                    <th>
                        Actions
                    </th>

                </tr>

            </thead>


            <tbody>

            <% for (Patient patient : patients) { %>

                <tr>

                    <td>
                        <%= patient.getPatientCode() %>
                    </td>

                    <td>
                        <%= patient.getName() %>
                    </td>

                    <td>
                        <%= patient.getContactNumber() %>
                    </td>

                    <td>

                        <%= patient.getEmail() == null
                            || patient.getEmail().isBlank()
                            ? "-"
                            : patient.getEmail() %>

                    </td>

                    <td>
                        <%= patient.getAddress() %>
                    </td>

                    <td>

                        <a
                            href="<%= request.getContextPath() %>/patients/view?id=<%= patient.getPatientId() %>">

                            View

                        </a>

                        &nbsp; | &nbsp;

                        <a
                            href="<%= request.getContextPath() %>/patients/edit?id=<%= patient.getPatientId() %>">

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

                No patients found for
                "<strong><%= keyword %></strong>".

            <% } else { %>

                No patients have been registered yet.

            <% } %>

        </div>

    <% } %>


    <!-- NAVIGATION -->

    <div class="navigation">

        <a href="<%= request.getContextPath() %>/dashboard">
            ← Back to Dashboard
        </a>

    </div>

</div>

</body>

</html>
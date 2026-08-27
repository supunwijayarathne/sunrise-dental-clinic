<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.sunrise.model.Patient" %>

<%
    Patient patient =
        (Patient) request.getAttribute("patient");

    String formMode =
        (String) request.getAttribute("formMode");

    boolean editMode =
        "edit".equals(formMode);

    String pageTitle =
        editMode
        ? "Edit Patient"
        : "Register New Patient";

    String buttonText =
        editMode
        ? "Update Patient"
        : "Register Patient";
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>
<%= pageTitle %> - Sunrise Dental Clinic
</title>

<style>

    body {
        font-family: Arial, sans-serif;
        background: #f5f7fa;
        margin: 0;
        padding: 40px;
    }

    .container {
        max-width: 600px;
        margin: auto;
        background: white;
        padding: 30px;
        border-radius: 10px;
    }

    h1 {
        margin-top: 0;
    }

    .description {
        color: #666;
        margin-bottom: 25px;
    }

    .form-group {
        margin-bottom: 18px;
    }

    label {
        display: block;
        margin-bottom: 6px;
        font-weight: bold;
    }

    input,
    textarea {
        width: 100%;
        padding: 10px;
        box-sizing: border-box;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 14px;
    }

    textarea {
        resize: vertical;
    }

    input:focus,
    textarea:focus {
        outline: none;
        border-color: #222;
    }

    .patient-code {
        background: #f1f1f1;
        padding: 10px;
        border-radius: 5px;
        color: #555;
    }

    .error {
        background: #ffe5e5;
        color: #a40000;
        padding: 10px;
        margin-bottom: 20px;
        border-radius: 5px;
    }

    .actions {
        margin-top: 25px;
    }

    button {
        padding: 11px 18px;
        background: #222;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    button:hover {
        background: #000;
    }

    .back-link {
        margin-left: 12px;
    }

</style>

</head>

<body>

<div class="container">

    <h1>
        <%= pageTitle %>
    </h1>

    <p class="description">

        <% if (editMode) { %>

            Update the patient's registered information.

        <% } else { %>

            Enter the patient's information to register them.

        <% } %>

    </p>


    <% if (request.getAttribute("error") != null) { %>

        <div class="error">

            <%= request.getAttribute("error") %>

        </div>

    <% } %>


    <form
        method="post"
        action="<%= request.getContextPath() %>/patients/<%= editMode ? "edit" : "add" %>"
    >


        <% if (editMode) { %>

            <!-- Patient ID -->

            <input
                type="hidden"
                name="patientId"
                value="<%= patient.getPatientId() %>"
            >


            <!-- Patient Code -->

            <div class="form-group">

                <label>
                    Patient Code
                </label>

                <div class="patient-code">
                    <%= patient.getPatientCode() %>
                </div>

            </div>

        <% } %>


        <!-- Patient Name -->

        <div class="form-group">

            <label for="name">
                Patient Name *
            </label>

            <input
                type="text"
                id="name"
                name="name"
                maxlength="100"
                value="<%= patient != null && patient.getName() != null
                    ? patient.getName()
                    : "" %>"
                required
            >

        </div>


        <!-- Address -->

        <div class="form-group">

            <label for="address">
                Address *
            </label>

            <textarea
                id="address"
                name="address"
                rows="3"
                maxlength="255"
                required
            ><%= patient != null && patient.getAddress() != null
                ? patient.getAddress()
                : "" %></textarea>

        </div>


        <!-- Contact Number -->

        <div class="form-group">

            <label for="contactNumber">
                Contact Number *
            </label>

            <input
                type="text"
                id="contactNumber"
                name="contactNumber"
                maxlength="15"
                pattern="[0-9+ ]{9,15}"
                title="Enter a valid contact number"
                value="<%= patient != null && patient.getContactNumber() != null
                    ? patient.getContactNumber()
                    : "" %>"
                required
            >

        </div>


        <!-- Email -->

        <div class="form-group">

            <label for="email">
                Email
            </label>

            <input
                type="email"
                id="email"
                name="email"
                maxlength="100"
                value="<%= patient != null && patient.getEmail() != null
                    ? patient.getEmail()
                    : "" %>"
            >

        </div>


        <!-- Buttons -->

        <div class="actions">

            <button type="submit">
                <%= buttonText %>
            </button>


            <% if (editMode) { %>

                <a
                    class="back-link"
                    href="<%= request.getContextPath() %>/patients/view?id=<%= patient.getPatientId() %>"
                >
                    Cancel
                </a>

            <% } else { %>

                <a
                    class="back-link"
                    href="<%= request.getContextPath() %>/patients"
                >
                    Cancel
                </a>

            <% } %>

        </div>

    </form>

</div>

</body>

</html>
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.sunrise.model.Dentist" %>

<%
    Dentist dentist =
        (Dentist) request.getAttribute("dentist");

    String formMode =
        (String) request.getAttribute("formMode");

    boolean editMode =
        "edit".equals(formMode);

    String title =
        editMode ? "Edit Dentist" : "Add Dentist";

    String buttonText =
        editMode ? "Update Dentist" : "Add Dentist";
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
    max-width: 650px;
    margin: 50px auto;
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

.required {
    color: #c00;
}

.optional {
    color: #888;
    font-size: 12px;
    font-weight: normal;
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
        ? "Update dentist information."
        : "Register a new dentist in the clinic system." %>
</p>


<% if (request.getAttribute("error") != null) { %>

<div class="error">

    <%= request.getAttribute("error") %>

</div>

<% } %>


<% if (editMode) { %>

<div class="info-box">

    Dentist ID:
    <strong>
        <%= dentist.getDentistId() %>
    </strong>

</div>

<input
    type="hidden"
    name="dentistId"
    form="dentistForm"
    value="<%= dentist.getDentistId() %>"
>

<% } %>


<form
    id="dentistForm"
    method="post"
    action="<%= request.getContextPath() %>/dentists/<%= editMode ? "edit" : "add" %>"
>


<!-- DENTIST NAME -->

<div class="form-group">

<label for="dentistName">

    Dentist Name
    <span class="required">*</span>

</label>

<input
    type="text"
    id="dentistName"
    name="dentistName"
    maxlength="100"
    placeholder="Enter dentist name"
    value="<%= dentist != null
        && dentist.getDentistName() != null
        ? dentist.getDentistName()
        : "" %>"
    required
>

</div>


<!-- SPECIALIZATION -->

<div class="form-group">

<label for="specialization">

    Specialization
    <span class="required">*</span>

</label>

<input
    type="text"
    id="specialization"
    name="specialization"
    maxlength="100"
    placeholder="e.g. General Dentistry"
    value="<%= dentist != null
        && dentist.getSpecialization() != null
        ? dentist.getSpecialization()
        : "" %>"
    required
>

</div>


<!-- CONSULTATION FEE -->

<div class="form-group">

<label for="consultationFee">

    Consultation Fee
    <span class="required">*</span>

</label>

<input
    type="number"
    id="consultationFee"
    name="consultationFee"
    min="0"
    step="0.01"
    placeholder="Enter consultation fee"
    value="<%= dentist != null
        ? dentist.getConsultationFee()
        : "" %>"
    required
>

</div>


<!-- PHONE NUMBER -->

<div class="form-group">

<label for="phoneNumber">

    Phone Number
    <span class="required">*</span>

</label>

<input
    type="text"
    id="phoneNumber"
    name="phoneNumber"
    maxlength="15"
    placeholder="0712345678"
    value="<%= dentist != null
        && dentist.getPhoneNumber() != null
        ? dentist.getPhoneNumber()
        : "" %>"
    required
>

</div>


<!-- EMAIL -->

<div class="form-group">

<label for="email">

    Email
    <span class="optional">(Optional)</span>

</label>

<input
    type="email"
    id="email"
    name="email"
    maxlength="100"
    placeholder="example@gmail.com"
    value="<%= dentist != null
        && dentist.getEmail() != null
        ? dentist.getEmail()
        : "" %>"
>

</div>


<!-- ACTIVE STATUS -->

<div class="form-group">

<label for="active">
    Status
</label>

<select id="active" name="active">

<option
    value="true"
    <%= dentist == null || dentist.isActive()
        ? "selected"
        : "" %>
>
    Active
</option>

<option
    value="false"
    <%= dentist != null && !dentist.isActive()
        ? "selected"
        : "" %>
>
    Inactive
</option>

</select>

</div>


<!-- BUTTONS -->

<div class="actions">

<button type="submit">

    <%= buttonText %>

</button>

<a
    class="cancel"
    href="<%= request.getContextPath() %>/dentists">

    Cancel

</a>

</div>

</form>

</div>

</body>

</html>
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.sunrise.model.Treatment" %>

<%
    Treatment treatment =
        (Treatment) request.getAttribute("treatment");

    String formMode =
        (String) request.getAttribute("formMode");

    boolean editMode =
        "edit".equals(formMode);

    String title =
        editMode ? "Edit Treatment" : "Add Treatment";

    String buttonText =
        editMode ? "Update Treatment" : "Add Treatment";
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
textarea,
select {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
    font-family: Arial, sans-serif;
}

textarea {
    min-height: 120px;
    resize: vertical;
}

input:focus,
textarea:focus,
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

</style>

</head>

<body>

<div class="container">

<h1>
    <%= title %>
</h1>

<p class="description">

<%= editMode
    ? "Update treatment information."
    : "Register a new dental treatment in the clinic system." %>

</p>


<% if (request.getAttribute("error") != null) { %>

<div class="error">

    <%= request.getAttribute("error") %>

</div>

<% } %>


<% if (editMode) { %>

<div class="info-box">

    Treatment ID:
    <strong>
        <%= treatment.getTreatmentId() %>
    </strong>

</div>

<% } %>


<form
    id="treatmentForm"
    method="post"
    action="<%= request.getContextPath() %>/treatments/<%= editMode ? "edit" : "add" %>"
>


<% if (editMode) { %>

<input
    type="hidden"
    name="treatmentId"
    value="<%= treatment.getTreatmentId() %>"
>

<% } %>


<!-- TREATMENT NAME -->

<div class="form-group">

<label for="treatmentName">

    Treatment Name
    <span class="required">*</span>

</label>

<input
    type="text"
    id="treatmentName"
    name="treatmentName"
    maxlength="100"
    placeholder="e.g. Dental Cleaning"
    value="<%= treatment != null
        && treatment.getTreatmentName() != null
        ? treatment.getTreatmentName()
        : "" %>"
    required
>

</div>


<!-- DESCRIPTION -->

<div class="form-group">

<label for="description">

    Description
    <span class="required">*</span>

</label>

<textarea
    id="description"
    name="description"
    maxlength="500"
    placeholder="Enter treatment description"
    required
><%= treatment != null
    && treatment.getDescription() != null
    ? treatment.getDescription()
    : "" %></textarea>

</div>


<!-- TREATMENT FEE -->

<div class="form-group">

<label for="treatmentFee">

    Treatment Fee
    <span class="required">*</span>

</label>

<input
    type="number"
    id="treatmentFee"
    name="treatmentFee"
    min="0"
    step="0.01"
    placeholder="Enter treatment fee"
    value="<%= treatment != null
        ? treatment.getTreatmentFee()
        : "" %>"
    required
>

</div>


<!-- STATUS -->

<div class="form-group">

<label for="active">
    Status
</label>

<select
    id="active"
    name="active"
>

<option
    value="true"
    <%= treatment == null || treatment.isActive()
        ? "selected"
        : "" %>
>
    Active
</option>

<option
    value="false"
    <%= treatment != null && !treatment.isActive()
        ? "selected"
        : "" %>
>
    Inactive
</option>

</select>

</div>


<!-- ACTIONS -->

<div class="actions">

<button type="submit">

    <%= buttonText %>

</button>

<a
    class="cancel"
    href="<%= request.getContextPath() %>/treatments">

    Cancel

</a>

</div>

</form>

</div>

</body>

</html>
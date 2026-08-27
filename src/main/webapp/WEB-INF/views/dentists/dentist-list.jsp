<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.sunrise.model.Dentist" %>

<%
    List<Dentist> dentists =
        (List<Dentist>) request.getAttribute("dentists");

    String keyword =
        (String) request.getAttribute("keyword");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>
    Dentists - Sunrise Dental Clinic
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
    max-width: 1200px;
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

.add-button:hover {
    background: #444;
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
    cursor: pointer;
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

.status-active {
    color: #16803c;
    font-weight: bold;
}

.status-inactive {
    color: #888;
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


<!-- HEADER -->

<div class="header">

<div>

<h1>
    Dentists
</h1>

<p>
    Manage dentists and their clinic information.
</p>

</div>


<a
    class="add-button"
    href="<%= request.getContextPath() %>/dentists/add">

    + Add Dentist

</a>

</div>


<!-- SUCCESS MESSAGE -->

<% if ("1".equals(request.getParameter("success"))) { %>

<div class="success">

    Dentist added successfully.

</div>

<% } %>


<% if ("1".equals(request.getParameter("updated"))) { %>

<div class="success">

    Dentist updated successfully.

</div>

<% } %>


<!-- SEARCH -->

<div class="search-box">

<form
    class="search-form"
    method="get"
    action="<%= request.getContextPath() %>/dentists"
>

<input
    class="search-input"
    type="text"
    name="keyword"
    placeholder="Search by name, specialization, phone or email..."
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
    href="<%= request.getContextPath() %>/dentists">

    Clear

</a>

<% } %>

</form>

</div>


<!-- COUNT -->

<div class="stats">

Total Dentists:

<strong>
    <%= dentists != null ? dentists.size() : 0 %>
</strong>

</div>


<!-- TABLE -->

<% if (dentists != null && !dentists.isEmpty()) { %>

<table>

<thead>

<tr>

<th>ID</th>

<th>Dentist Name</th>

<th>Specialization</th>

<th>Consultation Fee</th>

<th>Phone</th>

<th>Email</th>

<th>Status</th>

<th>Actions</th>

</tr>

</thead>


<tbody>

<% for (Dentist dentist : dentists) { %>

<tr>

<td>
    <%= dentist.getDentistId() %>
</td>

<td>
    <strong>
        <%= dentist.getDentistName() %>
    </strong>
</td>

<td>
    <%= dentist.getSpecialization() %>
</td>

<td>
    LKR
    <%= String.format(
        "%.2f",
        dentist.getConsultationFee()
    ) %>
</td>

<td>
    <%= dentist.getPhoneNumber() %>
</td>

<td>

<%= dentist.getEmail() == null
    || dentist.getEmail().isBlank()
    ? "-"
    : dentist.getEmail() %>

</td>

<td>

<% if (dentist.isActive()) { %>

<span class="status-active">
    Active
</span>

<% } else { %>

<span class="status-inactive">
    Inactive
</span>

<% } %>

</td>

<td>

<a
    class="action-link"
    href="<%= request.getContextPath() %>/dentists/view?id=<%= dentist.getDentistId() %>">

    View

</a>

&nbsp; | &nbsp;

<a
    class="action-link"
    href="<%= request.getContextPath() %>/dentists/edit?id=<%= dentist.getDentistId() %>">

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

    No dentists found for
    "<strong><%= keyword %></strong>".

<% } else { %>

    No dentists have been registered yet.

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
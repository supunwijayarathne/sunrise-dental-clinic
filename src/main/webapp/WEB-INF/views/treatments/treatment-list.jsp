<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.sunrise.model.Treatment" %>

<%
    List<Treatment> treatments =
        (List<Treatment>) request.getAttribute("treatments");

    String keyword =
        (String) request.getAttribute("keyword");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>
    Treatments - Sunrise Dental Clinic
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

.description-cell {
    max-width: 300px;
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
    Treatments
</h1>

<p>
    Manage dental treatments and treatment fees.
</p>

</div>


<a
    class="add-button"
    href="<%= request.getContextPath() %>/treatments/add">

    + Add Treatment

</a>

</div>


<!-- SUCCESS -->

<% if ("1".equals(request.getParameter("success"))) { %>

<div class="success">

    Treatment added successfully.

</div>

<% } %>


<% if ("1".equals(request.getParameter("updated"))) { %>

<div class="success">

    Treatment updated successfully.

</div>

<% } %>


<!-- SEARCH -->

<div class="search-box">

<form
    class="search-form"
    method="get"
    action="<%= request.getContextPath() %>/treatments"
>

<input
    class="search-input"
    type="text"
    name="keyword"
    placeholder="Search by treatment name or description..."
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
    href="<%= request.getContextPath() %>/treatments">

    Clear

</a>

<% } %>

</form>

</div>


<!-- COUNT -->

<div class="stats">

Total Treatments:

<strong>
    <%= treatments != null ? treatments.size() : 0 %>
</strong>

</div>


<!-- TABLE -->

<% if (treatments != null && !treatments.isEmpty()) { %>

<table>

<thead>

<tr>

<th>ID</th>

<th>Treatment Name</th>

<th>Description</th>

<th>Treatment Fee</th>

<th>Status</th>

<th>Actions</th>

</tr>

</thead>


<tbody>

<% for (Treatment treatment : treatments) { %>

<tr>

<td>
    <%= treatment.getTreatmentId() %>
</td>

<td>

<strong>
    <%= treatment.getTreatmentName() %>
</strong>

</td>

<td class="description-cell">

    <%= treatment.getDescription() %>

</td>

<td>

    LKR
    <%= String.format(
        "%.2f",
        treatment.getTreatmentFee()
    ) %>

</td>

<td>

<% if (treatment.isActive()) { %>

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
    href="<%= request.getContextPath() %>/treatments/view?id=<%= treatment.getTreatmentId() %>">

    View

</a>

&nbsp; | &nbsp;

<a
    class="action-link"
    href="<%= request.getContextPath() %>/treatments/edit?id=<%= treatment.getTreatmentId() %>">

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

    No treatments found for
    "<strong><%= keyword %></strong>".

<% } else { %>

    No treatments have been registered yet.

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
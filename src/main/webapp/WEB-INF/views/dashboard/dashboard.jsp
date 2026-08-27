<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.sunrise.model.User" %>

<%
    User user = (User) session.getAttribute("loggedUser");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard - Sunrise Dental Clinic</title>
</head>

<body>

    <h1>Sunrise Dental Clinic</h1>

    <h2>Dashboard</h2>

    <% if (user != null) { %>

        <p>
            Welcome,
            <strong><%= user.getFullName() %></strong>
        </p>

        <p>
            Role:
            <%= user.getRole() %>
        </p>
        
        <p>
    <a href="<%= request.getContextPath() %>/patients">
        Manage Patients
    </a>
</p>
        
        <a href="<%= request.getContextPath() %>/logout">
    Logout
</a>

    <% } %>

</body>
</html>
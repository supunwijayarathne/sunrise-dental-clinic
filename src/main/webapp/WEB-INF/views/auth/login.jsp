<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - Sunrise Dental Clinic</title>
</head>

<body>

    <h1>Sunrise Dental Clinic</h1>

    <h2>Staff Login</h2>

    <% if (request.getAttribute("error") != null) { %>

        <p style="color:red;">
            <%= request.getAttribute("error") %>
        </p>

    <% } %>

    <form method="post"
          action="<%= request.getContextPath() %>/login">

        <div>
            <label>Username</label>
            <input type="text"
                   name="username"
                   required>
        </div>

        <br>

        <div>
            <label>Password</label>
            <input type="password"
                   name="password"
                   required>
        </div>

        <br>

        <button type="submit">
            Login
        </button>

    </form>

</body>
</html>
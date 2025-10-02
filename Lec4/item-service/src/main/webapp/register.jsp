<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 40px;
            color: #333;
        }
        .container {
            max-width: 400px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }
        h1 { text-align: center; color: #2c3e50; margin-bottom: 25px; }
        label { display: block; margin-bottom: 6px; font-weight: 600; color: #333; }
        input { width: 100%; padding: 10px 12px; margin-bottom: 20px; border: 1px solid #ddd; border-radius: 8px; font-size: 15px; }
        input:focus { border-color: #7131ad; outline: none; box-shadow: 0 0 5px rgba(113,49,173,0.3); }
        .btn { display: block; width: 100%; padding: 12px; border: none; border-radius: 8px; font-weight: 600; font-size: 15px; cursor: pointer; background: #7131ad; color: #fff; transition: 0.3s; }
        .btn:hover { background: #2980b9; }
        .login-link { text-align: center; margin-top: 15px; }
        .login-link a { color: #7131ad; text-decoration: none; }
        .login-link a:hover { text-decoration: underline; }
    </style>
</head>
<body>
<%
    session = request.getSession(false);
    if (session != null && session.getAttribute("loggedUser") != null) {
        response.sendRedirect(request.getContextPath() + "/ItemController?action=show-items");
        return;
    }
%>
<div class="container">
    <h1>Register</h1>
    <form action="UserController" method="post">
        <input type="hidden" name="action" value="register">
        <label>Full Name</label>
        <input type="text" name="full_name" required>
        <label>Username</label>
        <input type="text" name="username" required>
        <label>Password</label>
        <input type="password" name="password" required>
        <button type="submit" class="btn">Register</button>
    </form>
    <div class="login-link">
        Already have an account? <a href="login.jsp">Login</a>
    </div>
</div>
</body>
</html>

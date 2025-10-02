<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Forget Password</title>
    <style>
        body { font-family: 'Poppins', sans-serif; background: #f4f6f9; padding: 40px; }
        .container { max-width: 400px; margin: auto; background: #fff; padding: 30px; border-radius: 12px; box-shadow: 0 6px 20px rgba(0,0,0,0.1);}
        h1 { text-align: center; color: #2c3e50; margin-bottom: 25px; }
        input { width: 100%; padding: 10px; margin-bottom: 20px; border-radius: 8px; border: 1px solid #ddd; }
        .btn { display: block; width: 100%; padding: 12px; border: none; border-radius: 8px; background: #7131ad; color: #fff; cursor: pointer; }
        .btn:hover { background: #2980b9; }
        .message { color: green; text-align: center; margin-bottom: 15px; }
        .error { color: red; text-align: center; margin-bottom: 15px; }
    </style>
</head>
<body>
<div class="container">
    <h1>Forget Password</h1>

    <% if(request.getParameter("error") != null) { %>
        <div class="error">Username not found</div>
    <% } %>
    <% if(request.getParameter("sent") != null) { %>
        <div class="message">Password reset sent to your email (demo)</div>
    <% } %>

    <form action="UserController" method="post">
        <input type="hidden" name="action" value="forget-password">
        <label>Username</label>
        <input type="text" name="username" required>
        <button type="submit" class="btn">Reset Password</button>
    </form>
</div>
</body>
</html>

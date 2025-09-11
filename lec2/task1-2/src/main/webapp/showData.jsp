<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Show Data</title>
</head>
<body>

<% 
    String fullname = request.getParameter("fullname");
    String age = request.getParameter("age");
%>
        <h2 style="color: red">Data sent from form</h2>
        <p>Full Name: <%= fullname %></p>
        <p>Age: <%= age %></p>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Task 1</title>
</head>

<%!  
    public String fullName(int id, String name) {
        return "id: " + id + " , " + "name: " + name;
    }
%>

<body>
<%
    int id = 10;
    String name = "ammar";
    String result = fullName(id, name);
%>

<h1><%= result %></h1>

</body>
</html>

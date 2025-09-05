<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Result Page</title>
</head>
<body>

<%
    String fullName = request.getParameter("fullName");
    String password = request.getParameter("password");
    String age = request.getParameter("age");
    String addressRadio = request.getParameter("address");
    String addressSelect = request.getParameter("addresss");
%>

<h1> <%= fullName %></h1>
<h1> <%= password %></h1>
<h1> <%= age %></h1>
<h1> <%= addressRadio %></h1>
<h1> <%= addressSelect %></h1>

</body>
</html>

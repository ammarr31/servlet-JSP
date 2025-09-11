<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orders</title>
</head>
<body>
<%
List<String> orders = (List<String>)session.getAttribute("ordered");
if(orders == null){
	orders = new ArrayList<>();
	session.setAttribute("ordered", orders);
}

String order = request.getParameter("order");
if(order != null){
	orders.add(order);
}

if(orders != null && orders.size() != 0)
{
	for(String o : orders){
		out.print("<h1>" + o + "</h1>");
	}
}
else{
	out.print("<h1> no thing to show </h1>");
}
%>
</body>
</html>
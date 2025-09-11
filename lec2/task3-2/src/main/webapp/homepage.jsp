<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.util.*" %>

<%
    String favPlace = request.getParameter("favPlace");

    if (favPlace != null) {
        Cookie cookie = new Cookie("favPlace", favPlace);
        cookie.setMaxAge(30*24*60*60);
        response.addCookie(cookie);
    }

    String favPlaces = "No Favourite Places Found";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if (c.getName().equals("favPlace")) {
            	favPlaces = c.getValue();
                break;
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Home Page</title>
</head>
<body>
        <p>Your favorite place is: <b><%= favPlaces %></b></p>
</body>
</html>

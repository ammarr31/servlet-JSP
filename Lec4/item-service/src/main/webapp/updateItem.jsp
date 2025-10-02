<%@page import="com.item.model.User"%>
<%@page import="com.item.model.Item"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Item</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 40px;
        }

        .container {
            max-width: 500px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #333;
        }

        input {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 15px;
            transition: 0.2s;
        }

        input:focus {
            border-color: #27ae60;
            outline: none;
            box-shadow: 0 0 5px rgba(39,174,96,0.3);
        }

        .btn {
            display: block;
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            background: #7131ad;
            color: #fff;
            transition: 0.3s;
        }

        .btn:hover {
            background: #1e8449;
        }
    </style>
</head>
<%
 Item item = (Item) request.getAttribute("item");
%>
<body>
<%
    session = request.getSession(false);
    String username = null;

    if (session != null && session.getAttribute("loggedUser") != null) {
        username = ((User) session.getAttribute("loggedUser")).getUsername();
    } else {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("userLogin".equals(c.getName())) {
                    username = c.getValue();
                    break;
                }
            }
        }

        if (username != null) {
            session = request.getSession();
            User tempUser = new User();
            tempUser.setUsername(username);
            session.setAttribute("loggedUser", tempUser);
        }
    }

    if (username == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<div class="container">
    <h1>Update Item</h1>
    <form action="/item-service/ItemController?action=update-item" method="post">
        <input type="hidden" name="id" value="<%= item.getId() %>">
		
		<label for="name">Item Name</label>
		<input type="text" name="name" id="name" value="<%= item.getName() %>" >
		
		<label for="price">Price ($)</label>
		<input type="number" name="price" id="price" step="0.01" value="<%= item.getPrice() %>" >
		
		<label for="total_number">Total Number</label>
		<input type="number" name="total_number" id="total_number" value="<%= item.getTotalNumber() %>" >

        <button type="submit" class="btn">Update Item</button>
    </form>
</div>
</body>
</html>

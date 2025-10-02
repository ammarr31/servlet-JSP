<%@page import="com.item.model.ItemDetails"%>
<%@page import="com.item.model.User"%>
<%@page import="com.item.model.Item"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Items Management</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 40px;
            color: #333;
        }
        .container { width: 90%; margin: auto; }
        h1 { text-align: center; margin-bottom: 20px; font-size: 2rem; color: #2c3e50; }
        .actions { display: flex; justify-content: center; gap: 15px; margin-bottom: 15px; }
        .btn { padding: 8px 14px; border: none; border-radius: 6px; cursor: pointer; font-weight: 600; font-size: 14px; transition: 0.3s; text-decoration:none; color:#fff; }
        .btn-add { background: #7131ad; }
        .btn-add:hover { background: #2980b9; }
        .btn-delete { background: #c0392b; }
        .btn-show { background: #3498db; } 
        .btn-show:hover { background: #2980b9; }
        .btn-edit { background: #1e8449; width: 70px; height: 28px; }
        table { width: 100%; border-collapse: collapse; background: #fff; border-radius: 12px; overflow: hidden; box-shadow: 0 6px 20px rgba(0,0,0,0.1); }
        thead { background-color: #7131ad; color: #eee; height: 50px; }
        thead th { padding: 14px; text-transform: uppercase; font-size: 13px; letter-spacing: 1px; }
        tbody tr { background-color: #eee; color: #000; height: 50px; }
        tbody tr:hover { background: #f0f6ff; }
        td { padding: 14px; text-align: center; font-size: 15px; }
        td:last-child { display: flex; justify-content: center; gap: 10px; }
    </style>
</head>
<body>
<div class="container">
    <h1>Items Management</h1>

    <div class="actions">
        <a href="addItem.jsp" class="btn btn-add">+ Add Item</a>
        <a href="/item-service/ItemDetailsController?action=show-details" class="btn btn-show">Show Details</a>
        <a href="UserController?action=delete-account" class="btn btn-delete">Delete Account</a>
    </div>

    <%
        List<Item> items = (List<Item>) request.getAttribute("items");
        List<ItemDetails> details = (List<ItemDetails>) request.getAttribute("details");
    %>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Price ($)</th>
            <th>Total Number</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
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
        
        <%
            if (items != null && !items.isEmpty()) {
                for (Item item : items) {
        %>
                    <tr>
                        <td><strong><%= item.getId() %></strong></td>
                        <td><%= item.getName() %></td>
                        <td>$<%= item.getPrice() %></td>
                        <td><%= item.getTotalNumber() %></td>
                        <td>
                            <a class="btn btn-edit" href="/item-service/ItemController?action=show-item&id=<%= item.getId() %>">Edit</a>
                            <a class="btn btn-delete" href="/item-service/ItemController?action=delete-item&id=<%= item.getId() %>">Delete</a>
                            <a class="btn btn-add" href="/item-service/addItemDetails.jsp?item_id=<%= item.getId() %>">Add Details</a>
                            <a class="btn btn-delete" href="/item-service/ItemDetailsController?action=delete-details&item_id=<%= item.getId() %>">Delete Details</a>
                        </td>
                    </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="5" style="text-align:center;"><h3>No data found</h3></td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>

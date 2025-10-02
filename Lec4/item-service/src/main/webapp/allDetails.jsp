<%@page import="com.item.model.ItemDetails"%>
<%@page import="com.item.model.User"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>All Item Details</title>
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
        .actions { display: flex; justify-content: flex-start; margin-bottom: 15px; }
        .btn { padding: 8px 14px; border: none; border-radius: 6px; cursor: pointer; font-weight: 600; font-size: 14px; transition: 0.3s; text-decoration:none; color:#fff; }
        .btn-back { background: #3498db; }
        .btn-back:hover { background: #2980b9; }
        table { width: 100%; border-collapse: collapse; background: #fff; border-radius: 12px; overflow: hidden; box-shadow: 0 6px 20px rgba(0,0,0,0.1); }
        thead { background-color: #7131ad; color: #eee; height: 50px; }
        thead th { padding: 14px; text-transform: uppercase; font-size: 13px; letter-spacing: 1px; }
        tbody tr { background-color: #eee; color: #000; height: 50px; }
        tbody tr:hover { background: #f0f6ff; }
        td { padding: 14px; text-align: center; font-size: 15px; }
    </style>
</head>
<body>
<div class="container">
    <h1>All Item Details</h1>

    <!-- زر رجوع -->
    <div class="actions">
        <a href="/item-service/ItemController?action=show-items" class="btn btn-back">← Back</a>
    </div>

    <%
        List<ItemDetails> details = (List<ItemDetails>) request.getAttribute("details");

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

    <table>
        <thead>
        <tr>
            <th>Item ID</th>
            <th>Name</th>
            <th>Price ($)</th>
            <th>Total Number</th>
            <th>Model</th>
            <th>Issued By</th>
            <th>Expiry Date</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (details != null && !details.isEmpty()) {
                for (ItemDetails detail : details) {
        %>
                    <tr>
                        <td><%= detail.getItemId() %></td>
                        <td><%= detail.getName() %></td>
                        <td>$<%= detail.getPrice() %></td>
                        <td><%= detail.getTotalNumber() %></td>
                        <td><%= detail.getModel() %></td>
                        <td><%= detail.getIssuedBy() %></td>
                        <td><%= detail.getExpiryDate() != null ? detail.getExpiryDate() : "N/A" %></td>
                    </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="7" style="text-align:center;"><h3>No details found</h3></td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>

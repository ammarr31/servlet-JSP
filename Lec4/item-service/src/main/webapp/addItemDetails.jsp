<%@page import="com.item.service.UserService"%>
<%@page import="com.item.model.User"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Item Details</title>
    <style>
        body { font-family: 'Poppins', sans-serif; background: #f4f6f9; margin: 0; padding: 40px; }
        .container { max-width: 500px; margin: auto; background: #fff; padding: 30px; border-radius: 12px; box-shadow: 0 6px 20px rgba(0,0,0,0.1);}
        h1 { text-align: center; color: #2c3e50; margin-bottom: 25px;}
        label { display: block; margin-bottom: 6px; font-weight: 600; color: #333;}
        input { width: 100%; padding: 10px 12px; margin-bottom: 20px; border: 1px solid #ddd; border-radius: 8px; font-size: 15px;}
        input:focus { border-color: #3498db; outline: none; box-shadow: 0 0 5px rgba(52,152,219,0.3);}
        .btn { display: block; width: 100%; padding: 12px; border: none; border-radius: 8px; font-weight: 600; font-size: 15px; cursor: pointer; background: #7131ad; color: #fff; transition: 0.3s; }
        .btn:hover { background: #2980b9; }
    </style>
</head>
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
    <h1>Add Item Details</h1>
    <form action="/item-service//ItemDetailsController?action=add-details" method="post">
        <input type="hidden" name="action" value="add-details">
        <input type="hidden" name="item_id" value="<%= request.getParameter("item_id") %>">

        <label for="model">Model</label>
        <input type="text" name="model" id="model" required>

        <label for="issued_by">Issued By</label>
        <input type="text" name="issued_by" id="issued_by" required>

        <label for="expiry_date">Expiry Date</label>
        <input type="date" name="expiry_date" id="expiry_date" required>

        <button type="submit" class="btn">Add Details</button>
    </form>

</div>
</body>
</html>

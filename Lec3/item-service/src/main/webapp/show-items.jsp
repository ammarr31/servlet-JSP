<%@page import="com.item.model.Item"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Items Table</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 40px;
            color: #333;
        }

        .container {
            width: 90%;
            margin: auto;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 2rem;
            color: #2c3e50;
        }

        .actions {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 15px;
        }

        .btn {
            padding: 8px 14px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            transition: 0.3s;
        }

        .btn-add {
            background: #3498db;
            color: #fff;
            text-decoration: none;
        }

        .btn-add:hover {
            background: #2980b9;
        }

        .btn-edit {
            background: #27ae60;
            color: #fff;
            text-decoration: none;
        }

        .btn-edit:hover {
            background: #1e8449;
        }

        .btn-delete {
            background: #e74c3c;
            color: #fff;
            text-decoration: none;
        }

        .btn-delete:hover {
            background: #c0392b;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }

        thead {
            background: #3498db;
            color: #fff;
        }

        thead th {
            padding: 14px;
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 1px;
        }

        tbody tr {
            border-bottom: 1px solid #ddd;
            transition: background 0.2s ease;
        }

        tbody tr:hover {
            background: #f0f6ff;
        }

        td {
            padding: 14px;
            text-align: center;
            font-size: 15px;
        }

        td:last-child {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Items Management</h1>

    <div class="actions">
        <a href="addItem.jsp" class="btn btn-add">+ Add Item</a>
    </div>
	<%
	List<Item> items = (List<Item>) request.getAttribute("items");
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
		if (items != null && !items.isEmpty()) {
		    for (Item item: items) {
		%>
		        <tr>
		            <td><strong><%=item.getId() %></strong></td>
		            <td><%=item.getName() %></td>
		            <td>$<%=item.getPrice() %></td>
		            <td><%=item.getTotalNumber() %></td>
		            <td>
		                <a href="/item-service/ItemController?action=show-item&id=<%=item.getId() %>">Edit</a>
		                <a href="/item-service/ItemController?action=delete-item&id=<%=item.getId() %>">Delete</a>
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

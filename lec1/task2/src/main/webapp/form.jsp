<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Form Page</title>
</head>
<body>

<form action="result.jsp" method="post">
	<label>full name :</label>
    <input type="text" name="fullName"><br><br>
	<label>password :</label>
	<input type="password" name="password"><br><br>
	<label>age :</label>	
    <input type="text" name="age"><br><br>
	<label>address :</label>	
    <br>
    <input type="radio" name="address" value="cairo"> cairo <br>
    <input type="radio" name="address" value="alex"> alex <br>
    <input type="radio" name="address" value="menofia"> menofia <br><br>
	<label>address :</label>	
    <br>
    <select name="addresss">
        <option value="cairo">cairo</option>
        <option value="alex">alex</option>
        <option value="menofia">menofia</option>
    </select>
    <br><br>

    <input type="submit" value="Submit">
</form>

</body>
</html>

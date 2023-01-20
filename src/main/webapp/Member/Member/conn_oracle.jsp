<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Oracle DB Connection file</title>
</head>
<body>

	<%
		Connection conn = null;
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		
	try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url, "C##HR3", "1234");
	}catch (Exception e){
		e.printStackTrace();
	}
	
	
	
	%>



</body>
</html>
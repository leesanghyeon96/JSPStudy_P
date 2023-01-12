<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>	<!-- java의 라이브러리 임포트 -->


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Oracle DB Connection</title>
</head>
<body>

	<%
		//변수 초기화		// : JSP블락 내에서의 주석
		Connection conn = null;	//connection객체는 null
		String driver = "oracle.jdbc.driver.OracleDriver";//Oracle.jdbc.driver : 패키지명(소문자) , OracleDriver : 클래스(대문자)
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		
		try{
			//Oracle.jdbc.driver.OracleDriver에 driver있는지
			Class.forName(driver);	//오라클 드라이버를 로드함 , dirver가없으면 오류가발생(try~catch로 묶어야함)
			conn = DriverManager.getConnection (url, "C##HR3", "1234");
					
		}catch (Exception e){
			e.printStackTrace();
		}
	%>


</body>
</html>
<!-- 회원의 정보를 DB에 저장시키는 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 라이브러리 임포트 -->
<%@ page import = "java.sql.*, java.util.*, java.text.*" %>    
<%@ include file = "conn_oracle.jsp" %>
<% request.setCharacterEncoding("UTF-8"); %>  

<%
// save jsp파일 입력방법
//1. insert에서 넘어오는 변수를 재할당
	int idx = 0;
	String id = request.getParameter("id");
	String pw = request.getParameter("pass");
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String ci = request.getParameter("city");
	String ph = request.getParameter("phone");
	

	// 하나 기본값 할당있음
	
//2. DB에 처리할 변수 선언
	String sql = null;
	Statement stmt = null;
	ResultSet rs = null;
	
//3. try ~ catch ~ finally로 sql 쿼리를 만들어 DB에 값을 넣기
	try{
		// DB에서 값을 처리하기
		stmt = conn.createStatement();
		sql = "select max(idx) from mytbl";
		rs = stmt.executeQuery(sql);
		
		if(!(rs.next())){
			idx = 1;
		}else{
			idx = rs.getInt(1) + 1;
		}
		
		// DB에 저장시킬 sql쿼리 작성
		sql = "insert into myTbl (idx, id, pass, name, email, city, phone) ";
		sql += "values ('" + idx + "', '"+ id + "', '" + pw + "', '" + na + "', '" + em + "', '" + ci + "', '" + ph + "')";
		
		// stmt.executeQuery(sql); 도 가능함.
		stmt.executeUpdate(sql);
		
		/*
		out.println(sql);
		if(true) return;
		*/
		
	}catch (Exception e){
		out.println("오류가 발생했습니다. 확인해주세요.");
		e.printStackTrace();
	}finally{
		// 변수닫기
		if(conn != null) {conn.close();}
		if(rs != null) {rs.close();}
		if(stmt != null) {rs.close();}
	}
	%>
		
<!-- 4. insert후 페이지 이동 -->
<jsp:forward page="list01.jsp" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
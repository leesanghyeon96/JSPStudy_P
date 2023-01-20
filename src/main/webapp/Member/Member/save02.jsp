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
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
//3. try ~ catch ~ finally로 sql 쿼리를 만들어 DB에 값을 넣기
	try{
		// DB에서 값을 처리하기
		sql = "select max(idx) from mytbl";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery(sql);
		
		if(!(rs.next())){
			idx = 1;
		}else{
			idx = rs.getInt(1) + 1;
		}
		/*
		out.println(idx);
		if(true) return;
		*/
		// DB에 저장시킬 sql쿼리 작성
		sql = "insert into mytbl (idx, id, pass, name, email, city, phone) values (?,?,?,?,?,?,?)";
		
		pstmt = conn.prepareStatement(sql);		
		pstmt.setInt(1, idx);
		pstmt.setString(2, id);
		pstmt.setString(3, pw);
		pstmt.setString(4, na);
		pstmt.setString(5, em);
		pstmt.setString(6, ci);
		pstmt.setString(7, ph);
		
		pstmt.executeUpdate();
		
		
		
	}catch (Exception e){
		out.println("오류가 발생했습니다. 확인해주세요.");
		//e.printStackTrace();
	}finally{
		// 변수닫기
		if(conn != null) {conn.close();}
		if(rs != null) {rs.close();}
		if(pstmt != null) {pstmt.close();}
	}
	%>
		
<!-- 4. insert후 페이지 이동 -->
<jsp:forward page="list02.jsp" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
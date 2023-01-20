<!-- 수정입력값의 확인처리 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<%@ include file="conn_oracle.jsp" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%

	// 넘어오는 idx와 page의 값 할당
	int idx = Integer.parseInt(request.getParameter("idx"));
	String p = request.getParameter("page");
	/*
	out.println(idx);
	out.println(p);
	if(true) return;
	*/
	// 수정 페이지의 폼에서 넘어오는 변수를 재할당
	//아이디 비밀번호 이름 도시 폰
	String pa = request.getParameter("pass");
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String ci = request.getParameter("city");
	String ph = request.getParameter("phone");
	/*
	out.println(pa);
	out.println(na);
	out.println(em);
	out.println(ci);
	out.println(ph);
	if(true) return;
	*/
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
[<a href = "list02.jsp?go=<%= p %>">게시판 목록으로</a>]

<%
	String sql = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	try{
//DB에서 해당 id에 대한 password를 가져와서 폼에서 전송된 password와 확인		
		sql = "select * from mytbl where idx = " + idx;
		pstmt = conn.prepareStatement(sql);
		rs=pstmt.executeQuery(sql);
		
		if(!(rs.next())){
			out.println("DB에 값이 없습니다.");
		}else{
			String pass = rs.getString("pass");
			// pa = form 에서 가져오는 패스워드
			// pass = DB 에서 가져오는 패스워드
			
			if(pass.equals(pa)){
				sql = "update mytbl set name = ?, email = ?, city = ?, phone = ? where idx = ?";
				
				pstmt.setString(1, na);
				pstmt.setString(2, em);
				pstmt.setString(3, ci);
				pstmt.setString(4, ph);
				pstmt.setInt(5, idx);
				
				pstmt.executeUpdate();
				
				/*
				out.println(sql);
				if(true) return;
				*/
				out.println("내용 수정 완료");
			}else{
				out.println("<p/> 패스워드가 일치하지 않습니다.");
			}
		}

	}catch (Exception e){
		out.println("DB저장시 오류가 발생되었습니다.");
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(pstmt != null) pstmt.close();
		if(rs != null) rs.close();
	}


%>


</body>
</html>
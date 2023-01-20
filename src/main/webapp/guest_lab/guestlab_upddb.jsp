<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %> 
<%@ include file="conn_oracle.jsp" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
	// idx, page값 가져오기
	int idx = Integer.parseInt(request.getParameter("idx"));
	String p = request.getParameter("page");
	
	// 폼에서 수정되어 넘어오는 변수의 값을 재할당
	String i = request.getParameter("idx");
	String em = request.getParameter("email");
	String gen = request.getParameter("gender");
	String addr = request.getParameter("addr");
	String ph = request.getParameter("phone");

	/*
	out.println(idx + "<p/>");
	out.println(p + "<p/>");
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

[<a href = "guestlab_list.jsp?go=<%= p %>">게시판 목록으로</a>]

	<%
	String sql = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
	
	//DB에서 해당 id에 대한 password를 가져와서 폼에서 전송된 password와 확인
	sql = "select * from guestlab where idx = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, idx);
	rs = pstmt.executeQuery();
	
	//rs는 DB에서 password 필드의 값을 가져와서 폼에서 넘겨받은 password와 비교후 같으면 Update
	if(!(rs.next())){	//rs의 값이 존재하지 않을떄
		out.println("DB에 해당하는 내용이 없습니다.");
	}else{	//rs의 값에 존재할때
		String pho = rs.getString("phone");	//DB에서 가져온 phone

	
			/*
			out.println("<p/>" + ph + "<p/>");
			out.println(pho + "<p/>");
			out.println(ph.equals(pho));	//두 값이 같으면 true, 다르면 false
			
			if(true) return;	
			*/
			if(pho.equals(ph)){
				//update 진행
				sql = "update guestlab set phone=?, email=?,";
				sql += " gender=?, addr=? where idx =?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, ph);
				pstmt.setString(2, em);
				pstmt.setString(3, gen);
				pstmt.setString(4, addr);
				pstmt.setString(5, i);
				
				pstmt.executeUpdate();
				
				out.println("내용이 잘 수정되었습니다.");
				
			}else{
				//패스워드가 다릅니다. 출력
				out.println("<p/> 패스워드가 일치하지 않습니다.");
			}
	}
	
	} catch (Exception e){
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>    
<% request.setCharacterEncoding("UTF-8"); %>
<%@ include file="conn_oracle.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

[<a href="guestlab_list.jsp?go=<%= request.getParameter("page") %>"> 게시판으로 이동 </a>]

<%
//DB 접속하는 객체 선언
String sql = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

//id와 page는 del.jsp에서 받아오는 변수 (read->del->deldb)
String idx = request.getParameter("idx");
int page1 = Integer.parseInt(request.getParameter("page"));
//폼에서 넘겨진 password
String ph = request.getParameter("phone");

/*
out.println (idx + "<p/>");
out.println (page1 + "<p/>");
out.println (ph + "<p/>");
if (true) return;	// 프로그램 종료
*/


try{
	sql = "select * from guestlab where idx = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, idx);		// id는 form에서 넘겨 여기까지 온 id
	rs=pstmt.executeQuery();	//sql에서 selet한 결과값을 rs에 담는다.

	if(!rs.next()){ 	// rs의 값이 비어있을때
		out.println("해당 값이 존재하지 않습니다.");
	}else{
		//pho : DB에서 가져온 phone
		String pho = rs.getString("phone");
		
		if(ph.equals(pho)){
			// 같다면 delete쿼리를 적용
			sql = "delete guestlab where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, idx);
			pstmt.executeUpdate();	
			
			// 위 쿼리가 잘 실행되면 아래 코드가 실행, 오류가 나면 catch블락으로 떨어짐
			out.println("잘 삭제 되었습니다.");
		}else{
			//다를때
			out.println("패스워드가 다릅니다.");
		}
		
		
	}
	
}catch (Exception e){
	e.printStackTrace();
}finally{
	if(conn != null){conn.close();}
	if(pstmt != null){pstmt.close();}
	if(rs != null){rs.close();}
}



%>



</body>
</html>
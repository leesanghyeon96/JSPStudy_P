<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ include file = "conn_oracle.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
[<a href="list02.jsp?go=<%= request.getParameter("page") %>"> 게시판으로 이동 </a>]

<%
//DB 접속 객체 선언
String sql = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

int idx = Integer.parseInt(request.getParameter("idx"));
String p = request.getParameter("page");

// form 에서 넘겨준 pass 
String pa = request.getParameter("pass");

try{
	sql = "select * from mytbl where idx = " + idx;
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery(sql);
	
	if(!rs.next()){
		out.println("DB에 해당값이 존재하지 않습니다.");
	}else{
		//pa : form에서 넘겨준 패스워드
		//pass : DB에서 넘어온 패스워드
		String pass = rs.getString("pass");
		
		if(pass.equals(pa)){
			sql = "delete mytbl where idx = " + idx;
			pstmt.executeUpdate();
			
			out.println("삭제가 되었습니다.");
		}else{
			out.println("패스워드가 다릅니다.");
		}
		
		
	}
	
	
}catch (Exception e){
	out.println("오류가 발생했습니다");
	e.printStackTrace();
}finally{
	if(conn!=null){conn.close();}
	if(pstmt!=null){pstmt.close();}
	if(rs!=null){rs.close();}
}


%>



</body>
</html>
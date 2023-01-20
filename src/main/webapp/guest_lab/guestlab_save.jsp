<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*,java.util.*" %>

<% request.setCharacterEncoding("UTF-8"); %>
    
<%@ include file="conn_oracle.jsp" %>

<% 
String idx = request.getParameter("idx");
String en = request.getParameter("ename");
String ph = request.getParameter("phone");
String ge = request.getParameter("gender");
String ad = request.getParameter("addr");  
%>

<% 
out.println("idx에 담긴 값 : " + idx);
  
%>

<% 
String sql = null;
Statement stmt = null;



stmt = conn.createStatement();



sql = "insert into guestlab (idx, ename, phone, gender, addr) ";
sql = sql + "values ('" + idx +"', '" + en + "', '" + ph + "', '" + ge + "', '" + ad + "')";
   
    
   
int cnt = 0;

cnt = stmt.executeUpdate(sql);
   
if(cnt>0){
	out.println("DB에 잘 삽입되었습니다.");
}else{
	out.println("DB에 값이 입력되지 않았습니다.");
}
    
%>    
    
<jsp:forward page="guestlab_list.jsp" />
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
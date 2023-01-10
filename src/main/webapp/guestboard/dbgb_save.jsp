<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 사용할 클래스를 해당 패키지에서 import -->
<%@ page import="java.sql.*,java.util.*" %>

<!-- 클라이언트에서 유니코드를 UTF-8로 처리해야함 (MVC Model1) , 그래야 깨지지않음 -->
<!-- JSP에서 내장 객체 : Import없이 사용가능한 객체 (7가지)
	 request 객체 : 클라이언트에서 넘겨주는 정보를 서버에서 받아서 처리,
	 response 객체 : 서버에서 클라이언트에게 정보를 처리하는 객체 
	 -->

<% request.setCharacterEncoding("UTF-8"); %>


<!-- DB를 접속하는 파일을 Include 해서 사용 -->
<!-- include하는 파일은 .jsp 이어야 하고 들어오는 파일은 .html이어도 상관없다. -->
<%@ include file="conn_oracle.jsp" %>

<!-- 폼에서 넘겨주는 변수와 값을 받아서 저장 : request.getParameter("변수명"); -->
<%
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String sub = request.getParameter("subject");
	String cont = request.getParameter("content");
	String ymd = (new java.util.Date()).toLocaleString();

%>

<!-- 폼에서 넘긴 변수를 출력 후 주석처리 -->
<%
	//out.println("na 변수의 담긴 값 : " + na + "<p/>");
	//out.println("em 변수의 담긴 값 : " + em + "<p/>");
	//out.println("sub 변수의 담긴 값 : " + sub + "<p/>");
	//out.println("cont 변수의 담긴 값 : " + cont + "<p/>");
	//out.println("ymd 변수에 담긴 값 : " + ymd + "<p/>");
%>
<%= "na 변수에 담신 값 : " + na + "<p/>" %>

<!-- 변수에 넘어오는 값을 SQL 쿼리에 담아서 DB에 저장 -->
<%
	String sql = null;	//sql <== SQL 쿼리를 담는 변수
	Statement stmt = null;	//SQL 쿼리를 DB에 적용하는 객체 , 
	
	// Connection 객체의 conn.createStatement() 메소드를 써서 stmt 객체에 할당.
	stmt = conn.createStatement();	//conn = <%@ include file="conn_oracle.jsp" 
	
	//guestboard에 변수값 넣기 (DB에 쿼리를 시험해봐서 잘 들어가면 그것을 가져와 붙여넣고 후처리를 한다.)
	sql = "insert into guestboard(name, email, inputdate, subject, content) ";//<=공백있어야함 *주의*
	sql = sql + "values ('" + na + "','" + em + "','" + ymd + "','" + sub + "','" + cont + "')";
	
	//변수처리와 공백등 오류가 없게 잘 출력되어야 한다.
	//out.println(sql);
	
	int cnt = 0;	//sql 쿼리가 잘 처리되었는지 확인하는 변수
	
	//statement객체가 sql 쿼리를 실행해서 DB에 저장  , 
	cnt = stmt.executeUpdate(sql);	//Statement 객체의 executeUpdate(sql) :insert, update, delete
	//cnt = stmt.executeUpdate(sql); 에 잘 들어가면 1로 리턴을 돌려줌
	
	//stmt.executeQuery(sql);		//Statement 객체의 executeQuery(sql) : select
									//Recordset 객체로 리턴을 시켜줌 : select한 결과를 담은 객체 
	
	// Statement 객체느 PreparedStatement 객체를 사용해서 Insert/Update/Delete
		// 저장할 경우 자동으로 commit이 처리됨

	out.println(cnt);
	
	if(cnt>0){
		out.println("DB에 잘 insert 되었습니다.");
	}else{
		out.println("DB에 저장을 실패했습니다.");
	}
	
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기의 폼의 변수의 값을 받아서 DB에 저장후 보기 페이지로 이동</title>
</head>
<body>
	
</body>
</html>
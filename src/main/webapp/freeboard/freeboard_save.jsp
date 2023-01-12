<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 필요한 라이브러리 Import -->    
<%@ page import = "java.util.*,java.sql.*,java.text.*" %>
<!-- DB include -->
<%@ include file = "conn_oracle.jsp" %>	
<!-- form에서 넘어오는 값의 한글처리 -->
<% request.setCharacterEncoding("UTF-8"); %>

<!-- form에서 넘어오는 데이터는 전부 String형식이다.
	** 그래서 값을 변환시켜야한다.
	Integer.parseInt()
	Double.parseDouble()
 -->

<!-- form에서 넘어오는 변수의 값을 받아서 새로운 변수에 할당 -->
<%
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String sub = request.getParameter("subject");
	String cont = request.getParameter("content");
	String pw = request.getParameter("password");
	
	int id = 1;		// id에 처음 값을 할당할때 기본값으로 1을 할당.
					// 다음부터는 테이블의 id컬럼에서 Max값을 가져와서 +1해서 처리
	
	//날짜 처리
	// java.util.Date : 선언자 yymmdd : 변수
	java.util.Date yymmdd = new java.util.Date();
	//out.println(yymmdd);	// Thu Jan 12 11:16:19 KST 2023
	SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:m a");	//a : 오전, 오후
	String ymd = myformat.format(yymmdd);	//yymmdd의 형식이 myformat의 "yy-MM-d h:m a"형식으로 출력(ymd)
	out.println(ymd);		// 23-01-12 11:15 오전
	
	//DB에 값을 처리할 변수 선언 : Connection (conn) <== Include
	String sql = null;
	Statement stmt = null;
	ResultSet rs = null;		// id 컬럼의 최대값을 select
	
	// Try ~ catch로 오류처리
	try{
	//DB에서 값을 처리
	stmt = conn.createStatement();
	sql = "select max(id) from freeboard";	//id : Primary Key
	
	rs = stmt.executeQuery(sql);
	
	//rs.next();	
	//out.println(rs.getInt(1) + "<p/>");	// 디버깅
					
	//if(true) return;
	
	
	// 테이블의 id 컬럼의 값을 적용 : 최대값을 가져와서 +1
	if(!(rs.next())){	// !(rs.next()) : DB에 값이 없는 경우
		id = 1;
	}else{				// 테이블에 값이 존재하는 경우
		// 테이블에서 max(id)로 가져와서 getString이 안된다.
		// 테이블의 컬럼이름 변경을 해도 안된다.(as id = X)
		id = rs.getInt(1) + 1;	// getString : 컬럼을 가져온다. , getInt : 테이블의 값을 가져온다. 첫번쨰가 1부터 시작
	}
	//아래는 위의 if와 안의 구문이 반대 : 출력값은 같다.
	/*
	if (rs.next()){		// 테이블의 값이 존재하는 경우
		id = rs.getInt(1) + 1;
	}else{				// 테이블의 값이 존재하지 않는 경우
		id = 1 ;
	}
	*/
	
	//Statement 객체는 변수값 처리가 복잡하다. PreparedStatement 를 사용한다.
	// 폼에서 넘겨받은 값을 DB에 insert하는 쿼리 (주의 : masterid : id컬럼에 들어오는 값으로 처리해야함)
	sql = "insert into freeboard (id, name, password, email, ";
	sql += "subject, content, inputdate, masterid, readcount, replynum, step) ";
	sql = sql + "values (" + id + ", '" + na + "', '" + pw + "', '" + em + "', '" + sub + "', '" + cont + "', ";
	sql = sql + "'" + ymd + "', " + id + "," + "0 , 0 , 0)";
	
	// DB에서 insert를 직접하면 commit을 시켜야한다.
	//out.println(sql);
	//if(true) return;		// 프로그램을 중지 시킴. 디버깅할때 사용함.
	
	stmt.executeUpdate(sql);	//DB 저장완료, commit을 자동완료시킴
	// id와 masterid의 값이 같아야 답변이 가능하다.
	
	
	// Try ~ catch 블락으로 프로그램이 종료되지 않도록 처리후 객체 제거
	}catch (Exception e){
		out.println("예상치못한 오류가 발생했습니다. <p/>");
		out.println("고객센터 : 02-1111-1111 <p/>");
		//e.printStackTrace();	<= 개발자가 디버깅을 위해 보는 것
	}finally{	// finally로 객체 제거
		if(conn != null) {conn.close();}
		if(stmt != null) {stmt.close();}
		if(rs != null) {rs.close();}
	}
	
%>
<!-- 
	insert 후 페이지 이동 
		response.sendRedirect : 클라이언트에서 페이지를 재요청 : URL 주소가 바뀜
		forward : 서버에서 페이지를 이동 : URL 주소가 바뀌지 않음
-->
<!-- 방법1 -->
<% //response.sendRedirect("freeboard_list.jsp"); %>
<!-- 방법2 -->

<jsp:forward page = "freeboard_list.jsp" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
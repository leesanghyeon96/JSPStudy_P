<!-- 내용을 수정하기 위한 페이지 처리 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<%@ include file="conn_oracle.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update 를 통한 데이터 수정 </title>
</head>
<body>
	<%
	// 넘어오는 idx와 page의 값 할당
	int idx = Integer.parseInt(request.getParameter("idx"));
	String p = request.getParameter("page");
	
	// DB기본 변수
	String sql = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	// try ~ catch 로 묶기 시작
	try{
		sql = "select * from mytbl where idx = " + idx;
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);

		if(!(rs.next())){
			out.println("DB에 값이 없습니다.");
		}else{
	%>
	<script>
	 function check(){
		 with(document.form1){
			 if(pass).value.length==0){
				 alert("비밀번호를 입력해주세요");
				 pass.focus();
				 return false;
			 }
			 if(name.value.length==0){
				 alert("이름를 입력해주세요");
				 name.focus();
				 return false;
			 }
			 if(email.value.length==0){
				 alert("이메일을 입력해주세요");
				 email.focus();
				 return false;
			 }
			 if(city.value.length==0){
				 alert("사는곳을 입력해주세요");
				 city.focus();
				 return false;
			 }
			 if(phone.value.length==0){
				 alert("전화번호를 입력해주세요");
				 phone.focus();
				 return false;
			 }
			 document.form1.submit();
		 }
	 }
	
	</script>
	
	
	<form class="form1" method = "post" action = "update01_process.jsp"> 
		<input type="hidden" name="idx" value="<%= idx %>">
		<input type="hidden" name="page" value="<%= p %>">
		<p> 패스워드 : <input type = "pass" name = "pass"> 
		<p> 이름 : <input type = "text" name = "name"> 
		<p> 이메일 : <input type = "text" name = "email">
		<p> city : <input type = "text" name = "city">
		<p> phone : <input type = "text" name = "phone">
		<p> <input type = "submit" value = "전송" onclick="check();"> 
		패스워드를 정확히 입력해야만 수정이 가능합니다.
	</form>
	
	<%
		}
	}catch (Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(stmt != null) stmt.close();
		if(rs != null) rs.close();
	}
	%>
	
</body>
</html>
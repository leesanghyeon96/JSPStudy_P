<!-- 회원의 정보를 입력하는 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function check(){
		with(document.mwrite){
			if(idx.value.length==0){
				alert("번호를 입력해주세요.");
				idx.focus();
				return false;
			}
			if(id.value.length==0){
				alert("아이디를 입력해주세요.");
				id.focus();
				return false;
			}
			if(password.value.length==0){
				alert("비밀번호를 입력해주세요.");
				password.focus();
				return false;
			}
			if(name.value.length==0){
				alert("이름를 입력해주세요.");
				name.focus();
				return false;
			}
			if(email.value.length==0){
				alert("이메일을 입력해주세요.");
				email.focus();
				return false;
			}
			document.mwrite.submit();
		}
	}

</script>
</head>
<body>
<div> * 표시는 반드시 입력해주세요.</div>
	<form name="mwrite" method = "post" action = "save01.jsp"> 
		<p> *번호 : <input type = "text" name = "idx">
		<p> *아이디 : <input type = "text" name = "id">
		<p> *패스워드 : <input type = "pass" name = "pass"> 
		<p> *이름 : <input type = "text" name = "name"> 
		<p> *이메일 : <input type = "text" name = "email">
		<p> 사는곳 : <input type = "text" name = "city">
		<p> 전화번호 : <input type = "text" name = "phone">
		<p> <input type = "submit" value = "전송" onclick="check();">
		<!-- <a href="#" onClick="check();">전송</a> -->
	</form>

</body>
</html>


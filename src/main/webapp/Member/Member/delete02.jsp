<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function check(){
		with(document.form1){
			if(pass.value.length==0){
				alert("패스워드를 입력해주세요.");
				pass.focus();
				return false;
			}
			document.form1.submit();
		}
	}
</script>
</head>
<body>
	<form class="form1" method = "post" action = "delete02_process.jsp"> 
		<input type="hidden" name="idx" value="<%= request.getParameter("idx") %>">
		<input type="hidden" name="page" value="<%= request.getParameter("page") %>">
		<p> 패스워드 : <input type = "pass" name = "pass"> 

		<p> <input type = "submit" value = "전송" onclick="check();"> 
		패스워드를 정확히 입력해야만 삭제가 가능합니다.
	</form>

</body>
</html>


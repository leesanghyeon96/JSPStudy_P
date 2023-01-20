<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*, java.util.*" %>
    
<%@ include file = "conn_oracle.jsp" %>   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	div{
		/*border:solid 1px red;
		height:300px;
		*/
		width:600px;
		margin:0 auto;
	}
	table, tr, td{
		padding:5px;
		border-collapse: collapse;
	}
</style>
</head>
<body>
 guestlab_show.jsp (rs에서 값을 가져와서 출력)
<%
// sql쿼리를 담는 변수
String sql = null;
// Statement 의 객체 생성
Statement stmt = null;
// Select한 결과를 담는 객체 생성
ResultSet rs = null;


sql = "select * from guestlab order by idx desc";

// Oracle의 HR3 계정에 연결
stmt=conn.createStatement();

// select한 결과값을 저장할 객체 생성
rs = stmt.executeQuery(sql);


//rs에 담긴 값을 루프를 돌리며 출력
if(rs.next()){
	do{
%>		
	
<div>
	<table>
		<tr>
			<td>번호 : <%= rs.getString("idx") %></td>
		</tr>
		<tr>
			<td>이름 : <%= rs.getString("ename") %></td>
		</tr>
		<tr>
			<td>전화번호 : <%= rs.getString("phone") %></td>
		</tr>
		<tr>
			<td>성별 : <%= rs.getString("gender") %></td>
		</tr>
		<tr>
			<td>주소 : <%= rs.getString("addr") %></td>
		</tr>

	</table>

</div>

<%	
	}while(rs.next());
}else{
	out.println("방명록에 데이터 값이 존재하지 않습니다.");
}


%>	


<div>
	<a href="guestlab_write.jsp">글쓰기</a>
</div>



	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>
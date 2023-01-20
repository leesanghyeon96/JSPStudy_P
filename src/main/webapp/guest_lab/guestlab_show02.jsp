<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, java.util.*" %>    
<%@ include file="conn_oracle.jsp" %>
    
    
    
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
 guestlab_show02.jsp (rs에서 값을 Vector 에 저장 후 출력)

<%
Vector idx = new Vector();
Vector ename = new Vector();
Vector phone = new Vector();
Vector gender = new Vector();
Vector addr = new Vector();

//sql쿼리를 담는 변수
String sql = null;
//Statement 의 객체 생성
Statement stmt = null;
//Select한 결과를 담는 객체 생성
ResultSet rs = null;


sql = "select * from guestlab order by idx desc";

//Oracle의 HR3 계정에 연결
stmt=conn.createStatement();

//select한 결과값을 저장할 객체 생성
rs = stmt.executeQuery(sql);


//루프를 돌며 rs에 담긴 값을 Vector에 저장
if(rs.next()){
	do{
		idx.addElement(rs.getString("idx"));
		ename.addElement(rs.getString("ename"));
		phone.addElement(rs.getString("phone"));
		gender.addElement(rs.getString("gender"));
		addr.addElement(rs.getString("addr"));
	}while(rs.next());
}

// vector에 담긴 값을 출력
for (int i = 0 ; i < idx.size() ; i++){
	
	%>	
	
<div>
	<table>
		<tr>
			<td>번호 : <%= idx.elementAt(i) %></td>
		</tr>
		<tr>
			<td>이름 : <%= ename.elementAt(i) %></td>
		</tr>
		<tr>
			<td>전화번호 : <%= phone.elementAt(i) %></td>
		</tr>
		<tr>
			<td>성별 : <%= gender.elementAt(i) %></td>
		</tr>
		<tr>
			<td>주소 : <%= addr.elementAt(i) %></td>
		</tr>

	</table>

</div>	
	
<% 	
}

%>
<div>
	<a href="guestlab_write.jsp">글쓰기</a>
</div>





</body>
</html>
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
guestlab_show03.jsp (rs의 값을 ArrayList에 저장 후 출력)

<%

ArrayList idx = new ArrayList();
ArrayList ename = new ArrayList();
ArrayList phone = new ArrayList();
ArrayList gender = new ArrayList();
ArrayList addr = new ArrayList();

String sql = null;
Statement stmt = null;
ResultSet rs = null;

sql = "select * from guestlab order by idx desc";

stmt = conn.createStatement();

rs = stmt.executeQuery(sql);

if(rs.next()){
	do {
		idx.add(rs.getString("idx"));
		ename.add(rs.getString("ename"));
		phone.add(rs.getString("phone"));
		gender.add(rs.getString("gender"));
		addr.add(rs.getString("addr"));
		
	}while(rs.next());
}


for (int i = 0 ; i < idx.size() ; i++){

%>

<div>
	<table>
		<tr>
			<td>번호 : <%= idx.get(i) %></td>
		</tr>
		<tr>
			<td>이름 : <%= ename.get(i) %></td>
		</tr>
		<tr>
			<td>전화번호 : <%= phone.get(i) %></td>
		</tr>
		<tr>
			<td>성별 : <%= gender.get(i) %></td>
		</tr>
		<tr>
			<td>주소 : <%= addr.get(i) %></td>
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
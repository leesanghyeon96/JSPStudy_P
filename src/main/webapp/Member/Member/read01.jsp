<!-- 글을 읽는 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, java.util.*, java.text.*" %>
<%@ include file = "conn_oracle.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	// sql 변수 선언
		String sql = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		//get 방식으로 넘김
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		sql = "select * from mytbl where idx = " + idx;
		stmt=conn.createStatement();
		rs=stmt.executeQuery(sql);
		
		
		// if문을 통해 각각의 레코드의 값을 찍어준다.
		if(rs.next()){
%>
	<table width='800' cellspacing='0' cellpadding='2' align='center'>
			   <tr>
			   <td height='22'>&nbsp;</td></tr>
			   <tr align='center'>
			   <td height='1' bgcolor='#1F4F8F'></td>
			   </tr>
			   <tr align='center' bgcolor='#DFEDFF'>
			   <td class='button' bgcolor='#DFEDFF'> 
			   <div align='left'><font size='4'>번호 : <%= rs.getInt("idx") %></div> </td>
			   </tr>
			   <tr align='center' bgcolor='#FFFFFF'>
			   <td align='center' bgcolor='#F4F4F4'>
			   <table width='100%' border='0' cellpadding='0' cellspacing='4' height='1'>
			   <tr bgcolor='#F4F4F4'>
			   <td width='33%' height='7'>ID : <%= rs.getString("id") %></td>
			   <td width='33%' height='7'>비밀번호 : <%= rs.getString("pass") %></td>
			   <td width='33%' height='7'>이름 : <%= rs.getString("name") %></td>
			   </tr>
			   <tr bgcolor='#F4F4F4'>
			   <td width='33%'>email : <%= rs.getString("email") %></td>
			   <td width='33%'>city : <%= rs.getString("city") %></td>
			   <td width='33%'>phone : <%= rs.getString("phone") %></td>
			   </tr>
			   </table>
			   </td>
			   </tr>
	 </table>
	<%	  
		}else{
		out.print("DB에 해당 레코드가 존재하지 않습니다.");
		}
	%>	
	
	<table width="600" border="0" cellpadding="0" cellspacing="5">
	<tr> 
		<td align="right" width="450"><A href="list01.jsp?go=<%= request.getParameter("page")%>">목록</a></td>
		<td width="70" align="right"><A href="rewrite.jsp?idx=<%= request.getParameter("idx") %>&page=<%= request.getParameter("page") %>">답변</A></td>
		<td width="70" align="right"><A href="update01.jsp?idx=<%= idx %>&page=<%= request.getParameter("page")%>">수정</A></td>
		<td width="70" align="right"><A href="delete01.jsp?idx=<%= idx %>&page=<%= request.getParameter("page")%>">삭제</A></td>
	</tr>
  	</table>


</body>
</html>
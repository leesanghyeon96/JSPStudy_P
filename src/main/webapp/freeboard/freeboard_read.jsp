<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "java.sql.*, java.util.*, java.text.*" %>
<%@ include file = "conn_oracle.jsp" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>컬럼의 특정 레코드를 읽는 페이지 </title>
</head>
<body>

	<!-- JSP 코드 블락 -->
	<%
		// SQl 쿼리를 사용할 변수 선언 블락
		String sql = null;
		Statement stmt = null;
		PreparedStatement pstmt = null;		// 변수를 ?로 처리함.
	
		ResultSet rs = null;
	
		// Get 방식으로 넘어오는 변수 값을 저장
		// getParameter는 String 형식으로 모두 넘어온다. : request.getParameter("id") => 정수형 문자열
		// id값을 number로 저장해놨었음(int형) => Integer.parseInt()로 형변환을 시켜야한다.
		// String => int : Integer.parseInt(request.getParameter("id"))
		int id = Integer.parseInt(request.getParameter("id"));
		
		
		/* Statement 객체를 사용해서 처리
		//	select * from freeboard where id = 14; 를 아래 형식으로
		sql = "select * from freeboard where id = " + id;
	
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		*/
		
		// PreparedStatement 객체를 사용해서 처리, 변수에 들어가는 값을 ?로 처리함.
				// 매번컴파일 하지 않기때문에 처리속도가 빠름
		sql = "select * from freeboard where id = ?";
		pstmt = conn.prepareStatement(sql);		//pstmt 객체 생성시 sql 문을 넣는다.
		pstmt.setInt(1,id);		// 1 : 첫번째 물음표, 들어갈 변수]
		rs=pstmt.executeQuery();		//select 문인 경우 executeQuery()
										//insert/update/delete 문일경우 executeUpdate()
		
		
		
		

		// get방식으로 넘어오는 id변수를 받아 Integer로 변환해 id로 재할당.
		// 그 id를 select쿼리를 이용해 sql에 할당.
		// if문을 통해 각각의 레코드의 값을 찍어준다.
		if(rs.next()){
	
	
	%>
	
	<table width='600' cellspacing='0' cellpadding='2' align='center'>
			   <tr>
			   <td height='22'>&nbsp;</td></tr>
			   <tr align='center'>
			   <td height='1' bgcolor='#1F4F8F'></td>
			   </tr>
			   <tr align='center' bgcolor='#DFEDFF'>
			   <td class='button' bgcolor='#DFEDFF'> 
			   <div align='left'><font size='4'> 글 제목 : <%= rs.getString("subject") %></div> </td>
			   </tr>
			   <tr align='center' bgcolor='#FFFFFF'>
			   <td align='center' bgcolor='#F4F4F4'>
			   <table width='100%' border='0' cellpadding='0' cellspacing='4' height='1'>
			   <tr bgcolor='#F4F4F4'>
			   <td width='13%' height='7'></td>
			   <td width='51%' height='7'>글쓴이 : <%= rs.getString("name") %></td>
			   <td width='25%' height='7'></td>
			   <td width='11%' height='7'></td>
			   </tr>
			   <tr bgcolor='#F4F4F4'>
			   <td width='13%'></td>
			   <td width='51%'>작성일 : <%= rs.getString("inputdate") %></td>
			   <td width='25%'>조회 : <%= rs.getString("readcount") %></td>
			   <td width='11%'></td>
			   </tr>
			   </table>
			   </td>
			   </tr>
			   <tr align='center'>
			   <td bgcolor='#1F4F8F' height='1'></td>
			   </tr>
			   <tr align='center'>
			   <td style='padding:10 0 0 0'>
			   <div align='left'><br>
			   <font size='3' color='#333333'> <pre><%= rs.getString("content") %></pre>  </div>
			   <br>
			   </td>
			   </tr>
			   <tr align='center'>
			   <td class='button' height='1'></td>
			   </tr>
			   <tr align='center'>
			   <td bgcolor='#1F4F8F' height='1'></td>
			   </tr>
	 </table>
			
	<%	  
		}else{
		out.print("DB에 해당 레코드가 존재하지 않습니다.");
		}
	%>	  
			  
		
   <table width="600" border="0" cellpadding="0" cellspacing="5">
	<tr> 
		<td align="right" width="450"><A href="freeboard_list03.jsp?go=<%= request.getParameter("page")%>"><img src="image/list.jpg" border=0></a></td>
		<td width="70" align="right"><A href="freeboard_rwrite.jps?id=<%= request.getParameter("id")%>&page=<%request.getParameter("page");%>"><img src="image/reply.jpg" border=0></A></td>
		<td width="70" align="right"><A href="freeboard_upd.jsp?id=<%= id %>&page=<%= request.getParameter("page")%>"><img src="image/edit.jpg" border=0></A></td>
		<td width="70" align="right"><A href="freeboard_del.jsp?id=<%= id %>&page=<%= request.getParameter("page")%>"><img src="image/del.jpg"  border=0></A></td>
	</tr>
  </table>


<% 
	// 읽기 페이지 마지막에서 글 조회수를 늘려준다. (DB : readcount)
	// id는 위에서 int로 형변환을 해주었다. => ""로 묶으면 안된다.
	sql = "update freeboard set readcount = readcount + 1 where id =" + id;
	
	// update, delete, insert = executeUpdate =>실행만하면 끝남. rs로 리턴X
	// Statement 객체의 delete/insert/update 쿼리인 경우 executeUpdate(sql) 를 실행
	// Statement 객체의 select 쿼리인 경우 executeUpdate(sql) 를 실행 , ResultSet 객체로 리턴
	stmt=conn.createStatement();
	stmt.executeUpdate(sql);
%> 
  
  
  
  
  
  
  

</BODY>
</HTML>
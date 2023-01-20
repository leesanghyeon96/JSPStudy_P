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
	String sql = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String idx = request.getParameter("idx");

	sql = "select * from guestlab where idx = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, idx);
	rs = pstmt.executeQuery();


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
			   <div align='left'><font size='4'> 번호 : <%= rs.getString("idx") %></div> </td>
			   </tr>
			   <tr align='center' bgcolor='#FFFFFF'>
			   <td align='center' bgcolor='#F4F4F4'>
			   <table width='100%' border='0' cellpadding='0' cellspacing='4' height='1'>
			   <tr bgcolor='#F4F4F4'>
			   <td width='13%' height='7'></td>
			   <td width='51%' height='7'>메일 : <%= rs.getString("email") %></td>
			   <td width='25%' height='7'></td>
			   <td width='11%' height='7'></td>
			   </tr>
			   <tr bgcolor='#F4F4F4'>
			   <td width='13%'></td>
			   <td width='51%'>폰 : <%= rs.getString("phone") %></td>
			   <td width='11%'>성별 : <%= rs.getString("gender") %></td>
			   <td width='25%'>주소 : <%= rs.getString("addr") %></td>
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
		out.println();
	}


%>

   <table width="600" border="0" cellpadding="0" cellspacing="5">
	<tr> 
		<td align="right" width="450"><A href="guestlab_list.jsp?go=<%= request.getParameter("page")%>"><img src="image/list.jpg" border=0></a></td>
		<td width="70" align="right"><A href="guestlab_rwrite.jps?idx=<%= request.getParameter("idx")%>&page=<%request.getParameter("page");%>"><img src="image/reply.jpg" border=0></A></td>
		<td width="70" align="right"><A href="guestlab_upd.jsp?idx=<%= idx %>&page=<%= request.getParameter("page")%>"><img src="image/edit.jpg" border=0></A></td>
		<td width="70" align="right"><A href="guestlab_del.jsp?idx=<%= idx %>&page=<%= request.getParameter("page")%>"><img src="image/del.jpg"  border=0></A></td>
	</tr>
  </table>

<%

sql = "update freeboard set readcount = readcount + 1 where id =" + idx;


//pstmt=conn.createStatement();
pstmt.executeUpdate(sql);
%>


</body>
</html>
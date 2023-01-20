<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %> 
<%@ include file="conn_oracle.jsp" %>

<%
	// DB 접근시  기본 변수 선언
	String sql = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// idx, page값 만들기
	String idx = request.getParameter("idx");
	String p = request.getParameter("page");
	
	/*
	out.println(idx + "<p/>");
	out.println(p);
	if(true) return;
	*/
	
	
	//try ~ catch ~ finally 블락 만들기
	
	try{
		sql = "select * from guestlab where idx = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, idx);
		rs = pstmt.executeQuery();
		
		if(!rs.next()){
			//값이 없을때
			out.println("해당 내용이 DataBase에 존재하지 않습니다.");
		}else{
			//값이 있을때
		
	
	
%>	
<!DOCTYPE html>
<html>
<head>
<SCRIPT language="javascript">
function check() {
 with(document.msgwrite){			
  if(email.value.length == 0){
   alert("이메일을 입력해 주세요!!");
   email.focus();
   return false;
  }
  if(gender.value.length == 0){
   alert("성별을 입력해 주세요!!");
   gender.focus();
   return false;
  }
  if(phone.value.length == 0){
   alert("폰을 입력해 주세요!!");
   phone.focus();
   return false;
  }
  if(addr.value.length == 0){
   alert("주소를 입력해주세요!!");
   addr.focus();
   return false;
  }
  document.msgwrite.submit();
 }
}
</SCRIPT> 
<link href="filegb.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<P>
<FORM name="msgwrite" method=POST action="guestlab_upddb.jsp">
	<input type="hidden" name="idx" value="<%= idx %>">
	<input type="hidden" name="page" value="<%= p %>">

 <table width="600" cellspacing="0" cellpadding="2" align = "center">
  <tr> 
   <td colspan="2" bgcolor="#1F4F8F" height="1"></td>
  </tr>
  <tr> 
   <td colspan="2" bgcolor="#DFEDFF" height="20" class="notice">&nbsp;&nbsp;<font size="2">글 수정하기</font></td>
  </tr>
  <tr> 
   <td colspan="2" bgcolor="#1F4F8F" height="1"></td>
  </tr>
  <tr> 
   <td width="124" height="30" align="center" bgcolor="#f4f4f4">번호</td>
   <td width="494"  style="padding:0 0 0 10"> 
    <input type=text name=idx value="<%= rs.getString("idx") %>" class="input_style1">
   </td>
  </tr>
  <tr> 
   <td width="124" align="center"  bgcolor="#f4f4f4">E-mail</td>
   <td width="494" style="padding:0 0 0 10" height="25"> 
    <input type=text name=email value="<%= rs.getString("email") %>" class="input_style1">
   </td>
  </tr>
  <tr> 
   <td width="124" align="center"  bgcolor="#f4f4f4">성별</td>
   <td width="494" style="padding:0 0 0 10" height="25"> 
    <input type=text name=gender size="60" value="<%= rs.getString("gender") %>" class="input_style2">
   </td>
  </tr>
  <tr> 
   <td width="124" height="162" align="center" valign="top" bgcolor="#f4f4f4" style="padding-top:7;">주소</td>
   <td width="494" style="padding:0 0 0 10" height="25"> 
    <input type=text name=addr size="60" value="<%= rs.getString("addr") %>" class="input_style2">
   </td>
  </tr>
  <tr> 
   <td width="124" align="center"  bgcolor="#f4f4f4">폰번호</td>
   <td width="494" style="padding:0 0 0 10" height="25"> 
    <input type='phone' name='phone'  class="input_style1"><br>(정확한 폰번호를 입력해야만 수정이 됩니다.)
   </td>
  </tr>
  <tr> 
   <td colspan="2" height="1" class='button'></td>
  </tr>
  <tr> 
   <td colspan="2" height="1" bgcolor="#1F4F8F"></td>
  </tr>
  <tr> 
   <td colspan="2" height="10"></td>
  </tr>
  <tr> 
   <td colspan="2" align="right"> 
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
     <tr> 
      <td width="64%">&nbsp;</td>
      <td width="12%"><a href="#" onClick="check();"><img src="image/ok.gif" border="0"></a></td>
      <td width="12%"><a href="#" onClick="history.go(-1)"><img src="image/cancle.gif"  border="0"></td>
      <td width="12%"><A href="freeboard_list.jsp?go=<%= request.getParameter("page") %>"> <img src="image/list.jpg" border=0></a></td>
     </tr>
    </table>
   </td>
  </tr>
 </table>
</FORM>




<%

		}	//if 문 종료
		
	}catch (Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(stmt != null) stmt.close();
		if(pstmt != null) pstmt.close();
		if(rs != null) rs.close();
	}

%>


</body>
</html>
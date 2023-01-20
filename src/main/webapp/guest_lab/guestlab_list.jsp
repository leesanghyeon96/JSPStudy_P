<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*,java.sql.*" %>
<%@ include file="conn_oracle.jsp" %>
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<SCRIPT language="javascript">
 function check(){
  with(document.msgsearch){
   if(sval.value.length == 0){
    alert("검색어를 입력해 주세요!!");
    sval.focus();
    return false;
   }	
   document.msgsearch.submit();
  }
 }
 function rimgchg(p1,p2) {
  if (p2==1) 
   document.images[p1].src= "image/open.gif";
  else
   document.images[p1].src= "image/arrow.gif";
  }

 function imgchg(p1,p2) {
  if (p2==1) 
   document.images[p1].src= "image/open.gif";
  else
   document.images[p1].src= "image/close.gif";
 }
</SCRIPT>
</head>
<body>
					<!--   테이블 시작      -->
<P>
<P align=center><FONT color=#0000ff face=굴림 size=3><STRONG>자유 게시판</STRONG></FONT></P> 
<P>
<CENTER>
 <TABLE border=0 width=600 cellpadding=4 cellspacing=0>	
  <tr align="center"> 
   <td colspan="5" height="1" bgcolor="#1F4F8F"></td>
  </tr>
  <tr align="center" bgcolor="#87E8FF"> 
   <td width="42" bgcolor="#DFEDFF"><font size="2">번호</font></td>
   <td width="340" bgcolor="#DFEDFF"><font size="2">이름</font></td>
   <td width="84" bgcolor="#DFEDFF"><font size="2">폰</font></td>
   <td width="78" bgcolor="#DFEDFF"><font size="2">성별</font></td>
   <td width="49" bgcolor="#DFEDFF"><font size="2">주소</font></td>
  </tr>
  <tr align="center"> 
   <td colspan="5" bgcolor="#1F4F8F" height="1"></td>
  </tr>

<%

//1. Vector의 변수 선언
	Vector idx = new Vector();
	Vector email = new Vector();
	Vector phone = new Vector();
	Vector gender = new Vector();
	Vector addr = new Vector();
	
	
//2. 페이징 처리할 변수 선언 시작
	int where = 1; //현재 위치한 페이징 변수

	int totalgroup = 0; // 페이징의 총 그룹수
	int maxpages = 5;	// 하단에 출력할 총 페이지 개수 : [1][2]...
	int startpage = 1;	// 
	int endpage = startpage + maxpages -1;
	int wheregroup = 1;

	//go 변수와 group변수를 넘겨받는 코드블락 생성 (if(go변수) ~ else if(gogroup) 문)
	if(request.getParameter("go") != null){
		where = Integer.parseInt(request.getParameter("go"));	
		wheregroup = (where -1)/maxpages + 1;	//내가 속한 그룹 확인가능
		startpage = (wheregroup -1) * maxpages +1;
		endpage = startpage + maxpages -1;
		
	}else if(request.getParameter("gogroup") != null){
		wheregroup = Integer.parseInt(request.getParameter("gogroup"));  //현재내가 위치한 그룹
		startpage = (wheregroup - 1) * maxpages +1 ; 
		where = startpage; 
		endpage = startpage + maxpages -1;
	}

	// [이전][다음] 변수 선언과 할당
	int nextgroup = wheregroup + 1;
	int priorgroup = wheregroup - 1;

	// 
	int startrow = 0;	// 하나의 페이지에서 레코드의 시작번호 :	[1]에서 첫째글
	int endrow = 0;		// 하나의 페이지에서 레코드의 끝번호 : [1]에서 마지막글
	int maxrow = 5;		// 한 페이지 내에서 출력할 행의 개수 : (row, 행, 레코드)의 개수
	int totalrows = 0;	// DB에서 select해서 가져온 총 레코드의 수
	int totalpages = 0;	// 총 페이지 개수
	
	
//3. SQL 쿼리등의 객체 선언들
	String sql = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	sql = "select * from guestlab order by idx desc";
	
	stmt = conn.createStatement();
	rs=stmt.executeQuery(sql);

	
//4. rs의 값을 Vector에 저장 : 페이징 처리하기 위함.
	if(!(rs.next())){	//rs의 값이 존재하지 않을때
		out.println("게시판에 올라온 글이 없습니다.");
	}else{		//rs의 값이 존재할때
		do{
			idx.addElement(rs.getString("idx"));
			email.addElement(rs.getString("email"));
			phone.addElement(rs.getString("phone"));
			gender.addElement(rs.getString("gender"));
			addr.addElement(rs.getString("addr"));
		}while(rs.next());
	}

//5. 페이징의 변수 계산
	totalrows = email.size();	
	totalpages = (totalrows - 1) / maxrow +1;	//전체 페이지 개수 출력
	startrow = (where -1) * maxrow;		// 하나의 페이지에서 레코드의 시작번호
	endrow = startrow + maxrow -1;		// 하나의 페이지에서 레코드의 끝번호

	//전체 페이지 그룹, 하단에 출력할 페이지 개수(5개)의 그룹핑
	totalgroup = (totalpages -1) / maxpages + 1;

	//endrow가 totalrows 보다 크면 totalrows -1로 처리해야함.
	if(endrow >= totalrows){
		endrow = totalrows -1;
	}
	if(endpage > totalpages){
		endpage = totalpages;
	}

//6. for문을 통해 테이블의 값을 가져와 루프를 돌려 찍어준다.
	for (int j = startrow ; j <= endrow; j++){
		/*	
			1번페이징 : startrow : 0 ~ endrow : 4
			2번페이징 : startrow : 5 ~ endrow : 9
			3번페이징 : startrow : 10 ~ endrow : 14
			4번페이징 : startrow : 15 ~ endrow : 19
		*/

		

%>

  <tr>		<!-- 테이블의 값을 가져와서 여기에서 루프를 돌려 찍어준다. -->	
  	<td><%= idx.elementAt(j) %></td>	<!-- vector의 값을 가져온다. -->	
  	<!-- freeboard_read.jsp를 호출하면서 id변수에 <> 를 넣어 id값의 상세페이지로 이동 -->	
  	<td><a href="guestlab_read.jsp?idx=<%= idx.elementAt(j) %>&page=<%= where %>"><%= email.elementAt(j) %> </a> </td> 
  	<td><%= phone.elementAt(j) %></td>	
  	<td><%= gender.elementAt(j) %></td> 
  	<td><%= addr.elementAt(j) %></td>
  </tr>

<%
		}
%>
</TABLE>

<%

//6. 페이징 출력부문출력 if~else     [처음][이전] 1 2 3 4 5 [다음][마지막]

	// [처음][이전]
	if(wheregroup > 1){	//현재 나의 그룹이 1보다 클 경우
		out.println("[<a href='guestlab_list.jsp?gogroup=1'>처음</a>]");
		out.println("[<a href='guestlab_list.jsp?gogroup=" + priorgroup + "'>이전</a>]");
	}else{	//현재 나의 그룹이 1인경우
		out.println("[처음]");
		out.println("[이전]");
	}

	// 페이징 개수를 출력 : 1 2 3 4 5
	if(email.size() != 0){
		for(int jj = startpage ; jj <= endpage ; jj++){
			if(jj==where){		//jj가 자신의 페이지일 경우
				out.println("[" + jj + "]");
			}else{
				out.println("[<a href='guestlab_list.jsp?go=" + jj + "'>" + jj + "</a>]");
			}
		}
	}

	// [다음][마지막]
	if(wheregroup < totalgroup){
		out.println("[<a href='guestlab_list.jsp?gogroup=" + nextgroup + "'>다음</a>]");
		out.println("[<a href='guestlab_list.jsp?gogroup=" + totalgroup + "'>마지막</a>]");
	}else{		// 마지막 페이지에 왔을때 링크를 해지
		out.println("[다음]");
		out.println("[마지막]");
	}

	out.println("전체 글수 : " + totalrows);

%>

<FORM method="post" name="msgsearch" action="freeboard_search.jsp">
<TABLE border=0 width=600 cellpadding=0 cellspacing=0>
 <TR>
  <TD align=right width="241"> 
   <SELECT name=stype >
    <OPTION value=1 >이름
    <OPTION value=2 >제목
    <OPTION value=3 >내용
    <OPTION value=4 >이름+제목
    <OPTION value=5 >이름+내용
    <OPTION value=6 >제목+내용
    <OPTION value=7 >이름+제목+내용
   </SELECT>
  </TD>
  <TD width="127" align="center">
   <INPUT type=text size="17" name="sval" >
  </TD>
  <TD width="115">&nbsp;<a href="#" onClick="check();"><img src="image/serach.gif" border="0" align='absmiddle'></A></TD>
  <TD align=right valign=bottom width="117"><A href="freeboard_write.jsp"><img src="image/write.gif" border="0"></TD>
 </TR>
</TABLE>
</FORM>




</body>
</html>
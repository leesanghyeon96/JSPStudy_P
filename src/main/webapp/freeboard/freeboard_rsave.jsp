<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, java.util.*, java.text.*" %>    
<% request.setCharacterEncoding("UTF-8"); %>	<!-- form에서 넘어오는 변수 깨지지않게 -->
<%@ include file = "conn_oracle.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
//1. form에서 넘어오는 변수, hidden으로 던져주는 변수 담기, DB의 id 컬럼 변수 선언
	// form에서 넘어오는 변수 담기
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String sub = request.getParameter("subject");
	String cont = request.getParameter("content");
	String pw = request.getParameter("password");
	//답변글을 처리하기 위한 변수 3개 : mid, rnum, step
	//hidden으로 던져주는 값
	// mid : masterid(DB) : 동일글의 그룹핑
		// 처음글, 답변글일때
		// 처음글은 id의 max값을 가져와masterid에 저장하지만
		// 답변글은 masterid의 값이 동일하게 들어감
	int mid = Integer.parseInt(request.getParameter("mid"));
	// rnum : relpaynum(DB)
		//처음글 step : 0, 답변글 : step : 1, 답변의 답변 : step : 2  => 답변의 깊이를 나타냄
	int rnum = Integer.parseInt(request.getParameter("rnum"));
	// step : step(DB) : 글의 깊이를 처리하는 컬럼
		// 답변글에 대한 순번 : 0, 1, 2
	int step = Integer.parseInt(request.getParameter("step"));
	
	
	// 날짜를 한국 포멧에 맞도록 변환해서 저장함.
	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:m a");
	String ymd = myformat.format(yymmdd);
	

	int id=0;		//DB의 ID컬럼의 최대값을 가져와서 +1 해서 저장함.
	
	//변수가 잘 넘어오는지 확인
	/*
	out.println(na + "<p/>");
	out.println(em + "<p/>");
	out.println(sub + "<p/>");
	out.println(cont + "<p/>");
	out.println(pw + "<p/>");
	out.println(mid + "<p/>");
	out.println(rnum + "<p/>");
	out.println(step + "<p/>");
	out.println(ymd + "<p/>");
	if(true) return;
	*/

	//DB에 저장할 쿼리
	String sql = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	stmt=conn.createStatement();
	
	//글을 넣기 위해서 DB의 ID의 Max 값을 가져온 후 +1으로 처리
	sql = "select max(id) from freeboard";
	rs = stmt.executeQuery(sql);
	
	if(!(rs.next())){	// 테이블에 저장된 레코드가 없다. (처음 글 작성)
		id = 1;
	}else{	// 레코드가 존재할떄 (최대값을 가지고 옴)
		id = rs.getInt(1) + 1 ;	//rs.getInt(1)의 1=index1, 1대신 컬럼명도 가능
	}
	
	out.println(id);
	
	//답변글이므로 step 값을 + 1
	//step : 글의 깊이를 처리하는 컬럼
		//처음글 : 0, 답변글 : 1, 답변의 답변 : 2, ...
	step += 1;	//step = step + 1;
	
	if(step == 1){
		sql = "select max(replaynum) from freeboard where masterid =" + mid;
		rs=stmt.executeQuery(sql);
		
		if(!(rs.next())){
			rnum = 1;
		}else{
			rnum = rs.getInt(1) + 1;
		}
	}
	
	// 모든 변수가 처리된 내용을 DB에 저장함
	// 1. statement 객체로 처리
	
	sql = "insert into freeboard(id, name, password, email, subject, content, ";
	sql += "inputdate, masterid, readcount, replaynum, step) ";
	// int는 ''가 붙지 않는다., String은 ''가 붙는다.
	sql += "values (" + id + ", '" + na + "', '" + pw + "', '" + em ;
	sql += "', '" + sub + "', '" + cont + "', '" + ymd + "', " + mid;
	sql += ",0, " + rnum + ", " + step + ")";		// readcount : 0
	
	//out.println(sql);
	
	//
	int result = 0;			// 0 : insert 실패, 1 : insert 성공
	result = stmt.executeUpdate(sql);
	
	/*
	if(result >= 1){
		out.println("DB에 Insert 성공");
	}else{
		out.println("DB에 Insert 실패");
	}
	*/
	
	//DB에 잘 저장 후 freeboard_list03.jsp 페이지로 이동, go 변수에 페이지 번호를 넣어서 이동
	response.sendRedirect("freeboard_list03.jsp?go=" + request.getParameter("page"));
	
	
	
	
	
	// 2. PreparedStatement 객체로 처리
	//freeboard_rsave02.jsp 에서 처리
	
	
	
	
	
	

%>





















</body>
</html>
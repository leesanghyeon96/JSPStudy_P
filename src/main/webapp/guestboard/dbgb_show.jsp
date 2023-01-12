<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 필요한 라이브러리 등록 -->
<%@ page import = "java.sql.*, java.util.*" %>    

<!-- DB의 값을 select해서 select한 값을 출력 --> 
<%@ include file="conn_mssql.jsp" %>   
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록의 내용을 DB에서 가져와서 출력하는 페이지</title>
<link href="filegb.css" rel="stylesheet" type="text/css">
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

<!-- DataBase에서 Select한 경과를 담는 변수선언 : 컬렉션 : 방이 자동으로 늘어난다.(java.util.*) -->
<!-- Vector : ArrayList와 같은 역할을 한다. -->
<%
	//Vector name = new Vector();			DB 테이블에서 name 컬럼의 값만 담는 변수
	//Vector email = new Vector();		
	//Vector inputdate = new Vector();	
	//Vector subject = new Vector();		
	//Vector content = new Vector();		
	//==> 아래는 Vector를 쓰지 않음., Vector는 dbgb_show2.hsp에서...
	
	
	
	//사용할 변수 선언
	String sql = null;			//SQl 쿼리를 담는 변수
	Statement stmt = null; 
		//DBMS에 sql 쿼리를 보내는 객체. Connection 객체로 생성
	ResultSet rs = null;	//Select 한 결과 recordset을 담는 객체 (ResultSet객체로 리턴해줘야한다.)
	
	//sql 쿼리를 변수에 할당	
	// 최신글을 제일 먼저 처리하는 쿼리 : select * from guestboard order by inputdate desc;
	sql = "select * from guestboard order by inputdate desc";
	
	//Connection 객체(conn)를 사용해서 Statement 객체를 생성
	stmt = conn.createStatement();	//Oracle 의 HR3계정까지 연결
	
	//stmt 객체를 실행
	//rs : select 한 결과 값(레코드)을 담는 객체
	rs = stmt.executeQuery(sql);	
	/*
	sql가 select구문인 쿼리라서 executeQuery를 사용하고
	executeQuery를 사용할 경우 ResultSet의 객체에 담아야 한다.
	*/
	
	/*
	  rs에 담긴 값을 루프를 돌리면서 출력
		 rs.nect() : 커서의 위치를 다음 레코드로 이동
			레코드가 존재하면 rs.next : true
			레코드의 값이 존재하지 않으면 : false
	*/
	if(rs.next()){		//레코드가 존재할때 루프를 돌리면서 출력
		do {	//do ~ while문을 쓰자 (한번 실행 후 조건)
		
	//rs.next();	//다음 레코드로 이동
	
%>
<!-- HTML 블락에서 rs에 담긴 내용을 출력할 테이블 생성 
	rs.getString("컬럼명")

-->
<div>	<!-- 테이블 1 : 레코드 1 => 루프돌릴거임 : 루프돌리지않고 출력하면 오류발생 -->
	<table width="600px" border="1px">
		<tr>
			<td colspan="2" align="center"> 
				<h3> <%= rs.getString("subject") %> </h3>
			</td>
		</tr>
		<tr>
			<td> 글쓴이 : <%= rs.getString("name") %> </td>
			<td> E-Mail : <%= rs.getString("email") %> </td>
		</tr>
		<tr>
			<td colspan="2"> 글쓴날짜 : <%= rs.getString("inputdate") %> </td>
		</tr>
		<tr>
			<td colspan="2" width="600px"> <%= rs.getString("content") %> </td>
		</tr>
	</table>
	<p/><p/>
</div>
	
<%
		} while(rs.next());
		
		
	}else{		//레코드가 존재하지 않을때 
		out.println("방명록에 데이터가 존재하지 않습니다.");
	}

%>	
	
<div>
	<a href="dbgb_write.html"> <img src="images/write.gif" width="100px"> </a>
</div>
	
	
	












</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 필요한 라이브러리 등록 -->
<%@ page import = "java.sql.*, java.util.*" %>    

<!-- DB의 값을 select해서 select한 값을 출력 --> 
<%@ include file="conn_oracle.jsp" %>   
    
    
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

<p/><p/>
show02.jsp(Vector(멀티쓰레드)를 이용하여 출력) 입니다. <p/>

<!-- DataBase에서 Select한 경과를 담는 변수선언 : 컬렉션 : 방이 자동으로 늘어난다.(java.util.*) -->
<!-- Vector : ArrayList와 같은 역할을 한다. -->
<%
	//컬렉션 : 방의 크기를 자동으로 늘려준다.
		// List : 인터페이스를 구현한 객체 : ArrayList(싱글쓰레드), Vector(멀티쓰레드)
		// 		동일한 메소드를 사용
	Vector name = new Vector();			//DB 테이블에서 name 컬럼의 값만 담는 변수
	Vector email = new Vector();		
	Vector inputdate = new Vector();	
	Vector subject = new Vector();		
	Vector content = new Vector();		
	
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
	
	// 루프를 돌아가면서 rs에 담긴값을 벡터에 추가함.
		//name ,
		//name.addElement("값") : name 벡터에 값을 추가
	if(rs.next()){		// 각 벡터에 그에 맞는 DB의 컬럼 내용만 index0 ~ 저장
		do {
			name.addElement(rs.getString("name"));
			email.addElement(rs.getString("email"));
			inputdate.addElement(rs.getString("inputdate"));
			subject.addElement(rs.getString("subject"));
			content.addElement(rs.getString("content"));
			
		}while(rs.next());
	}
	
	
	
	
	
	
	
	
	/*
	  rs에 담긴 값을 루프를 돌리면서 출력
		 rs.nect() : 커서의 위치를 다음 레코드로 이동
			레코드가 존재하면 rs.next : true
			레코드의 값이 존재하지 않으면 : false
	*/
	
	// 벡터에 저장된 값을 for 문을 사용해서 출력
		// 컬렉션에서 방의 개수 : arrayList(싱글쓰레드), vector(멀티쓰레드)
		// name.size() : 방의 개수
	for(int i = 0 ; i < name.size() ; i++){
	
	
	
%>
<!-- HTML 블락에서 rs에 담긴 내용을 출력할 테이블 생성 
	rs.getString("컬럼명")

-->
<div>	<!-- 테이블 1 : 레코드 1 => 루프돌릴거임 : 루프돌리지않고 출력하면 오류발생 -->
	<table width="600px" border="1px">
		<tr>
			<td colspan="2" align="center"> 
				<h3> <%= subject.elementAt(i) %> </h3>	<!-- subject : Vector -->
			</td>
		</tr>
		<tr>
			<td> 글쓴이 : <%= name.elementAt(i) %> </td>
			<td> E-Mail : <%= email.elementAt(i) %> </td>
		</tr>
		<tr>
			<td colspan="2"> 글쓴날짜 : <%= inputdate.elementAt(i) %> </td>
		</tr>
		<tr>
			<td colspan="2" width="600px"> <%= content.elementAt(i) %> </td>
		</tr>
	</table>
	<p/><p/>
</div>
	
<%

	}


%>	
	
<div>
	<a href="dbgb_write.html"> <img src="images/write.gif" width="100px"> </a>
</div>
	
	
	












</body>
</html>
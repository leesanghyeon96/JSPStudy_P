<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>	<!-- java의 라이브러리 임포트 -->

<!--	HTML주석
 java.sql.* 패키지 하위의 모든 클래스를 import
 	Connection 객체		: DataBase(Oracle, MSSQL, MySQL...) 연결
 	Statement 객체		: CRUD 를 사용해서 Select, Insert, Update, Delete, 
 	PreparedStatement 객체 : Statement 객체의 업그레이드 버젼, 성능개선, 구문이 간략
 	ResultSet 객체 : DB에서 Select 한 결과를 저장하는 객체
 	...
 	
 	
 	*Oracle : 1521포트*
 	*MSSQL : 1433포트*
 	*MySQL : 3306포트*
 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Oracle DB Connection</title>
</head>
<body>

	<%	// 대소문자, 오타, 띄어쓰기 확인하기
	//webapp폴더 : 홈폴더 
	//http://localhost:8080/JSPStudy/ => index.jsp가 기본으로 출력
		//변수 초기화		// : JSP블락 내에서의 주석
		Connection conn = null;	//connection객체는 null
		String driver = "oracle.jdbc.driver.OracleDriver";//Oracle.jdbc.driver : 패키지명(소문자) , OracleDriver : 클래스(대문자)
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		Boolean connect = false;	//접속이 잘 되었는지 확인하는 변수	(테스트, 실제로는 필요없다.)
		
		try{
			//Oracle.jdbc.driver.OracleDriver에 driver있는지
			Class.forName(driver);	//오라클 드라이버를 로드함 , dirver가없으면 오류가발생(try~catch로 묶어야함)
			conn = DriverManager.getConnection (url, "C##HR3", "1234");
	
			connect = true;		//(테스트, 실제로는 필요없다.)
			conn.close();		//실제로 위치 이동
		}catch (Exception e){
			connect = false;	//(테스트, 실제로는 필요없다.)
			e.printStackTrace();
		}
		
		// 조건을 사용해서 잘 연결되면 잘 연결되었다고 확인메세지 출력 (테스트, 실제로는 필요없다.)
		if(connect==true){
			out.println("오라클 DB에 잘 연결 되었습니다.");
		}else{
			out.println("오라클 DB에 연결을 실패했습니다.");
		}
		
		
		
		
		
		
	%>





</body>
</html>
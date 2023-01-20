<!-- DB에 저장된 회원의 정보를 출력하는 페이지(페이징처리, crud하기위한 href이동 처리등..) -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*,java.util.*" %>   
<%@ include file = "conn_oracle.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UT-8">
<title>DB의 내용을 가져와서 출력 하기 </title>
</head>
<body>



<table width = "800" border="1"> 
	<tr> 
		<th> 번호 </th>
		<th> 아이디 </th> 
		<th> 비밀번호 </th> 
		<th> 이름 </th> 
		<th>email</th> 
		<th> city</th>
		<th>phone</th>  
	</tr>
	
	<%
//페이징 처리위한 벡터 선언
		Vector idx = new Vector();
		Vector id = new Vector();
		Vector pass = new Vector();
		Vector name = new Vector();
		Vector email = new Vector();
		Vector city = new Vector();
		Vector phone = new Vector();
	
// 페이징 처리 변수 처리
		int where = 1;
		
		int totalgroup = 0;		// 출력할 페이징의 총 그룹수  페이징 : 페이지의 묶음   0:기본값
		int maxpages = 5;		// 하단에 페이지 출력 부분에서 출력할 최대 페이지 개수 [1][2]
		int startpage = 1;
		int endpage = startpage + maxpages -1;
		int wheregroup = 1;		// 현재 위치한 페이징 그룹
	
		if(request.getParameter("go") != null){		// freeboard_list03.jsp?go= 
			where = Integer.parseInt(request.getParameter("go"));	// go 변수의 값을 where 변수에 할당
			wheregroup = (where -1)/maxpages + 1;	// 현재 내가 속한 그룹을 알 수 있다.
			startpage = (wheregroup -1) * maxpages +1;
			endpage = startpage + maxpages -1;
		
		//gogroup 변수를 넘겨받아서 startpage, endpage, where의 정보를 알아낼 수 있다. [다음] , [1][2][3][4][5] <= gogroup1
			//코드 블락
		}else if (request.getParameter("gogroup") != null){  //freeboard_list03.jsp?gogroup= 
			wheregroup = Integer.parseInt(request.getParameter("gogroup"));  //현재내가 위치한 그룹
			startpage = (wheregroup - 1) * maxpages +1 ; 
			where = startpage; 
			endpage = startpage + maxpages -1;  
		}
		
		int nextgroup = wheregroup + 1;
		int priorgroup = wheregroup - 1;
		
		//int nextpage = where + 1;	// where : 현재 내가 위치한 페이지
		//int priorpage = where -1;	// priorpage : 이전페이지로 이동
		int startrow = 0;			// 하나의 page에서 레코드 시작 번호
		int endrow = 0;				// 하나의 page에서 레코드 마지막 번호
		int maxrow = 5;				// 한 페이지 내에 출력할 행의 개수 (row, 행, 레코드 개수)
		int totalrows = 0;			// DB에서 select한 총 레코드 개수
		int totalpages = 0;			// 총 페이지 개수
		
		
// 기본 객체 선언		
		ResultSet rs = null;       //ResultSet 객체는 DB의 테이블을 Select 해서 나온 결과 레코드셋을 담는 객체 
		Statement stmt = null;     //SQL 쿼리를 담아서 실행하는 객체 
		
		String sql = "SELECT * FROM myTbl order by idx desc";
		stmt = conn.createStatement();      // connection객체의 createStatement()로 stmt를 활성화
		 rs  =  stmt.executeQuery (sql);       
				//stmt.executeQuery (sql)   : select 한 결과를 ResultSet객체에 저장해야함. 
				//stmt.executeUpdate (sql)  : insert, update, delete

//rs에 담긴 값을 vector에 저장	
		if(!(rs.next())){
			out.println("게시글이 없습니다.");
		}else{
			do{
				idx.addElement(new Integer(rs.getString("idx")));
				id.addElement(rs.getString("id"));
				pass.addElement(rs.getString("pass"));
				name.addElement(rs.getString("name"));
				email.addElement(rs.getString("email"));
				city.addElement(rs.getString("city"));
				phone.addElement(rs.getString("phone"));
			}while(rs.next());
		}
		
		
		//변수를 만들어 계산을 해주어야한다.
		totalrows = name.size();		//DB에서 가져온 총 레코드 개수
		totalpages = (totalrows-1) / maxrow + 1;	// 전체 페이지 개수 출력
		startrow = (where -1) * maxrow;				// 해당 페이지에서 Vector의 방번호 : 시작
		endrow = startrow + maxrow -1;				// 해당 페이지에서 Vector의 방번호 : 마지막
		
		totalgroup = (totalpages -1) / maxpages + 1 ; 
			//전체 페이지 그룹, 하단에 출력할 페이지 개수(5개)의 그룹핑
		
		//endrow가 totalrows 보다 크면 totalrows -1로 처리해야함.
		if(endrow>=totalrows){
			endrow = totalrows -1;
		}
		if(endpage>totalpages){
			endpage = totalpages;
		}	
				
// 해당 페이지를 처리하면서 해당 페이지에 대한 내용을 출력 (rs의 값을 vector에 저장했으므로 for )
		for(int j = startrow ; j <= endrow; j++){		
				
		%>	
			<tr>  
				<td><%= idx.elementAt(j) %> </td> 
				<td><a href="read01.jsp?idx=<%= idx.elementAt(j) %>&page=<%= where %>"><%= id.elementAt(j) %> </td> 
				 <td><%= pass.elementAt(j) %> </td> 
				<td><%= name.elementAt(j) %> </td>
				<td><%= email.elementAt(j) %> </td> 
				<td><%= city.elementAt(j) %> </td>
				<td><%= phone.elementAt(j) %> </td>  
			</tr>				

			<%	
				}
				
// 페이징 출력 부분 : [처음][이전] 1 2 3 4 5 [다음][마지막]
		//[처음][이전]
	if(wheregroup > 1){		// 현재 나의 그룹이 1이상일때 처음과 
		out.println("[<a href='list01.jsp?gogroup=1'>처음</a>]");
		out.println("[<a href='list01.jsp?gogroup="+priorgroup+"'>이전</a>]");
	}else{			// 현재 나의 페이지 그룹이 1일때는 
		out.println("[처음]");
		out.println("[이전]");
	}
		//1 2 3 4 5
	if(id.size() != 0){			
		for(int jj = startpage; jj <= endpage ; jj++){
			if(jj == where){		// jj 가 자신의 페이지 번호라면 링크 없이 출력
				out.println("[" + jj + "]");
			}else{			// jj가 현재 자신의 페이지 번호가 아니라면 링크를 걸어서 출력
				out.println("[<a href='list01.jsp?go=" + jj + "'>" + jj + "</a>]");
			}
		}
	}
		//[다음][마지막]
	if(wheregroup < totalgroup){	// 링크를 처리
		out.println("[<a href='list01.jsp?gogroup=" + nextgroup + "'>다음</a>]");
		out.println("[<a href='list01.jsp?gogroup=" + totalgroup + "'>마지막</a>]");
	}else{		// 마지막 페이지에 왔을때 링크를 해지
		out.println("[다음]");
		out.println("[마지막]");
	}
		%>

</table>

</body>
</html>
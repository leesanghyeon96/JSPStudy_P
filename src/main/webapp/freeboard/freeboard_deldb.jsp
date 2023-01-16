<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>    
<% request.setCharacterEncoding("UTF-8"); %>
<%@ include file="conn_oracle.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 삭제를 처리하는 페이지</title>
</head>
<body>

[<a href="freeboard_list03.jsp?go=<%= request.getParameter("page") %>"> 게시판으로 이동 </a>]




<%

//DB 접속하는 객체 선언
String sql = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

// id와 page는 del.jsp에서 받아오는 변수 (read->del->deldb)
int id = Integer.parseInt(request.getParameter("id"));
int page1 = Integer.parseInt(request.getParameter("page"));
//폼에서 넘겨진 password
String pw = request.getParameter("password");

/*
// 잘 넘어오는지 확인 (디버깅)
out.println (id + "<p/>");
out.println (page1 + "<p/>");
out.println (pw + "<p/>");
if (true) return;	// 프로그램 종료
*/

try {	// DB에 쿼리를 보내는 블락 : DB에 오류가 발생시 프로그램이 종료되지 않도록 처리
	//실무에서는 * 말고 모든 컬럼을 명시해서 쓰는것이 퍼포먼스 측면에서 좋다.
	sql = "select * from freeboard where id = ?";	//select 해 password를 가져온다.
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, id);		// id는 form에서 넘겨 여기까지 온 id
	rs=pstmt.executeQuery();	//sql에서 selet한 결과값을 rs에 담는다.
	
	if(!(rs.next())){		// rs의 값이 비어있을때
		out.println("해당 값이 존재하지 않습니다.");
	
	}else{		// rs의 값이 존재할때
		// rs의 password 컬럼의 값을 가져와서 폼에서 넘겨받은 password(pw)와 맞으면 삭제
				//pwd : DB에서 가져온 password
				//pw : 사용자가 폼에서 넘긴 password
			String pwd = rs.getString("password");	//변수에 담아도되고 바로 넣어도 된다.
		
			if(pwd.equals(pw)){		//DB의 password와 폼의 password가 같을때
				//delete 쿼리를 적용
				sql = "delete freeboard where id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, id);
				pstmt.executeUpdate();	
				
				// 위 쿼리가 잘 실행되면 아래 코드가 실행, 오류가 나면 catch블락으로 떨어짐
				out.println("잘 삭제 되었습니다.");
				
			}else{	//다를때
				out.println("패스워드가 다릅니다.");
			}
	}
	
}catch (Exception e){
	out.println("DB 오류로 인해서 삭제를 실패했습니다.");
	e.printStackTrace();	//디버깅
}finally{
	if(conn != null){conn.close();}
	if(pstmt != null){pstmt.close();}
	if(rs != null){rs.close();}
}






%>
</body>
</html>
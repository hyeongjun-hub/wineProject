<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>middle</title>
</head>
<body>
	<%
		String dbName = "WineProject";
		String dbTable = "field";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
		String dbUser = "root";
		String dbPass = "1221";
		String query = "";
		
		
		Connection conn = null;
		Statement stmt = null;
		
		String field_ID = request.getParameter("field_ID");
		String location = request.getParameter("location");
		int area = Integer.parseInt(request.getParameter("area"));
		String variety = request.getParameter("variety");
		String vineyard_ID = request.getParameter("vineyard_ID");
		query = "Insert into " + dbTable +" values('"+ field_ID +"', '" + location + "', " +
				 area + ", '" + variety + "', '" + vineyard_ID + "');";
		try{
			String driver = "org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			stmt.executeUpdate(query);
			
		
	%>
	<p>
		
		성공적으로 데이터베이스 <%=dbName%>. <%=dbTable%> table에 등록하였습니다.
	<br>
	<button onclick="location='vineyardDetail.jsp?vineyard_ID=<%=vineyard_ID%>'">포도농장으로 돌아가기</button>
	<button onclick="location='home.jsp'">홈으로 돌아가기</button>
	<%
		} catch(NumberFormatException e){
	%>
	<h1>이런!</h1>
	<p>
		올바른 정보를 입력해주세요 ..
		<%
		}finally{
			try{
				stmt.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	%>
</body>
</html>
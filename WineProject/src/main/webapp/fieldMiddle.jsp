<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>field completed</title>
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
		ResultSet fieldResult = null;
		
		String field_ID = request.getParameter("field_ID");
		String vineyard_ID = request.getParameter("vineyard_ID");
		String fieldQuery = "select * from field where field_ID = '" + field_ID + "';"; 
		String moneyQuery;
		
		try{
			
			String driver = "org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			fieldResult = stmt.executeQuery(fieldQuery);
			String location = null;
			int area = 0;
			String variety = null;
			
			
			if(vineyard_ID==null){
				location = request.getParameter("location");
				variety = request.getParameter("variety");
				area = Integer.parseInt(request.getParameter("area"));
				query = "Insert into " + dbTable +" values('"+ field_ID +"', '" + location + "', " +
						 area + ", '" + variety + "', null);";
			}else{
				while(fieldResult.next()){
					location = fieldResult.getString("location");
					variety = fieldResult.getString("variety");
					area = fieldResult.getInt("area");
				}
				moneyQuery = "update vineyard set money = money - " + (area * 10) + " where vineyard_ID = '" + vineyard_ID + "';"; 
				stmt.executeUpdate(moneyQuery);
				query = "update field set vineyard_ID ='" + vineyard_ID + "' where field_ID = '" + field_ID + "';";
			}
			stmt.executeUpdate(query);
			String backUrl = request.getHeader("referer");
		
	%>
	<p>
		
		성공적으로 데이터베이스 <%=dbName%>. <%=dbTable%> table에 등록하였습니다
	<% if(vineyard_ID != null){ %>
	<span>(<%=(area * 10)%> 리라 소비)</span>
	<br><button onclick="location='vineyardDetail.jsp?vineyard_ID=<%=vineyard_ID %>'">포도농장으로 돌아가기</button>
	<%}else{} %>
	<button onclick="location='fieldAll.jsp'">밭목록으로 돌아가기</button>
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
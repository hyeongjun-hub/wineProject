<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>wineCategory & wineGrade</title>
</head>
<body>
	<%
		String dbName = "WineProject";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
		String dbUser = "root";
		String dbPass = "1221";
	
		Connection conn = null;
		Statement stmt = null;
		ResultSet categoryResult = null;
		ResultSet gradeResult = null;
		
		String categoryQuery = "select * from wineCategory;";
		String gradeQuery = "select * from wineGrade";
		
		try{
			String driver = "org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			categoryResult = stmt.executeQuery(categoryQuery);
			gradeResult = stmt.executeQuery(categoryQuery);
			
			%>
			
	<h3>와인종류 리스트</h3>
	<table border=1>
		<tr>
			<td>와인카테고리ID</td>
			<td>종류</td>
			<td>와인가격</td>
		</tr>

		<%
			while(categoryResult.next()){
				%>
		<tr>
			<td><%=categoryResult.getString(1) %></td>
			<td><%=categoryResult.getString(2) %></td>
			<td><%=categoryResult.getInt(3) %></td>
		</tr>
		<%
			} 
			%>
	</table>
	<br>
	
	<h3>와인등급 리스트</h3>
	<table border=1>
		<tr>
			<td>와인등급ID</td>
			<td>등급</td>
			<td>가중치</td>
		</tr>

		<%
			while(gradeResult.next()){
				%>
		<tr>
			<td><%=gradeResult.getString(1) %></td>
			<td><%=gradeResult.getString(2) %></td>
			<td><%=gradeResult.getInt(3) %></td>
		</tr>
		<%
			} 
			%>
	</table>
	<button onclick="location='wineryInput.jsp'">새로운 양조장 등록</button>
	<br><br>
	<button onClick="location='home.jsp'">홈으로 돌아가기</button>
	<%
		} catch(NumberFormatException e){
	%>
	<h1>이런!</h1>
	<p>
		올바른 정보를 입력해주세요 ..
		<%
		}finally{
			try{
				gradeResult.close();
				categoryResult.close();
				stmt.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	%>
	
</body>
</html>
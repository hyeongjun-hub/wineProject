<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VineyardEdit</title>
</head>
<body>
	<%
		String jdbcDriver = "jdbc:mariadb://localhost:3306/WineProject";
		String dbUser = "root";
		String dbPass = "1221";
	
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		ResultSet result2 = null;
		String field_ID = request.getParameter("field_ID");
		String query = "select * from field where field_ID='" +field_ID + "';";
		
		try{
			String driver = "org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			result = stmt.executeQuery(query);
			result2 = stmt.executeQuery(query);
			%>
	<h3>포도밭 상세정보</h3>
	<table border=1>
		<tr>
			<td>field_ID</td>
			<td>위치</td>
			<td>면적</td>
			<td>품종</td>
		</tr>

		<%
			while(result.next()){
				%>
		<tr>
			<td><%=result.getString(1) %></td>
			<td><%=result.getString(2) %></td>
			<td><%=result.getInt(3) %></td>
			<td><%=result.getString(4) %></td>
		</tr>

		<%} %>
	</table>
	<br>
	
	<form action="fieldEditMiddle.jsp" method="get">
		<% while(result2.next()){ %>
		<div>
			<h3>포도농장 정보 수정하기</h3>
			<input type="text" name="field_ID"
				value=<%=field_ID %> hidden=true><br> 
			위치<input type="text"
				name="location" value=<%=result2.getString(2) %>><br>
			면적<input
				type="text" name="area" value=<%=result2.getInt(3) %>><br>
			품종<input type="text" name="variety"
				value=<%=result2.getString(4) %>><br> 
			<br>
			<button type="submit">수정완료</button>
		<%} %>
		</div>
	</form>
	<br>
	<button onClick="location='field.jsp?field_ID=<%=field_ID%>'">돌아가기</button>

		<%
			} catch(NumberFormatException e){
		%>
		<h1>이런!</h1>
		<p>올바른 정보를 입력해주세요 ..</p>
		<%
			}finally{
				try{
					result.close();
					result2.close();
					stmt.close();
					conn.close();
				}catch(Exception e){
					e.printStackTrace();
					}
			}
		%>
	
</body>
</html>
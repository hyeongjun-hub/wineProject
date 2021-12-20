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
<title>Field Input</title>
</head>
<body>
	<%
		String dbName = "WineProject";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
		String dbUser = "root";
		String dbPass = "1221";
			
		Connection conn = null;
		Statement stmt = null;
		String vineyard_ID = request.getParameter("vineyard_ID");
		int money = Integer.parseInt(request.getParameter("money"));	
		try{
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			String fieldQuery = "select * from Field where vineyard_ID is null and (area * 10) < " + money + ";";
			ResultSet fieldResult = stmt.executeQuery(fieldQuery);
			ResultSet fieldResult2 = stmt.executeQuery(fieldQuery);
			ResultSet fieldResult3 = stmt.executeQuery(fieldQuery);
	%>
	<h3>현재 구입 가능한 포도밭 내역</h3>
	<table border="1">
		<tr>
			<td>포도밭ID</td>
			<td>위치</td>
			<td>면적</td>
			<td>종류</td>
		</tr>
			<% while(fieldResult.next()){%>
		<tr>
			<td><%=fieldResult.getString(1)%></td>
			<td><%=fieldResult.getString(2)%></td>
			<td><%=fieldResult.getInt(3)%></td>
			<td><%=fieldResult.getString(4)%></td>
			<%} %>
		</tr>
	</table>

	<h3>농장 "<%=vineyard_ID %>" 소속 새로운 포도밭 구매</h3>
	잔고 : <%=money %>
	<form action="fieldMiddle.jsp" method="get">
		<div>
			포도밭 ID :
			<select name="field_ID" required><%while(fieldResult2.next()){ %>
				<option value=<%=fieldResult2.getString(1)%>><%=fieldResult2.getString(1) %></option>
			<%} %>
			</select>
			<input type="text" name="vineyard_ID" hidden=true value=<%=vineyard_ID%>>
			<br><br>
			<button type="submit">구매</button>
		</div>
	</form>

	<%
			}catch(Exception e){
				System.out.println("error");
			}
			String backUrl = request.getHeader("referer");
		
	%>
	<br>
	<button onclick="location.href='<%=backUrl %>'">돌아가기</button>
	
</body>	
</html>
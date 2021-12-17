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
		ResultSet result = null;
		String vineyard_ID = request.getParameter("vineyard_ID");
			
		try{
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			String query = "select vineyard_ID from Vineyard";
			String fieldQuery = "select * from Field";
			ResultSet fieldResult = stmt.executeQuery(fieldQuery);
			result = stmt.executeQuery(query);
	%>
	<h3>현재 모든 포도밭ID 내역</h3>
	<table border="1">
		<tr>
			<th>포도밭_ID</th>
			<% while(fieldResult.next()){
		%>
			<td><%=fieldResult.getString(1)%></td>

			<%} %>
		</tr>
	</table>

	<h2>포도밭 구매</h2>
	<form action="fieldMiddle.jsp" method="get">
		<div>
			포도밭 ID<input required type="text" name="field_ID" placeholder="중복되지않게 입력하세요"><br>
			지역<input required type="text" name="location" placeholder="지역(시)를 입력하세요"><br>
			면적<input required type="number" name="area" placeholder="면적을 입력하세요"><br>
			종류<select required name="variety">
				<option value="red">레드</option>
				<option value="white">화이트</option>
			</select><br>
			<input type="text" name="vineyard_ID" hidden=true value=<%=vineyard_ID%>>
			<br>
			<button type="submit">전송</button>
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
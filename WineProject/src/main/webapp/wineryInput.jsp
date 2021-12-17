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
<title>Vineyard Input Screen</title>
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

	try {
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		String query = "select vineyard_ID from Vineyard";
		result = stmt.executeQuery(query);
	%>
	<h3>현재 모든 포도농장ID 내역</h3>	
	<table border="1">
		<tr>
			<th>포도농장ID</th>
			<% while(result.next()){
		%>
			<td><%=result.getString(1)%></td>

			<%} %>
		</tr>
	</table>
	
	<h1>포도농장 등록</h1>
	<form action="vineyardMiddle.jsp" method="get">
		<div>
			포도농장ID<input type="text" name="vineyard_ID" required
				placeholder="중복되지않게 입력하세요"><br> 
			주인<input type="text" required
				name="owner" placeholder="성함을 입력하세요"><br> 
			주소<input required
				type="text" name="address" placeholder="위치 주소를 남겨주세요"><br>
			전화번호<input type="text" name="tel_number"
				placeholder="'-' 생략"><br> 
			잔고(리라)<input required
				type="number" name="money" placeholder="초기자금을 입력하세요"><br>
			
			<button type="submit">완료</button>
		</div>
	</form>
	<%
	} catch (Exception e) {System.out.println("error");}
	String backUrl = request.getHeader("referer");
	%>
	<br>
	<button onclick="location.href='<%=backUrl%>'">돌아가기</button>
</body>
</html>
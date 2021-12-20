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
<title>wineryInput Screen</title>
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
		String query = "select winery_ID from winery";
		String vineyardQuery = "select * from vineyard";
		String gradeQuery = "select * from winegrade";
		result = stmt.executeQuery(query);
		ResultSet vineyardResult = stmt.executeQuery(vineyardQuery);
		ResultSet gradeResult = stmt.executeQuery(gradeQuery);
	%>
	<h3>현재 모든 양조장ID 내역</h3>	
	<table border="1">
		<tr>
			<th>양조장ID</th>
			<% while(result.next()){
		%>
			<td><%=result.getString(1)%></td>

			<%} %>
		</tr>
	</table>
	
	<h1>양조장 등록</h1>
	<form action="wineryMiddle.jsp" method="get">
		<div>
			양조장ID<input type="text" name="winery_ID" required
				placeholder="중복되지않게 입력하세요"><br> 
			주인<input type="text" required
				name="owner" placeholder="성함을 입력하세요"><br>
			주소<input required
				type="text" name="address" placeholder="위치 주소를 남겨주세요"><br>
			전화번호<input type="text" name="tel_number" required
				placeholder="'-' 생략"><br> 
			등급선택<select required name=grade_ID><%while(gradeResult.next()){ %>
				<option value=<%=gradeResult.getString("grade_ID") %>><%=gradeResult.getString("title") %></option>
				<%} %>
			</select><br>
			포도농장선택<select name=vineyard_ID><%while(vineyardResult.next()){ %>
				<option value=<%=vineyardResult.getString("vineyard_ID") %>><%=vineyardResult.getString("vineyard_ID") %></option>
				<%} %>
			</select><br>
			잔고(리라)<input required name="money" placeholder="초기자금을 입력학세요" type="number" >
			<br><br>
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
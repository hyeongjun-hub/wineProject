<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>all field</title>
</head>
<body>
	<%
	String dbName = "WineProject";
	String dbTable = "field";
	String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
	String dbUser = "root";
	String dbPass = "1221";

	Connection conn = null;
	Statement stmt = null;
	ResultSet result = null;

	String query = "select * from " + dbTable + ";";
	int amountSum = 0;
	Random random = new Random();
	String generatedString = random.ints(48, 123).filter(i->(i<=57 || i >= 65) && (i<=90 || i>= 97)).limit(5).collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();
	
	try {
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		result = stmt.executeQuery(query);
	%>
	<h3>
		모든 포도밭 정보
	</h3>
	<table border=1>
		<tr>
			<td>field_ID</td>
			<td>위치</td>
			<td>면적</td>
			<td>품종</td>
			<td>소속포도농장</td>
		</tr>

		<%
		while (result.next()) {
		%>
		<tr>
			<td><%=result.getString(1)%></td>
			<td><%=result.getString(2)%></td>
			<td><%=result.getInt(3)%></td>
			<td><%=result.getString(4)%></td>
			<td><%=result.getString(5)%></td>
		</tr>
		<%}
		%>
	</table>
	ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	<h3>포도밭 만들기</h3>
	<form action="fieldMiddle.jsp" method="get">
			<input required type="text" name="field_ID" value=<%=generatedString %> hidden=true><br>
			지역<input required type="text" name="location" placeholder="지역(시)를 입력하세요"><br>
			면적<input required type="number" name="area" placeholder="면적을 입력하세요"><br>
			종류<select required name="variety">
				<option value="red">레드</option>
				<option value="white">화이트</option>
			</select><br>
			<br>
			<button type="submit">전송</button>
	</form>
	<p>
		<button onclick="location='home.jsp'">홈으로 돌아가기</button>
	</p>
		<%
		} catch (NumberFormatException e) {
		%>

		<h1>이런!</h1>
	<p>
		올바른 정보를 입력해주세요 ..
		<%
	} finally {
	try {
		result.close();
		stmt.close();
		conn.close();

	} catch (Exception e) {
		e.printStackTrace();
	}
	}
	%>
	
</body>
</html>
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
<title>field</title>
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
	ResultSet productionResult = null;
	ResultSet sumResult = null;
	String field_ID = request.getParameter("field_ID");
	String vineyard_ID = (String) session.getAttribute("vineyard_ID");

	String query = "select * from " + dbTable + " where field_ID = '" + field_ID + "';";
	String productionQuery = "select * from grapeproduction where field_ID= '" + field_ID + "';";
	String sumQuery = "select sum(amount) from grapeproduction where field_ID='" + field_ID + "';";
	int amountSum = 0;

	try {
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		result = stmt.executeQuery(query);
		productionResult = stmt.executeQuery(productionQuery);
		sumResult = stmt.executeQuery(sumQuery);
	%>
	<%!int area;%>
	<%!String variety;%>
	<%!int amountSum; %>
	<h3>
		포도밭 "<%=field_ID%>"의 상세정보
	</h3>
	<table border=1>
		<tr>
			<td>field_ID</td>
			<td>위치</td>
			<td>면적</td>
			<td>품종</td>
		</tr>

		<%
		while (result.next()) {
			area = result.getInt(3);
			variety = result.getString(4);
		%>
		<tr>
			<td><%=result.getString(1)%></td>
			<td><%=result.getString(2)%></td>
			<td><%=area%></td>
			<td><%=variety%></td>
		</tr>

		<%
		}
		%>
	</table>
	<br>
	<button onclick="location='fieldEdit.jsp?field_ID=<%=field_ID%>'">수정</button>

	<br>
	<h3>
		"<%=field_ID%>"밭의 연도별 포도 생산량
	</h3>
	<table border=1>
		<tr>
			<td>생산ID</td>
			<td>생산년도</td>
			<td>생산량</td>
			<td>소속 포도밭ID</td>
		</tr>

		<%
		while (productionResult.next()) {
		%>
		<tr>
			<td><%=productionResult.getString(1)%></td>
			<td><%=productionResult.getInt(2)%></td>
			<td><%=productionResult.getInt(3)%></td>
			<td><%=productionResult.getString(4)%></td>
		</tr>
		<%
		}
		%>
	</table>
	<span>"<%=field_ID%>"밭의 2021년 총 포도생산량:
	</span>
	<%
	while (sumResult.next()) {
		amountSum = sumResult.getInt(1);
		area -= amountSum;
	%>
	<span><%=amountSum%></span>
	<%
	}
	%>

	<br>
	<br>
	<button
		onclick="location='grapeProduction.jsp?field_ID=<%=field_ID%>&possibleArea=<%=area%>&variety<%=variety%>'">생산</button>
	<p>
		<button
			onclick="location='vineyardDetail.jsp?vineyard_ID=<%=vineyard_ID%>'">돌아가기</button>
		<button onclick="location='home.jsp'">홈으로 돌아가기</button>
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
		productionResult.close();
		sumResult.close();
		stmt.close();
		conn.close();

	} catch (Exception e) {
		e.printStackTrace();
	}
	}
	%>
	
</body>
</html>
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
<title>vineyardDetail</title>
</head>
<body>
	<%
	String jdbcDriver = "jdbc:mariadb://localhost:3306/WineProject";
	String dbUser = "root";
	String dbPass = "1221";

	Connection conn = null;
	Statement stmt = null;
	ResultSet result = null;
	ResultSet fieldResult = null;
	ResultSet fieldResult2 = null;
	String vineyard_ID = request.getParameter("vineyard_ID");
	session.setAttribute("vineyard_ID", vineyard_ID);

	String vineQuery = "select * from vineyard where vineyard_ID = '" + vineyard_ID + "';";
	String fieldQuery = "select * from field where vineyard_ID = '" + vineyard_ID + "';";

	try {
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		result = stmt.executeQuery(vineQuery);
		fieldResult = stmt.executeQuery(fieldQuery);
		fieldResult2 = stmt.executeQuery(fieldQuery);
		
		int money = 0;

	%>
	<h3>
		"<%=vineyard_ID%>" 포도농장 상세정보
	</h3>
	<table border=1>
		<tr>
			<td>농장ID</td>
			<td>주인</td>
			<td>주소</td>
			<td>전화번호</td>
			<td>백포도양</td>
			<td>적포도양</td>
			<td>잔고(리라)</td>
		</tr>
		<%
		while (result.next()) {
			money = result.getInt(7);
		%>
		<tr>
			<td><%=result.getString(1)%></td>
			<td><%=result.getString(2)%></td>
			<td><%=result.getString(3)%></td>
			<td><%=result.getString(4)%></td>
			<td><%=result.getInt(5)%></td>
			<td><%=result.getInt(6)%></td>
			<td><%=money%></td>
		</tr>
		<%
		}
		%>
	</table>

	<button
		onClick="location='vineyardEdit.jsp?vineyard_ID=<%=vineyard_ID%>'">수정</button>
	<br>
	<br> 포도농장 "<%=vineyard_ID%>" 의 밭 목록
	<table border=1>
		<tr>
			<td>밭ID</td>
			<td>면적</td>
			<td>품종</td>
		</tr>
		<%
		while (fieldResult.next()) {
		%>
		<tr>
			<td><%=fieldResult.getString(1)%></td>
			<td><%=fieldResult.getInt(3)%></td>
			<td><%=fieldResult.getString(4)%></td>
		</tr>
		<%
		}
		%>
	</table>

	<form action="field.jsp" method="get">
		<p>
			밭 ID선택 <select name="field_ID">
				<%
				while (fieldResult2.next()) {
					String field_ID = fieldResult2.getString(1);
				%>
				<option value='<%=field_ID%>'><%=field_ID%></option>
				<%
				}
				%>
			</select>
			<button type="Submit">해당 밭 상세보기</button>
	</form>
	<p>
		<button
			onClick="location='fieldInput.jsp?vineyard_ID=<%=vineyard_ID%>&money=<%=money%>'">포도밭
			구매</button>
	<p>
		<button onClick="location='vineyard.jsp'">돌아가기</button>
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
		fieldResult.close();
		fieldResult2.close();
		stmt.close();
		conn.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
	}
	%>
	
</body>
</html>
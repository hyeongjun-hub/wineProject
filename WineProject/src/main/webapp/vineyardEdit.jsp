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
		String vineyard_ID = request.getParameter("vineyard_ID");
		String vineQuery = "select * from vineyard where vineyard_ID=" +vineyard_ID + ";";
		
		try{
			String driver = "org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			result = stmt.executeQuery(vineQuery);
			result2 = stmt.executeQuery(vineQuery);
			%>
	<h3> 포도농장 상세정보 </h3>
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
			while(result.next()){
				%>
		<tr>
			<td><%=result.getString(1) %></td>
			<td><%=result.getString(2) %></td>
			<td><%=result.getString(3) %></td>
			<td><%=result.getString(4) %></td>
			<td><%=result.getInt(5) %></td>
			<td><%=result.getInt(6) %></td>
			<td><%=result.getInt(7) %></td>
		</tr>
		<%} %>
	</table>

	<br>
	
	<form action="vineyardEditMiddle.jsp" method="get">
		<% while(result2.next()){ %>
		<div>
			<h3>포도농장 정보 수정하기</h3>
			<input type="text" name="vineyard_ID"
				value=<%=vineyard_ID %> hidden=true><br> 
			주인<input type="text"
				name="owner" value=<%=result2.getString(2) %> placeholder="성함을 입력하세요"><br>
			주소<input
				type="text" name="address" value=<%=result2.getString(3) %> placeholder="위치 주소를 남겨주세요"><br>
			전화번호<input type="text" name="tel_number"
				value=<%=result2.getString(4) %> placeholder="'-' 생략"><br> 
			잔고(리라)<input
				type="number" name="money" value=<%=result2.getInt(7) %>><br>
			<br>
			<button type="submit">수정완료</button>
		<%} %>
		</div>
	</form>
	<br>
	<button onClick="location='vineyardDetail.jsp?vineyard_ID=<%=vineyard_ID %>'">돌아가기</button>

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
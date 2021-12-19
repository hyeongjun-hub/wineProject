<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>all grapeTrade</title>
</head>
<body>
	<%
		String jdbcDriver = "jdbc:mariadb://localhost:3306/WineProject";
		String dbUser = "root";
		String dbPass = "1221";
	
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		
		String grapeTradeQuery = "select * from grapeTrade;";
		
		try{
			String driver = "org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			result = stmt.executeQuery(grapeTradeQuery);
			%>
		<h3> 포도농장과 와인양조장 사이의 연도별 거래내역</h3>
		<table border=1> 
			<tr>
				<td>포도거래ID</td><td>거래년도</td><td>포도농장ID</td><td>양조장ID</td>
				<td>포도종류</td><td>거래양</td>
			</tr>
			<%
			while(result.next()){
				%>
			<tr>
				<td><%=result.getString(1) %></td>
				<td><%=result.getString(2) %></td>
				<td><%=result.getString(5) %></td>
				<td><%=result.getString(6) %></td>
				<td><%=result.getString(3) %></td>
				<td><%=result.getInt(4) %></td>
			</tr>
			<%} %>
		</table>
		
		<br><br>
		<button onClick="location='home.jsp'">홈으로 이동</button>
		
	<%
		} catch(NumberFormatException e){
	%>
	<h1>이런!</h1>
	<p>
		올바른 정보를 입력해주세요 ..
		<%
		}finally{
			try{
				result.close();
				stmt.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	%>
</body>
</html>
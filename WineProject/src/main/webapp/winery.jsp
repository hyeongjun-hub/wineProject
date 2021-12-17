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
<title>wineryList</title>
</head>
<body>
	<%
		String dbName = "WineProject";
		String dbTable = "winery";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
		String dbUser = "root";
		String dbPass = "1221";
		String query = "";
	
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		ResultSet result2 = null;
		
		query = "select * from " + dbTable + ";";
		
		
		try{
			String driver = "org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			result = stmt.executeQuery(query);
			%>
	<h3>양조장 리스트</h3>
	<table border=1>
		<tr>
			<td>양조장ID</td>
			<td>주인</td>
			<td>주소</td>
		</tr>

		<%
			while(result.next()){
				%>
		<tr>
			<td><%=result.getString(1) %></td>
			<td><%=result.getString(2) %></td>
			<td><%=result.getString(3) %></td>
		</tr>
		<%
			} 
			result2 = stmt.executeQuery(query);
			%>

	</table>

	<form action="wineryDetail.jsp" method="get">
		<p>
			양조장 ID선택 <select name="winery_ID">
				<% while(result2.next()){
						String winery_ID = result2.getString(1);%>
				<option value=<%=winery_ID %>><%=winery_ID %></option>
				<% }%>
			</select>
			<button type="Submit">양조장 상세보기</button>
	</form>

	<button onclick="location='wineryInput.jsp'">새로운 양조장 등록</button>
	<br><br>
	<button onClick="location='home.jsp'">홈으로 돌아가기</button>
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
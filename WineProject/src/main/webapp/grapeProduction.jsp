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
<title>grapeProduction</title>
</head>
<body>
	<%
		String dbName = "WineProject";
		String dbTable = "grapeProduction";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
		String dbUser = "root";
		String dbPass = "1221";
		String query;
	
		Connection conn = null;
		Statement stmt = null;
		ResultSet productionResult = null;
		
		String field_ID = request.getParameter("field_ID");
		int area =  Integer.parseInt(request.getParameter("possibleArea"));
		String variety = request.getParameter("variety");
		query = "select * from " + dbTable + ";";
		
		
		try{
			String driver = "org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			productionResult = stmt.executeQuery(query);
			String backUrl = request.getHeader("referer");
			%>
	<h3>현재 모든 포도생산ID 내역</h3>
	<table border="1">
		<tr>
			<th>포도밭_ID</th>
			<% while(productionResult.next()){
		%>
			<td><%=productionResult.getString(1)%></td>

			<%} %>
		</tr>
	</table>
	
	<h3>"<%=field_ID%>"밭의 포도생산 (가능 최대생산량: <%=area %>)</h3>
	<form action="grapeProductionMiddle.jsp" method="get">
		<div>
			포도생산ID<input type="text" name="GP_ID" required
				placeholder="중복되지않게 입력하세요"><br> 
			년도<input type="number" value=2021 required
				name="year" placeholder="생산년도를 입력하세요"><br>
			생산량<input required
				type="number" name="amount" placeholder="생산량을 입력하세요" max=<%=area %>><br>
			<input type="text" name="field_ID" hidden="true" value=<%=field_ID %>
				placeholder=""><br> 
			<input type="text" name="variety" hidden="true" value=<%=variety %>><br>
			
			<button type="submit">생산 완료</button>
		</div>
	</form>

	<br>
	<button onclick="location.href='<%=backUrl %>'">돌아가기</button>
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
				productionResult.close();
				stmt.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	%>
	
</body>
</html>
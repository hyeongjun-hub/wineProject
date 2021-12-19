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
<title>wineryProduction Input Screen</title>
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
	ResultSet categoryResult = null;
	ResultSet invResult = null;
	String winery_ID = request.getParameter("winery_ID");
	String invQuery = "select inv_red, inv_white from winery where winery_ID ='" + winery_ID +"';";
	String IDQuery = "select WP_ID from wineProduction;";
	String categoryQuery = "select * from wineCategory";
	
	try {
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		result = stmt.executeQuery(IDQuery);
		categoryResult = stmt.executeQuery(categoryQuery);
		invResult = stmt.executeQuery(invQuery);
	%>
	
	
	
	<h3>양주레시피</h3>
	<div>red = red(1)</div>
	<div>white = white(1)</div>
	<div>blush = red(1) + white(1)</div>
	<div>sparkling = red(2) + white(1)</div>
	ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	<br><br>
	
	<div><b>현재 모든 양주생산ID 내역</b></div>	
	<table border="1">
		<tr>
			<th>양주생산ID</th>
			<% while(result.next()){
		%>
			<td><%=result.getString(1)%></td>

			<%} %>
		</tr>
	</table>
	<br>
	
	
	ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	<h1>새로운 양주 생산</h1>
	<span>현재 양조장의 </span>
	<%
		while(invResult.next()){
			%><span>적포도수: </span><%=invResult.getInt(1)%>
			<span>백포도수: </span><%= invResult.getInt(2)%><% 
		}
	%>
	<br><br>
	<form action="wineProductionMiddle.jsp" method="get">
		<div>
			양주생산ID<input type="text" name="WP_ID" required
				placeholder="중복되지않게 입력하세요"><br> 
			양주종류<select required name="category_ID">
				<%while(categoryResult.next()){ %>
				<option value="<%=categoryResult.getString(1)%>"><%=categoryResult.getString(2)%></option>
				<%} %>
			</select><br>
			생산년도<input type="number" name="year" required value=2021
				placeholder="거래년도를 입력하세요"><br> 
			생산량<input type="number" name="amount" required
				placeholder="생산량을 입력하세요"><br> 
			<input value=<%=winery_ID %> name="winery_ID" hidden=true/>
			<button type="submit">완료</button>
		</div>
	</form>
	<%
	String backUrl = request.getHeader("referer");
	%>

	<br>
	<button onclick="location='grapeTrade.jsp'">이전 모든 거래 보기</button>
	<br>
	<button onclick="location.href='<%=backUrl%>'">돌아가기</button>
	<button onclick="location='home.jsp'">홈으로 돌아가기</button>
<%
		} catch(NumberFormatException e){
	%>
	<h1>이런!</h1>
	<p>
		올바른 정보를 입력해주세요 ..
		<%
		}finally{
			try{
				categoryResult.close();
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
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
<title>wineTrade Input Screen</title>
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
	ResultSet invResult = null;
	ResultSet categoryResult = null;
	String winery_ID = request.getParameter("winery_ID");
	String query = "select * from wineTrade;";
	String invQuery = "select * from wineInventory where winery_ID= '"+ winery_ID + "';";
	
	try {
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		result = stmt.executeQuery(query);
		invResult = stmt.executeQuery(invQuery);
		categoryResult = stmt.executeQuery(invQuery);
	%>
	
	
	<div><b>현재 모든 양주판매ID 내역</b></div>	
	<table border="1">
		<tr>
			<th>양주판매ID</th>
			<% while(result.next()){
		%>
			<td><%=result.getString(1)%></td>

			<%} %>
		</tr>
	</table>
	<br>
	
	
	ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	<h1>양주 판매</h1>
	<span>현재 양조장 잔여 와인수량</span><br>
	<%
		while(invResult.next()){
			if(invResult.getString(2).equals("00010")){%>
			<span>레드와인: </span><%=invResult.getInt(3)%> <%} %><%
			else if(invResult.getString(2).equals("00020")){ %>
			<span>화이트와인: </span><%=invResult.getInt(3)%> <%} %><%
			else if(invResult.getString(2).equals("00030")){ %>
			<span>블러쉬와인: </span><%=invResult.getInt(3)%> <%} %><%
			else{ %>
			<span>스파클링와인: </span><%=invResult.getInt(3)%> <%}
		}
	%>
	<br><br>
	<form action="wineTradeMiddle.jsp" method="get">
		<div>
			양주판매ID<input type="text" name="WT_ID" required
				placeholder="중복되지않게 입력하세요"><br> 
			양주종류<select required name="category_ID">
				<%while(categoryResult.next()){ %>
				<option value="<%=categoryResult.getString(2)%>"><%=categoryResult.getString(2)%></option>
				<%} %>
			</select><br>
			생산년도<input type="number" name="year" required value=2021
				placeholder="판매년도를 입력하세요"><br> 
			판매량<input type="number" name="amount" required
				placeholder="판매량을 입력하세요"><br> 
			<input value=<%=winery_ID %> name="winery_ID" hidden=true/>
			<br>
			<button type="submit">완료</button>
		</div>
	</form>
	<%
	String backUrl = request.getHeader("referer");
	%>

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
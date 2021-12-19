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
<title>grapeTrade Input Screen</title>
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
	String winery_ID = request.getParameter("winery_ID");
	String vineyard_ID = request.getParameter("vineyard_ID");
	int money = Integer.parseInt(request.getParameter("money"));
	String IDQuery = "select GT_ID from grapeTrade;";
	String invQuery = "select inv_red, inv_white from vineyard where vineyard_ID ='" +vineyard_ID +"';";
	
	try {
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		result = stmt.executeQuery(IDQuery);
		invResult = stmt.executeQuery(invQuery);
	%>
	<h3>현재 모든 포도거래ID 내역</h3>	
	<table border="1">
		<tr>
			<th>포도거래ID</th>
			<% while(result.next()){
		%>
			<td><%=result.getString(1)%></td>

			<%} %>
		</tr>
	</table>
	
	<h1>새로운 포도 거래</h1>
	<span>보유 리라: <%=money %></span><br>
	<span>거래하는 포도농장의 </span>
	<%
		while(invResult.next()){
			%><span>적포도수: </span><%=invResult.getInt(1)%>
			<span>백포도수: </span><%= invResult.getInt(2)%><% 
		}
	%>
	<br><br>
	
	<form action="grapeTradeMiddle.jsp" method="get">
		<div>
			포도거래ID<input type="text" name="GT_ID" required
				placeholder="중복되지않게 입력하세요"><br> 
			년도<input type="number" required
				name="year" value=2021 placeholder="성함을 입력하세요"><br> 
			포도종류<select required name="variety">
				<option value="red">적포도</option>
				<option value="white">백포도</option>
			</select><br>
			거래량<input type="number" name="amount" required min=1 max=<%=money %>
				placeholder="거래개수를 입력하세요"><br> 
			<input value=<%=vineyard_ID %> name="vineyard_ID" hidden=true/>
			<input value=<%=winery_ID %> name="winery_ID" hidden=true/>
			<button type="submit">완료</button>
		</div>
	</form>
	<%
	} catch (Exception e) {System.out.println("error");}
	String backUrl = request.getHeader("referer");
	%>
	<br>
	<button onclick="location='grapeTrade.jsp'">이전 모든 거래 보기</button>
	<br>
	<button onclick="location.href='<%=backUrl%>'">돌아가기</button>
	<button onclick="location='home.jsp'">홈으로 돌아가기</button>
</body>
</html>
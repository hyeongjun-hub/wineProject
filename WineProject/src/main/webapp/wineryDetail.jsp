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
<title>wineryDetail</title>
</head>
<body>
	<%
		String jdbcDriver = "jdbc:mariadb://localhost:3306/WineProject";
		String dbUser = "root";
		String dbPass = "1221";
	
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		ResultSet tradeResult = null;
		ResultSet productionResult = null;
		ResultSet inventoryResult = null;
		String winery_ID = request.getParameter("winery_ID");
		session.setAttribute("winery_ID", winery_ID);
		
		String wineQuery = "select * from winery where winery_ID = " + winery_ID +";";
		String tradeQuery = "select * from winetrade where winery_ID = " + winery_ID + ";";
		String productionQuery = "select * from wineproduction where winery_ID = " + winery_ID + ";";
		String inventoryQuery = "select * from wineInventory where winery_ID = " + winery_ID + ";";
		
		try{
			String driver = "org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			result = stmt.executeQuery(wineQuery);
			tradeResult = stmt.executeQuery(tradeQuery);
			productionResult = stmt.executeQuery(productionQuery);
			inventoryResult = stmt.executeQuery(inventoryQuery);
			%>
		<%! int money;%>
		<%! String vineyard_ID;%>
		<h3>"<%=winery_ID %>" 양조장 상세정보</h3>
		<table border=1> 
			<tr>
				<td>양조장ID</td><td>주인</td><td>주소</td>
				<td>전화번호</td><td>백포도양</td><td>적포도양</td><td>잔고(리라)</td><td>등급</td><td>거래포도농장</td>
			</tr>
			<%
			while(result.next()){
				money = result.getInt(7);
				vineyard_ID = result.getString(9);
				%>
			<tr>
				<td><%=result.getString(1) %></td>
				<td><%=result.getString(2) %></td>
				<td><%=result.getString(3) %></td>
				<td><%=result.getString(4) %></td>
				<td><%=result.getInt(5) %></td>
				<td><%=result.getInt(6) %></td>
				<td><%=money %></td>
				<td><%=result.getString(8) %></td>
				<td><%=vineyard_ID %></td>
			</tr>
			<%} %>
		</table>
		
		<button onClick="location='wineryEdit.jsp?winery_ID=<%=winery_ID%>'">수정</button>
		<button onClick="location='grapeTradeNew.jsp?vineyard_ID=<%=vineyard_ID%>&winery_ID=<%=winery_ID%>&money=<%=money%>'">포도구매</button>
		<br><br>
		
		양조장 "<%=winery_ID %>" 의 재고목록
		<table border=1>
			<tr>
				<td>재고ID</td><td>와인종류</td><td>수량</td>
			</tr>
			<%
			while(inventoryResult.next()){
				%>
			<tr>       
				<td><%=inventoryResult.getString(1) %></td>
				<td><%=inventoryResult.getString(2) %></td>
				<td><%=inventoryResult.getInt(3) %></td>
			</tr>
			<%} %>
		</table>
		<br>
		양조장 "<%=winery_ID %>" 의 생산량
		<table border=1>
			<tr>
				<td>생산ID</td><td>와인종류</td><td>생산년도</td><td>수량</td>
			</tr>
			<%
			while(productionResult.next()){
				%>
			<tr>
				<td><%=productionResult.getString(1) %></td>
				<td><%=productionResult.getString(2) %></td>
				<td><%=productionResult.getInt(3) %></td>
				<td><%=productionResult.getInt(4) %></td>
			</tr>
			<%} %>
		</table>
		<button onClick="location='wineryProductionNew.jsp?winery_ID=<%=winery_ID%>'">생산</button>
		<!-- 만들어야함 -->
		<br><br>
		
		양조장 "<%=winery_ID %>" 의 판매량
		<table border=1>
			<tr>
				<td>판매ID</td><td>와인종류</td><td>판매년도</td><td>수량</td>
			</tr>
			<%
			while(tradeResult.next()){
				%>
			<tr>
				<td><%=tradeResult.getString(1) %></td>
				<td><%=tradeResult.getString(2) %></td>
				<td><%=tradeResult.getInt(3) %></td>
				<td><%=tradeResult.getInt(4) %></td>
			</tr>
			<%} %>
		</table>
		<button onClick="location='wineTrade.jsp?winery_ID=<%=winery_ID%>'">판매</button>
		<!-- 만들어야함 -->
		
		
	<p>
	<button onClick="location='winery.jsp'">돌아가기</button>
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
				tradeResult.close();
				productionResult.close();
				inventoryResult.close();
				stmt.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	%>
</body>
</html>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>middle</title>
</head>
<body>
	<%
		String dbName = "WineProject";
		String dbTable = "wineTrade";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
		String dbUser = "root";
		String dbPass = "1221";
		
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet priceResult = null;
		
		String winery_ID = request.getParameter("winery_ID");
		String WT_ID = request.getParameter("WT_ID");
		String category_ID = request.getParameter("category_ID");
		int year = Integer.parseInt(request.getParameter("year"));
		int amount = Integer.parseInt(request.getParameter("amount"));
		String query = "Insert into " + dbTable +" values('"+ WT_ID +"', '" + category_ID + "', " +
				 year + ", " + amount + ", '" + winery_ID + "');";
		String findPrice = "select a.WT_ID, a.title, a.standardPrice, g.title, g.ratio from (select * from wineTrade natural join winery natural join wineCategory) as a, wineGrade as g where a.grade_ID = g.grade_ID;";
		int price = 0;
		String invQuery = "update wineInventory set amount = amount - " + amount + " where category_ID = '" + category_ID + "' and winery_ID = '" + winery_ID + "';";
		
		try{
			String driver = "org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			priceResult = stmt.executeQuery(findPrice);
			stmt.executeUpdate(query);
			stmt.executeUpdate(invQuery);
			while(priceResult.next()){
				price = priceResult.getInt(3)*priceResult.getInt(5)*amount;
			}
			String moneyQuery = "update winery set money= money +" + price + " where winery_ID = '" + winery_ID + "';";
			stmt.executeUpdate(moneyQuery);
	%>
	<p>성공적으로 데이터베이스 <%=dbName%>. <%=dbTable%> table에 등록하였습니다.
	<br>
	<button onclick="location='wineryDetail.jsp?winery_ID=<%=winery_ID%>'">양조장으로 돌아가기</button>
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
				priceResult.close();
				stmt.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	%>
</body>
</html>
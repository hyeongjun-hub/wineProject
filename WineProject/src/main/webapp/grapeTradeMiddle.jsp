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
<title>grapeTrade completed</title>
</head>
<body>
	<%
		String dbName = "WineProject";
		String dbTable = "grapeTrade";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
		String dbUser = "root";
		String dbPass = "1221";
	
		Connection conn = null;
		Statement stmt = null;
		
		String vineyard_ID = request.getParameter("vineyard_ID");
		String winery_ID = request.getParameter("winery_ID");
		String GT_ID = request.getParameter("GT_ID");
		int year = Integer.parseInt(request.getParameter("year"));
		String variety = request.getParameter("variety");
		int amount = Integer.parseInt(request.getParameter("amount"));

		String insertQuery = "Insert into " + dbTable +" values('"+ GT_ID +"', " + year + ", '" +
				variety + "', " + amount + ", '" + vineyard_ID+ "','" + winery_ID + "');";
		try{
			String driver = "org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			stmt.executeUpdate(insertQuery);
			
			String updateVineyardQuery;
			String updateWineryQuery;
			String moneyQuery = "update winery set money= money -" + amount + " where winery_ID='" + winery_ID +"';";
			String moneyQuery2 = "update vineyard set money= money +" + amount + " where vineyard_ID='" + vineyard_ID + "';";
			if (variety.equals("red")){
				updateVineyardQuery = "update vineyard set inv_red= inv_red - " + amount + " where vineyard_ID ='" + vineyard_ID + "';";
				updateWineryQuery = "update winery set inv_red= inv_red + " + amount + " where winery_ID ='" + winery_ID + "';";
			}else{ 
				updateVineyardQuery = "update vineyard set inv_white= inv_white - " + amount + " where vineyard_ID ='" + vineyard_ID + "';"; 
				updateWineryQuery = "update winery set inv_white= inv_white + " + amount + " where winery_ID ='" + winery_ID + "';";
			}
			stmt.executeUpdate(updateVineyardQuery);
			stmt.executeUpdate(updateWineryQuery);
			stmt.executeUpdate(moneyQuery);
			stmt.executeUpdate(moneyQuery2);
	%>
	<p>
		성공적으로 거래가 완료되었습니다.
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
				stmt.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	%>
</body>
</html>
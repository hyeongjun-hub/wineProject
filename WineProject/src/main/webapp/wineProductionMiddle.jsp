<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>wineProduction completed</title>
</head>
<body>
	<%
		String dbName = "WineProject";
		String dbTable = "wineProduction";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
		String dbUser = "root";
		String dbPass = "1221";
	
		Connection conn = null;
		Statement stmt = null;
		ResultSet amountResult = null;
		
		String winery_ID = request.getParameter("winery_ID");
		String WP_ID = request.getParameter("WP_ID");
		int year = Integer.parseInt(request.getParameter("year"));
		String category_ID = request.getParameter("category_ID");
		int amount = Integer.parseInt(request.getParameter("amount"));
		int existingAmount = 0;

		String insertQuery = "Insert into " + dbTable +" values('"+ WP_ID +"', '" + category_ID+ "', " +
				year + ", " + amount + ",'" + winery_ID + "');";
		String amountQuery = "Select amount from wineInventory where category_ID = '" + category_ID + "' and winery_ID = '" + winery_ID + "';";
				
		try{
			String driver = "org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			stmt.executeUpdate(insertQuery);
			amountResult = stmt.executeQuery(amountQuery);
			while(amountResult.next()){ existingAmount = Integer.parseInt(amountResult.getString(1)); }
			String updateWineryQuery = null;
			String updateWineInventoryQuery;
			Random random = new Random();
			String generatedString = random.ints(48, 123).limit(5).collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();
			if(existingAmount == 0){
				updateWineInventoryQuery = "insert into wineInventory values('" + generatedString + "', '"+ category_ID + "'," + amount + ", '" + winery_ID + "')";
			}else{
				updateWineInventoryQuery = "update wineInventory set amount = amount + " + amount + " where winery_ID = '" + winery_ID + "' and category_ID = '" + category_ID +"';";
			}
			int redAmount;
			/* winery는 variety의 레시피 포도 양만큼 감소하고 wineinventory는 variety 양주 amount만큼 증가한다*/
			switch(category_ID){
			case "00010":
				redAmount = amount;
				updateWineryQuery = "update winery set inv_red= inv_red - " + redAmount + " where winery_ID ='" + winery_ID + "';";
				break;
			case "00020":
				updateWineryQuery = "update winery set inv_white= inv_white - " + amount + " where winery_ID ='" + winery_ID + "';";
				break;
			case "00030":
				redAmount = amount;
				updateWineryQuery = "update winery set inv_white = inv_white - " + amount + ", inv_red = inv_red - " + redAmount + " where winery_ID = '" + winery_ID + "';";
				break;
			case "00040":
				redAmount = amount*2;
				updateWineryQuery = "update winery set inv_red = inv_red - " + redAmount + ", inv_white = inv_white - " + amount + " where winery_ID = '" + winery_ID + "';";
				break;
			default:
				break;
			}
			stmt.executeUpdate(updateWineryQuery);
			stmt.executeUpdate(updateWineInventoryQuery);
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
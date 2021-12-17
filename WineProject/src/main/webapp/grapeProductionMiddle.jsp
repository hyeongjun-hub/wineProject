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
<title>middle</title>
</head>
<body>
	<%!int red; %>
	<%!int white; %>
	<%
		String dbName = "WineProject";
		String dbTable = "grapeProduction";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
		String dbUser = "root";
		String dbPass = "1221";
		String query = "";
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet vineyardResult = null;
		
		String GP_ID = request.getParameter("GP_ID");
		int year = Integer.parseInt(request.getParameter("year"));
		int amount = Integer.parseInt(request.getParameter("amount"));
		String variety = request.getParameter("variety");
		String field_ID = request.getParameter("field_ID");
		String vineyard_ID = (String) session.getAttribute("vineyard_ID");
		
		query = "Insert into " + dbTable +" values('"+ GP_ID +"', " + year + ", " +
				 amount + ",'" + field_ID + "');";
		String sumQuery = "select vineyard_ID, variety, sum(amount) from field natural join grapeproduction where vineyard_ID = '" + vineyard_ID + "' group by variety;";
		try{
			String driver = "org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			stmt.executeUpdate(query);
			vineyardResult = stmt.executeQuery(sumQuery);
			
			
			while(vineyardResult.next()){
				if(vineyardResult.getString(2).equals("red")){
					red = vineyardResult.getInt(3);
				}else{ white = vineyardResult.getInt(3);}
			}
			
			String updateVineyardQuery = "Update vineyard set inv_red=" +red+ ", inv_white=" + white + " where vineyard_ID ='" + vineyard_ID + "';";
			stmt.executeUpdate(updateVineyardQuery);
	%>
	<p>
		성공적으로 데이터베이스
		<%=dbName%>.<%=dbTable%>
		table에 등록하였습니다. <br>
		<button onclick="location='field.jsp?field_ID=<%=field_ID%>'">포도밭으로
			돌아가기</button>
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
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>wineryInput completed</title>
</head>
<body>
	<%
		String dbName = "WineProject";
		String dbTable = "winery";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
		String dbUser = "root";
		String dbPass = "1221";
	
		Connection conn = null;
		Statement stmt = null;
		
		String winery_ID = request.getParameter("winery_ID");
		String vineyard_ID = request.getParameter("vineyard_ID");
		String owner = request.getParameter("owner");
		String address = request.getParameter("address");
		String tel_number = request.getParameter("tel_number");
		String grade_ID = request.getParameter("grade_ID");
		System.out.println(vineyard_ID);
		int money = Integer.parseInt(request.getParameter("money"));
		String query = "Insert into " + dbTable +" values('"+ winery_ID +"', '" + owner + "', '" +
				address + "', '" + tel_number + "', 0, 0, " + money +", '" + grade_ID + "', '" + vineyard_ID + "');";
		try{
			String driver = "org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			stmt.executeUpdate(query);
		
	%>
	<p>
		
		성공적으로 데이터베이스 <%=dbName%>, <%=dbTable%> table에 등록하였습니다.
	
	<button onclick="location='winery.jsp'">양조장으로 돌아가기</button>
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
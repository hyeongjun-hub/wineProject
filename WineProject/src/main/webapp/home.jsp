<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home Screen</title>
</head>
<body>
	<h1>와인 프로젝트</h1>
	<div style="display: flex;">
		<div style="line-height:24px;">
			<div >
				<span><b>포도농장으로 이동하기</b></span>
			</div>
			<div>
				<span><b>와인양조장으로 이동하기</b></span>
			</div>
			<div>밭목록</div>
			<div>
				<span>포도거래내역</span>
			</div>
			<div>와인종류와 와인등급확인</div>
		</div>
		<div>
			<button onclick="location='vineyard.jsp'">포도농장</button><br>
			<button onclick="location='winery.jsp'">와인양조장</button><br>
			<button onclick="location='fieldAll.jsp'">밭목록확인</button><br>
			<button onclick="location='grapeTrade.jsp'">포도거래내역</button><br>
			<button onclick="location='wineCategory.jsp'">와인종류와 와인등급</button><br>
		</div>
	</div>
</body>
</html>
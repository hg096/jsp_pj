<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>

<head>
<title>관리자 페이지</title>
</head>

<!--  severs / tomcat-users.xml  -->
<!-- <role rolename="admin" />
<user username="admin" password="1234" roles="admin" /> -->

<body>
	<jsp:include page="adminMenu.jsp" />

	<br>

	<%!String tagline = "관리자 페이지에  오신것을 환영합니다!";%>

	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

	<div class="container">
		<div class="text-center">
			<h3>
				<%=tagline%>
			</h3>
			<%
			//현재 날짜와 시간을 출력하기 위한 자바코드
			response.setIntHeader("Refresh", 5);
			Date day = new Date();
			String am_pm; //0~12 AM 12~24 PM
			int hour = day.getHours();
			int minute = day.getMinutes();
			int second = day.getSeconds();
			if (hour / 12 == 0) {
				am_pm = "AM";
			} else {
				am_pm = "PM";
				hour = hour - 12;
			}
			String CT = hour + ":" + minute + ":" + second + " " + am_pm;
			out.println("현재 접속 시간: " + CT + "<br>");
			%>
		</div>

		<br> <br> <br> <br> <br> <br> <br> <br> <br>
		<br> <br> <br> <br> <br> <br> <br> <br> <br>
		<br> <br>

		<hr>
		<br>

	</div>
	<jsp:include page="../guest/footer.jsp" />
</body>

</html>
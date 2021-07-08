<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<!-- sql문 사용 -->
<html>

<head>
<title>상품 목록</title>



<jsp:include page="bootS.jsp" />
</head>
<body class="mr-5 ml-5">
	<jsp:include page="menu.jsp" />
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

	<div class="row">
			<br> <br>
		</div>
		<!-- 상품 -->
		<%@ include file="dbconn.jsp"%>
		<div class="col-lg-9 ml-5">
			<br> <br>
			<h2>products</h2>
			<hr>
			
			<br> <br> <br>
			<!-- 상품 -->
			<div class="row">
					<%
					String sql = "select * from product";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
					%>
					<div class="col-md-4">
						<img src="../resources/imagesUpload/<%=rs.getString("fileName")%>" class="w-100">
						<br> <br>
						<h3><%=rs.getString("name")%></h3>
						<p><%=rs.getString("description")%>
						<p><%=rs.getInt("unitPrice")%>원
						<p>
							<a href="./product.jsp?id=<%=rs.getString("p_id")%>" class="btn btn-secondary"
								role="button"
							> 상세 정보 &raquo;</a>
					</div>
					<%
					}
					//디비 연결닫기
					if (rs != null)
					rs.close();
					if (pstmt != null)
					pstmt.close();
					if (conn != null)
					conn.close();
					%>
			</div> 
			<!-- 상품 -->
		</div>
	
	
	<jsp:include page="topButton.jsp" />
	<hr>
	<jsp:include page="footer.jsp" />

</body>

</html>
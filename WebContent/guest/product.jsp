<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<!-- sql문 사용 -->
<%@ include file="dbconn.jsp"%>
<!-- 디비연결 -->
<%@ page errorPage="exceptionNoProductId.jsp"%>

<html>
<head>
<title>상품 상세 정보</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<script type="text/javascript">
	function addToCart() {
		if (confirm("상품을 장바구니에 추가하시겠습니까?")) {
			return; // a 태그를 실행하여 장바구니 담기
		} else {
			return false; // a 태그의 동작을 멈춘다.
		}
	}
</script>
	<br> <br> <br> 
	<%
	String id = request.getParameter("id");
	String sql = "select * from product where p_id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	rs = pstmt.executeQuery();
	if (rs.next()) {
	%>
	<div class="container">
	<hr> <br>
		<div class="row">
			<div class="col-md-5">
				<img src="../resources/imagesUpload/<%=rs.getString("fileName")%>" class="w-100">
			</div>
			<div class="col-md-6">
				<h3><%=rs.getString("name")%></h3>
				<p><%=rs.getString("description")%>
				<p>
					<b>상품 코드 : </b> <span class="badge badge-danger"> <%=rs.getString("p_id")%></span>
				<p>
					<b>분류</b> :
					<%=rs.getString("categoryL")%>
				<h4><%=rs.getInt("unitPrice")%>원
				</h4>
				<p>
					<a href="./addCart.jsp?id=<%=rs.getString("p_id")%>" class="btn btn-info"
						onclick="return addToCart()"
					>상품 주문 &raquo;</a>
					<a href="./cart.jsp" class="btn btn-warning"> 장바구니 &raquo;</a>
					<a href="./products.jsp" class="btn btn-secondary"> 상품 목록 &raquo;</a>
			</div>
		</div>
		<hr>
	</div>
	<%
	}
	if (rs != null)
	rs.close();
	if (pstmt != null)
	pstmt.close();
	if (conn != null)
	conn.close();
	%>
	<jsp:include page="footer.jsp" />
</body>
</html>
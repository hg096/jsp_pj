<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="product.Product"%>
<%@ page import="product.ProductRepository"%>
<%@ include file="dbconn.jsp"%>
<%
request.setCharacterEncoding("UTF-8");

String cartId = session.getId();

String shipping_cartId = "";
String shipping_name = "";
String shipping_shippingDate = "";
String shipping_country = "";
String shipping_zipCode = "";
String shipping_addressName = "";

// 쿠키 불러와서 사용>> 리턴타입은 배열
Cookie[] cookies = request.getCookies();

if (cookies != null) {
	for (int i = 0; i < cookies.length; i++) {
		Cookie thisCookie = cookies[i];
		String n = thisCookie.getName();

		if (n.equals("Shipping_cartId"))
	shipping_cartId = URLDecoder.decode((thisCookie.getValue()), "utf-8");

		if (n.equals("Shipping_name"))
	shipping_name = URLDecoder.decode((thisCookie.getValue()), "utf-8");

		if (n.equals("Shipping_shippingDate"))
	shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()), "utf-8");

		if (n.equals("Shipping_country"))
	shipping_country = URLDecoder.decode((thisCookie.getValue()), "utf-8");

		if (n.equals("Shipping_zipCode"))
	shipping_zipCode = URLDecoder.decode((thisCookie.getValue()), "utf-8");

		if (n.equals("Shipping_addressName"))
	shipping_addressName = URLDecoder.decode((thisCookie.getValue()), "utf-8");
	}
}
%>
<html>
<head>
<title>주문 정보</title>
</head>
<body>
	<jsp:include page="menu.jsp" />

	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

	<div class="container col-8 alert alert-info">
		<hr>
		<br>
		<div class="text-center ">
			<h1>영수증</h1>
		</div>
		<div class="row justify-content-between">
			<div class="col-4" align="left">
				<strong>배송 주소</strong> <br> 성명 :
				<%
 out.println(shipping_name);
 %>
				<br> 우편번호 :
				<%
				out.println(shipping_zipCode);
				%>
				<br> 주소 :
				<%
				out.println(shipping_addressName);
				%>(<%
				out.println(shipping_country);
				%>) <br>
			</div>
			<div class="col-4" align="right">
				<p>
					<em>배송일: <%
					out.println(shipping_shippingDate);
					%></em>
			</div>
		</div>

		<div>
			<table class="table table-hover">
				<tr>
					<th class="text-center">이름</th>
					<th class="text-center">수량</th>
					<th class="text-center">가격</th>
					<th class="text-center">소계</th>
				</tr>
				<%
				int t_Price = 0;
				ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
				if (cartList == null)
					cartList = new ArrayList<Product>();
				for (int i = 0; i < cartList.size(); i++) { // 상품리스트 하나씩 출력하기
					Product product = cartList.get(i);
					int total = product.getUnitPrice() * product.getQuantity();
					t_Price = t_Price + total;
					String p_name = product.getName();
					int amount = product.getQuantity();
					// 주문 완료하면 데이터입력
					String sql = "insert into orders(p_name, amount, m_name, regist_day, t_Price, conditions, postcode, address) values(?,?,?,?,?,?,?,?);";
					pstmt = conn.prepareStatement(sql);

					pstmt.setString(1, p_name);
					pstmt.setInt(2, amount);
					pstmt.setString(3, shipping_name);
					pstmt.setString(4, shipping_shippingDate);
					pstmt.setInt(5, t_Price);
					pstmt.setString(6, "주문완료");
					pstmt.setString(7, shipping_zipCode);
					pstmt.setString(8, shipping_addressName);

					pstmt.executeUpdate();
				%>
				<tr>
					<td class="text-center">
						<em><%=product.getName()%> </em>
					</td>
					<td class="text-center"><%=product.getQuantity()%></td>
					<td class="text-center"><%=product.getUnitPrice()%>원
					</td>
					<td class="text-center"><%=total%>원
					</td>
				</tr>
				<%
				}
				%>
				<tr>
					<td> </td>
					<td> </td>
					<td class="text-right">
						<strong>총액: </strong>
					</td>
					<td class="text-center text-danger">
						<strong><%=t_Price%> </strong>
					</td>
				</tr>
			</table>
			<a href="./shippingInfo.jsp?cartId=<%=shipping_cartId%>" class="btn btn-secondary"
				role="button"
			> 이전 </a>
			<a href="./thankCustomer.jsp" class="btn btn-success" role="button"> 주문 완료 </a>
			<a href="./checkOutCancelled.jsp" class="btn btn-secondary" role="button"> 취소 </a>
		</div>
	</div>
</body>
</html>

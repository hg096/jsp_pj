<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="product.Product"%>
<%@ page import="product.ProductRepository"%>
<html>
<head>

<%
String cartId = session.getId(); //브라우저 접속시 아이디 
%>

<script type="text/javascript">
	function emptyCheck() { // 총합이 0인지 확인
		var sum = document.getElementById("sum");
		if (sum.textContent == "0") {
			alert("장바구니가 비었습니다!");
			return false; //false로 리턴되어 a테그를 동작하지안음
		}
	}
</script>

<title>장바구니</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<br> <br> <br> 
	<div class="container">
	<hr> <br>  
		<div class="row">
			<table width="100%">
				<tr>
					<td align="right">
						<a href="./deleteCart.jsp?cartId=<%=cartId%>" class="btn btn-white"
							style="color: red;"
						>모두 삭제하기</a>
					</td>
				</tr>
			</table>
		</div>

		<div style="padding-top: 50px">
			<table class="table table-hover">
				<tr>
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
				<%
				int sum = 0;
				ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
				if (cartList == null) /* 리스트가 없다면 새로 만들기  */
					cartList = new ArrayList<Product>();

				for (int i = 0; i < cartList.size(); i++) { // 상품리스트 하나씩 출력하기
					Product product = cartList.get(i);
					int total = product.getUnitPrice() * product.getQuantity();
					sum = sum + total;
				%>
				<tr>
					<td><%=product.getPid()%>
						-
						<%=product.getName()%></td>
					<td><%=product.getUnitPrice()%></td>
					<td><%=product.getQuantity()%></td>
					<td><%=total%></td>
					<td>
						<a href="./removeCart.jsp?id=<%=product.getPid()%>" class="badge badge-danger">삭제</a>
					</td>
				</tr>
				<%
				}
				%>
				<tr>
					<th></th>
					<th></th>
					<th>총액</th>
					<th><%=sum%></th>
					<th></th>
				</tr>

			</table>
		</div>
		
		<div class="row">
			<table width="100%">
				<tr>
					<td align="left">
						<a href="./products.jsp" class="btn btn-secondary"> &laquo; 쇼핑 계속하기</a>
					</td>

					<td align="right">
						<a onclick="return emptyCheck();" href="./shippingInfo.jsp?cartId=<%=cartId%>"
							class="btn btn-success"
						>주문하기</a>
					</td>
				</tr>
			</table>
		</div>

		<hr>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>

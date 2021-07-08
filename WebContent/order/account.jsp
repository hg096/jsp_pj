<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="model.OrderDTO"%>

<%
OrderDTO notice = (OrderDTO) request.getAttribute("board"); /* BoardDTO를 받아옴 */
%>

<html>
<!-- 게시판 초기 화면  -->
<head>
<title>주문 결산</title>


</head>
<body>
	<jsp:include page="../admin/adminMenu.jsp" />

	<br> <br> <br> 
	<div class="container">
		<form action="<c:url value="./AccountListAction.do"/>" method="post">
			<input type="hidden" name="newSearch" value="yes" />
			<!-- 검색데이터값을 기록하는 부분 -->
			<div>
				<div class="text-right">
					<span class="badge badge-white"> 전체주문 ${total_record}건 </span>
				</div>
			</div>

			<div style="padding-top: 50px">
				<table class="table table-hover">
					<tr>
						<th>주문번호</th>
						<th>상품이름</th>
						<th>수량</th>
						<th>주문날짜</th>
						<th>총가격</th>
						<th>상태</th>
					</tr>

					<c:forEach var="item" items="${Accountlist}">
						<tr>
							<!-- 주문 번호 -->
							<td>${item.o_num}</td>
							<!-- 상품 이름 -->
							<td>
								<a href="./AccountViewAction.do?num=${item.o_num}&pageNum=${pageNum}">
									${item.p_name}</a>
							</td>
							<!-- 수량 -->
							<td>${item.amount}</td>
							<!-- 주문 날짜 -->
							<td>${item.regist_day}</td>
							<!-- 가격 -->
							<td>${item.t_Price}</td>
							<!-- 상태  -->
							<td>${item.conditions}</td>
						</tr>

						<!-- 결산 부분  -->
						<a hidden="${total = item.amount * item.t_Price}"> </a>
						<a hidden="${sum = sum + total}"> </a>

					</c:forEach>
					<tr>
						<th></th>
						<th></th>
						<th></th>
						<th>총액</th>
						<th>${sum}</th>
						<th></th>
					</tr>
				</table>
			</div>

			<!-- 페이지 넘버링 -->
			<div align="center">
				<c:set var="pageNum" value="${pageNum}" />
				<c:forEach var="i" begin="1" end="${total_page}">
					<a href="<c:url value="./AccountListAction.do?pageNum=${i}" /> ">
						<c:choose>
							<c:when test="${pageNum==i}">
								<font color='4C5317'><b> [${i}]</b></font>
							</c:when>
							<c:otherwise>
								<font color='4C5317'> [${i}]</font>
							</c:otherwise>
						</c:choose>
					</a>
				</c:forEach>
			</div>

			<!-- 게시물 검색기능  -->
			<br>
			<div class="btn-group btn-group-toggle" data-toggle="buttons" align="right">
				<label class="btn btn-secondary"> <select name="items" class="txt">
						<option value="regist_day">주문날짜</option>
					</select>
				</label> <label class="btn btn-secondary"> <input name="text" type="text"
					placeholder="yyyy/mm/dd"
				/> <input type="submit" id="btnAdd" class="btn btn-white btn-sm" style="color: white;"
					value="검색 "
				/>
				</label>
			</div>


		</form>
		<hr>
	</div>
	<jsp:include page="../guest/footer.jsp" />
</body>
</html>


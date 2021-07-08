<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<html>
<!-- 게시판 초기 화면  -->
<head>
<title>주문 삭제, 수정</title>


</head>
<body>
	<jsp:include page="../admin/adminMenu.jsp" />

	<br>
	<br>
	<br>

	<div class="container">
		<form action="<c:url value="./OrderListAction.do"/>" method="post">
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


					<c:forEach var="item" items="${Orderlist}">
						<tr>
							<!-- 번호 -->
							<td>${item.o_num}</td>
							<!-- 제목 -->
							<td>
								<a href="./OrderViewAction.do?num=${item.o_num}&pageNum=${pageNum}">
									${item.p_name}</a>
							</td>
							<!-- 작성일 -->
							<td>${item.amount}</td>
							<!-- 조회수 -->
							<td>${item.regist_day}</td>
							<!-- 글쓴이 -->
							<td>${item.t_Price}</td>

							<td>${item.conditions}</td>
						</tr>
					</c:forEach>

				</table>
			</div>

			<!-- 페이지 넘버링 -->
			<div align="center">
				<c:set var="pageNum" value="${pageNum}" />
				<c:forEach var="i" begin="1" end="${total_page}">
					<a href="<c:url value="./OrderListAction.do?pageNum=${i}" /> ">
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
				<label class="btn"> <select name="items" class="txt btn btn-outline-primary">
						<option value="o_num">주문번호</option>
						<option value="m_name">주문자이름</option>
						<option value="conditions">상태</option>
					</select>
				</label> <label class="btn btn primary"> <input name="text" type="text" /> <input
					type="submit" id="btnSearch" class="btn btn-outline-primary btn-sm" value="검색 "
				/>
				</label>
			</div>


		</form>
		<hr>
	</div>
	<jsp:include page="../guest/footer.jsp" />
</body>
</html>


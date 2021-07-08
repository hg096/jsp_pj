<%@ page contentType="text/html; charset=utf-8"%>

<html>
<head>
<title>배송 정보</title>
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

	<div class="container">
		<hr>
		<br>
		<form action="./processShippingInfo.jsp" class="form-horizontal" method="post">
			<input type="hidden" name="cartId" value="<%=request.getParameter("cartId")%>" />
			<div class="form-group row">
				<label class="col-sm-2">성명</label>
				<div class="col-sm-3">
					<input name="name" type="text" class="form-control" />
				</div>
			</div>

			<div class="form-group row">
				<label class="col-sm-2">배송일</label>
				<div class="col-sm-3">
					<input name="shippingDate" type="date" class="form-control" />
				</div>
			</div>

			<div class="form-group row">
				<label class="col-sm-2">국가명</label>
				<div class="col-sm-3">
					<select name="country" id="country" class="form-control">
						<option value="ko">한국</option>
						<option value="us">미국</option>
						<option value="jp">일본</option>
						<option value="cn">중국</option>
					</select>
				</div>
			</div>

			<div class="form-group row">
				<label class="col-sm-2">우편번호</label>
				<div class="col-sm-3">
					<input type="text" name="zipCode" id="postcode" placeholder="우편번호"
						class="form-control"
					>
				</div>
				<div class="col-sm-4 col-md-2">
					<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"
						class="btn btn-success"
					>
				</div>
			</div>

			<div class="form-group row">
				<label class="col-sm-2">주소</label>
				<div class="col-sm-5">
					<input name="addressName" type="text" id="address" placeholder="주소"
						class="form-control"
					>
				</div>
			</div>

			<div class="form-group row">
				<label class="col-sm-2"></label>
				<div class="col-sm-4">
					<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소"
						class="form-control"
					>
				</div>
				<div class="col-sm-3">
					<input type="text" id="extraAddress" placeholder="참고항목" class="form-control">
				</div>
			</div>

			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<a href="./cart.jsp?cartId=<%=request.getParameter("cartId")%>"
						class="btn btn-secondary" role="button"
					> 이전 </a>
					<input onclick="return shipCheck()" type="submit" class="btn btn-primary" value="등록" />
					<!-- shipCheck 공백입력 체크 -->
					<a href="./checkOutCancelled.jsp" class="btn btn-secondary" role="button"> 취소 </a>
				</div>
			</div>

		</form>
	</div>
	<!-- 우편번호,배송일 관련 소스 -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="../resources/js/shipping.js"></script>
</body>
</html>









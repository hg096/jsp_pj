<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="model.OrderDTO"%>

<%
OrderDTO notice = (OrderDTO) request.getAttribute("board"); /* BoardDTO를 받아옴 */
int num = ((Integer) request.getAttribute("num")).intValue();
int nowpage = ((Integer) request.getAttribute("page")).intValue();
%>

<html>
<!-- 여기는 게시글을 선택했을때 진입 화면 수정과 삭제를 할수있음 -->
<head>
<title>수정 및 삭제</title>
</head>
<body>
	<jsp:include page="../admin/adminMenu.jsp" />
	<!-- 상단에 메튜 가져오고 -->

	<br> <br> <br> <br> <br> 

	<div class="container">
		<!-- 처음 여기에 들어올때 BoardUpdateAction으로 선택된 글의 조회수 늘리기 -->
		<form name="newUpdate"
			action="OrderUpdateAction.do?num=<%=notice.getO_num()%>&pageNum=<%=nowpage%>"
			class="form-horizontal" method="post"
		>
			<div class="form-group row">
				<label class="col-sm-2 control-label">주문자</label>
				<div class="col-sm-3">
					<label class="control-label"><%=notice.getM_name()%></label>
				</div>
			</div>

			<div class="form-group row">
				<label class="col-sm-2 control-label">상품이름</label>
				<div class="col-sm-5">
					<label class="control-label"><%=notice.getP_name()%></label>
				</div>
			</div>

			<div class="form-group row">
				<label class="col-sm-2 control-label">주문 수량</label>
				<div class="col-sm-5">
					<label class="control-label"><%=notice.getAmount()%></label>
				</div>
			</div>

			<!-- 여기를 수정해서 상태값을 변경  -->
			<div class="form-group row">
				<label class="col-sm-2 control-label">상태</label>
				<div class="col-sm-5">
					<select name="conditions" id="conditions" class="form-control">
						<option value="<%=notice.getConditions()%>"><%=notice.getConditions()%></option>
						<!-- 현재의 상태를 가져옴  -->
						<option value="주문완료">주문완료</option>
						<option value="배송준비중">배송준비중</option>
						<option value="배송 중">배송 중</option>
						<option value="배송완료">배송완료</option>
					</select>
				</div>
			</div>

			<div class="form-group row">
				<label class="col-sm-2 control-label">우편번호</label>
				<div class="col-sm-5">
					<input name="postcode" class="form-control" value="<%=notice.getPostcode()%>">
				</div>
			</div>

			<div class="form-group row">
				<label class="col-sm-2 control-label">주소</label>
				<div class="col-sm-5" style="word-break: break-all;">
					<textarea name="address" class="form-control" cols="50" rows="5"> <%=notice.getAddress()%></textarea>
				</div>
			</div>

			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<p>
						<a href="./OrderDeleteAction.do?num=<%=notice.getO_num()%>&pageNum=<%=nowpage%>"
							class="btn btn-danger"
						> 삭제</a>

						<input type="submit" class="btn btn-success" value="수정 ">
						<a href="./OrderListAction.do?pageNum=<%=nowpage%>" class="btn btn-primary"> 목록</a>
				</div>
			</div>
		</form>
		<hr>
	</div>
	<jsp:include page="../guest/footer.jsp" />
</body>
</html>



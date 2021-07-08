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
<title>결산 상세</title>
</head>
<body>
	<jsp:include page="../admin/adminMenu.jsp" />
	<!-- 상단에 메튜 가져오고 -->

	<br> <br> <br> <br> <br> 

	<div class="container">
	
		<form
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

			<div class="form-group row">
				<label class="col-sm-2 control-label">상태</label>
				<div class="col-sm-5">
					<label class="control-label"><%=notice.getConditions()%></label>
				</div>
			</div>

			<div class="form-group row">
				<label class="col-sm-2 control-label">우편번호</label>
				<div class="col-sm-5">
					<label class="control-label"><%=notice.getPostcode()%></label>
				</div>
			</div>

			<div class="form-group row">
				<label class="col-sm-2 control-label">주소</label>
				<div class="col-sm-5">
					<label class="control-label"><%=notice.getAddress()%></label>
				</div>
			</div>
<br> <br> <br> 
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10 ">
						<a href="./AccountListAction.do?pageNum=<%=nowpage%>" class="btn btn-primary">목록</a>
				</div>
			</div>
		</form>
		<hr>
	</div>
	<jsp:include page="../guest/footer.jsp" />
</body>
</html>



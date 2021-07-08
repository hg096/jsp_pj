<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootswatch@4.6.0/dist/lux/bootstrap.min.css"
	
>
</head>

<body>
	<nav class="navbar navbar-expand  navbar-dark bg-dark">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="<c:url value = "/admin/admin.jsp"/>">관리자</a>
			</div>

			<div>
				<ul class="navbar-nav">

					<div class="btn-group">
						<button type="button" class="btn btn-dark dropdown-toggle" data-toggle="dropdown"
							aria-haspopup="true" aria-expanded="false"
						>상품 관리</button>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="<c:url value="/admin/addProduct.jsp"/>">등록</a>
							<a class="dropdown-item" href="<c:url value="/admin/editProduct.jsp"/>">수정,삭제</a>
						</div>
					</div>

					<div class="btn-group">
						<button type="button" class="btn btn-dark dropdown-toggle" data-toggle="dropdown"
							aria-haspopup="true" aria-expanded="false"
						>주문 관리</button>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="<c:url value="/OrderListAction.do?pageNum=1"/>">주문
								확인, 취소, 상태변경</a>
							<a class="dropdown-item" href="<c:url value="/AccountListAction.do?pageNum=1"/>">주문
								내역</a>

						</div>
					</div>

					<li class="nav-item">
						<a class="nav-link" href="<c:url value="/NoticeListAction.do?pageNum=1"/>">공지사항</a>
					</li>

					<li class="nav-item">
						<a class="nav-link" href="<c:url value="/guest/logout.jsp"/>">로그아웃 </a>
					</li>
				</ul>
			</div>

		</div>
	</nav>



	<!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
		integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
		crossorigin="anonymous"
	></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns"
		crossorigin="anonymous"
	></script>

</body>
</html>
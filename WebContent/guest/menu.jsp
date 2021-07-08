<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="bootS.jsp"/>
</head>
<body class="mr-4 ml-4">
	<%
	//로그인시 저장한 sessionId 세션을 불러온다. 이것의 값이 없으면 비회원처리 있으면 회원으로 처리
	String m_id = (String) session.getAttribute("m_id");
	%>

	<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top"><!-- fixed-top 상단 고정  -->
		<div class="container-fluid">
			<div class="navbar-brand">
				<a class="navbar-brand" href="<c:url value = "/guest/welcome.jsp"/>">shoppingMall</a>
			</div>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarToggler02" aria-controls="navbarToggler022"
				aria-expanded="false" aria-label="Toggle navigation"
			>
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarToggler02">
				<ul class="navbar-nav">
					<li class="nav-item">
						<a class="nav-link" href="<c:url value="/guest/products.jsp"/>">전체 상품</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="<c:url value="/M_NoticeListAction.do?pageNum=1"/>">공지사항</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="<c:url value="/communi/c_List.jsp"/>">게시판</a>
					</li> 

					<c:choose>
						<c:when test="${empty m_id}">
							<li class="nav-item">
								<a class="nav-link" href="<c:url value="/member/loginMember.jsp"/>">로그인 </a>
							</li>
							<li class="nav-item">
								<a class="nav-link" href='<c:url value="/member/addMember.jsp"/>'>회원 가입</a>
							</li>
						</c:when>
						
						<c:otherwise>
							<li style="padding-top: 7px; color: white">
								[<%=m_id%>님]
							</li>
							<li class="nav-item">
								<a class="nav-link" href="<c:url value="/member/logoutMember.jsp"/>">로그아웃 </a>
							</li>
							<li class="nav-item">
								<a class="nav-link" href="<c:url value="/member/updateMember.jsp"/>">회원 수정</a>
							</li>
						</c:otherwise>
					</c:choose>

					<!-- 관리자 링크  -->
					<li class="nav-item">
						<a class="nav-link" href="<c:url value="/admin/admin.jsp"/>">관리자</a>
					</li>
				</ul>
			</div>

		</div>
	</nav>
</body>
</html>
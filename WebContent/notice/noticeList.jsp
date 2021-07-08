<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<html>
<!-- 게시판 초기 화면  -->
<head>
<title>공지사항</title>

</head>
<body>
	<jsp:include page="../admin/adminMenu.jsp" />

	<br>
	<br>
	<br>
	<form action="<c:url value="./NoticeListAction.do"/>" method="post">
		<div class="container">
			<input type="hidden" name="newSearch" value="yes" />
			<!-- 검색데이터값을 기록하는 부분 -->

			<div>
				<div class="text-right">
					<span class="badge badge-white"> 전체 ${total_record}건 </span>
				</div>
			</div>

			<div style="padding-top: 50px">
				<table class="table table-hover">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성일</th>
						<th>조회</th>
						<th>글쓴이</th>
					</tr>

					<c:forEach var="item" items="${noticelist}">
						<tr>
							<!-- 번호 -->
							<td>${item.n_num}</td>
							<!-- 제목 -->
							<td>
								<a href="./NoticeViewAction.do?num=${item.n_num}&pageNum=${pageNum}">
									${item.subject}</a>
							</td>
							<!-- 작성일 -->
							<td>${item.regist_day}</td>
							<!-- 조회수 -->
							<td>${item.hit}</td>
							<!-- 글쓴이 -->
							<td>${item.name}</td>
						</tr>
					</c:forEach>
				</table>
			</div>

			<!-- 페이지 넘버링 -->
			<div align="center">
				<c:set var="pageNum" value="${pageNum}" />
				<c:forEach var="i" begin="1" end="${total_page}">
					<a href="<c:url value="./NoticeListAction.do?pageNum=${i}" /> ">
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
			<br>


			<div class="btn-group btn-group-toggle" data-toggle="buttons" align="right">
				<label class="btn"> <select name="items" class="txt btn btn-outline-primary">
						<option value="subject">제목에서</option>
						<option value="content">본문에서</option>
					</select>
				</label> 
				<label class="btn btn primary"> 
				<input name="text" type="text" /> 
				<input type="submit" id="btnAdd" class="btn btn-outline-primary btn-sm" value="검색 "
				/>
				</label> <label class="btn btn primary"> <a href="<c:url value="/NoticeWrite.do"/>"
						class="btn btn-outline-primary btn-sm"
					> 글쓰기 </a>
				</label>
			</div>
			<hr>
		</div>

	</form>
	<jsp:include page="../guest/footer.jsp" />
</body>
</html>


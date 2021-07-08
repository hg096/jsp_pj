<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="model.NoticeDTO"%>

<%
NoticeDTO notice = (NoticeDTO) request.getAttribute("board"); /* BoardDTO를 받아옴 */
int num = ((Integer) request.getAttribute("num")).intValue();
int nowpage = ((Integer) request.getAttribute("page")).intValue();
%>

<html>
<!-- 여기는 게시글을 선택했을때 회원의 화면-->
<head>
<title>공지사항</title>
</head>
<body>
	<jsp:include page="../guest/menu.jsp" />

	
	<br> <br> <br> <br> <br> <br> <br>

	<div class="container">
		<hr>
		<div>
			<h2>
				공지 | <%=notice.getSubject()%></h2>
		</div>
		<div>
			<p><%=notice.getRegist_day()%></p>
		</div>
		<hr>
		<div>
			<p>안녕하세요, shoppingMall입니다.</p>
		</div>
		<br> 
		<hr>
		<br> <br>
		<div>
			<p><%=notice.getContent()%></p>
		</div>

			<br> <br>	<br> <br>	<br> <br>	<br> <br>
			<div align="right">
				<a href="./M_NoticeListAction.do?pageNum=<%=nowpage%>" class="btn btn-primary" >목록으로</a>
			</div>
		
		<hr>
	</div>

	<%-- <jsp:include page="../admin/footer.jsp" /> 구매자 footer로 변경 --%>
</body>
</html>



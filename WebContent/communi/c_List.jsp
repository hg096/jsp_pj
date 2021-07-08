<%@page import="board.Paging"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>게시판</title>
<meta charset="utf-8" />

<style>
a {
	color: #000000
}
</style>

</head>
<body>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<%
	int thisPage = 1;
	if (request.getParameter("thisPage") != null) {
		thisPage = Integer.parseInt(request.getParameter("thisPage"));
	}
	
	BoardDAO dao = new BoardDAO();
	ArrayList<BoardDTO> list = dao.boardSelect(1);
	Paging p = new Paging(2, list, thisPage);
	%>
	<!-- Header -->
	<jsp:include page="../guest/menu.jsp" />

	<!-- Main -->
	<section id="main">
		<div class="container">
			<header class="major special">
				<h1>게시판</h1>
			</header>
			<section>
				<div style="padding-top: 50px">
					<table class="table table-hover">

						<tr>
							<th style="width: 300px; text-align: center;">글번호</th>
							<th style="width: 700px; text-align: center;">글제목</th>
							<th style="width: 300px; text-align: center;">작성자</th>
							<th style="width: 300px; text-align: center;">조회수</th>
						</tr>

						<!-- 페이지 수에 맞는 게시물 출력 -->
						<%
						for (int i = p.getStartContent(); i >= p.getEndContent(); i--) {
							BoardDTO dto = list.get(i);
						%>
						<tr>
							<td style="width: 300px; text-align: center;"><%=i + 1%></td>
							<!-- 글번호 -->
							<td style="width: 700px; text-align: center;">
								<!-- 제목 -->
								<a href="c_View.jsp?c_num=<%=dto.getC_num()%>"><%=dto.getSubject()%></a>
							</td>
							<td style="width: 300px; text-align: center;"><%=dto.getM_id()%></td>
							<!-- 작성자 -->
							<td style="width: 300px; text-align: center;"><%=dto.getHit()%></td>
							<!-- 조회수 -->
						</tr>
						<%
						}
						%>
					</table>
				</div>
				<br> <br> <br>
				<div align="center">
					<!-- 페이징 처리 -->
					<%
					if (5 < p.getStartPage()) {
					%><a href="c_List.jsp?thisPage=<%=p.getStartPage() - 1%>">◀</a>
					<%
					}
					for (int i = p.getStartPage(); i <= p.getEndPage(); i++) {
					%>
					<a href="c_List.jsp?thisPage=<%=i%>">
						<b>[<%=i%>]</b>
					</a>
					<%
					}
					if (p.getEndPage() < p.getMaxPage()) {
					%><a href="c_List.jsp?thisPage=<%=p.getStartPage() + 5%>">▶</a>
					<%
					}
					%>
				</div>


				<div align="right">
					<%
					// 세션중에 m_id 값 null 확인하기
					if (session.getAttribute("m_id") != null) { 
					%>
					<a class="btn btn-outline-primary btn-sm" onclick="location.href='c_Write.jsp'">
						글쓰기 </a>

					<%
					}
					%>
				</div>

			</section>


		</div>
	</section>
<jsp:include page="../guest/footer.jsp" />

</body>
</html>
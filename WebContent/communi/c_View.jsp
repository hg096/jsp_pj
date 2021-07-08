<%@page import="board.CommentDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.CommentDTO"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>게시글</title>
<meta charset="utf-8" />
<!-- <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="../assets/css/main.css" /> -->
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
int c_num = Integer.parseInt(request.getParameter("c_num"));
BoardDAO dao = new BoardDAO();
dao.contentViews(c_num);

BoardDTO dto = dao.contentSelect(c_num);
CommentDAO cdao = new CommentDAO();
/* 글번호로 댓글 가져오기 */
ArrayList<CommentDTO> commList = cdao.commentSelect(c_num); 
%>
	<!-- Header -->
	<jsp:include page="../guest/menu.jsp" />

	<!-- Main -->
	<section id="main">
		<div class="container">
			<header class="major special">
				<h1>게시판 컨텐츠</h1>
			</header>

			<section>
				<div style="padding-top: 50px">
					<!-- 게시판 상세보기 -->
					<form action="c_Edit.jsp?c_num=<%=c_num%>" method="post">
						<table class="table">

							<tr>
								<td style="width: 100px;">
									<b>제목</b>
								</td>
								<td style="width: 500px;"><%=dto.getSubject()%></td>
								<td style="width: 100px;">조회수</td>
								<td style="width: 350px;"><%=dto.getHit()%></td>
							</tr>
							<tr>
								<td>
									<b>글쓴이</b>
								</td>
								<td><%=dto.getM_id()%></td>
								<td>
									<b>작성일</b>
								</td>
								<td><%=dto.getDate()%></td>
							</tr>

							<tr>
								<td colspan="5" style="text-align: left;">
									<b>내용</b>
								</td>
							</tr>

							<tr>
								<td colspan="5"><%=dto.getContent()%></td>
							</tr>

						</table>

						<br> <br> <br>
						<div class="btn-group form-row float-right" role="group" aria-label="Basic example"
							align="right"
						>

							<button type="button" class="btn btn-secondary"
								onclick="location.href='c_List.jsp'"
							>목록</button>

							<%
							if (session.getAttribute("m_id") != null) {
								if (session.getAttribute("m_id").equals(dto.getM_id())) {
							%>
							<button type="submit" class="btn btn-secondary">수정</button>
							<button type="button" class="btn btn-secondary"
								onclick="location.href='delete.jsp?c_num=<%=c_num%>&value=1'"
							>삭제</button>

							<%
							}
							}
							%>
						</div>
					</form>
					<br> <br> <br> <br>

					<!-- 댓글 시작 -->
					<%
					/* 로그인 되었을때만 보이기 */
					if (session.getAttribute("m_id") != null) {
					%>
					<form method="post" action="comment.jsp?c_num=<%=request.getParameter("c_num")%>">

						<table class="table">
							<%
							if (commList != null) { 
								for (int i = 0; i < commList.size(); i++) {
									CommentDTO cdto = commList.get(i);
							%>
							<tr>
								<td>
									<b><%=cdto.getM_id()%></b>
								</td>
								<td><%=cdto.getContent()%></td>
								<td><%=cdto.getDate()%></td>
							</tr>
							<%
							}
							}
							%>

						</table>
						<br> <br>

						<div class="form-group row">

							<label class="col-sm-2" style="text-align: center;" for="message"><%=session.getAttribute("m_id")%></label>

							<div class="col-sm-8">
								<textarea name="comment" cols="50" rows="2" class="form-control"></textarea>
							</div>

							<button class="btn btn-outline-primary btn-sm" type="submit"
								style="text-align: center;" class="alt"
							>댓글쓰기</button>

						</div>


					</form>
					<%}%>

				</div>
			</section>
			<br> <br> <br> <br>

		</div>
	</section>
	<jsp:include page="../guest/footer.jsp" />


</body>
</html>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>게시글 수정</title>
<meta charset="utf-8" />

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
BoardDTO dto = dao.contentSelect(c_num);
%>

	<!-- Header -->
	<jsp:include page="../guest/menu.jsp" />

	<!-- Main -->
	<section id="main">
		<div class="container">
			<header class="major special">
				<h1>게시글 수정</h1>
			</header>

			<section>
				<br>
				<hr>
				<br>

				<form action="contentUpdate.jsp?c_num=<%=c_num%>" method="post">

					<div class="form-group row">
						<label class="col-sm-2 control-label">제목</label>
						<div class="col-sm-8">
							<input type="text" name="subject" class="form-control"
								value="<%=dto.getSubject()%>"
							>
						</div>
					</div>

					<div class="form-group row">
						<label class="col-sm-2 control-label">작성자</label> <label
							class="col-sm-2 control-label"
						><%=dto.getM_id()%></label>
					</div>
					<div class="form-group row">
						<label class="col-sm-2 control-label">내용</label>

						<div class="col-sm-8">
							<textarea name="content" cols="50" rows="10" class="form-control"><%=dto.getContent()%></textarea>
						</div>
					</div>
					<br> <br>
					<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-10 ">
							<input type="submit" class="btn btn-primary " value="수정" style="float: right;">
						</div>
					</div>
				</form>

			</section>


		</div>
	</section>

<jsp:include page="../guest/footer.jsp" />

</body>
</html>
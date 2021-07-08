<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>게시글 글쓰기</title>
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
	<!-- Header -->
	<jsp:include page="../guest/menu.jsp" />

	<!-- Main -->
	<section id="main">
		<div class="container">
			<h1>글쓰기</h1>
			<section>
				<br>
				<hr>
				<br>
				<form action="write.jsp" method="post">

					<div class="form-group row">
						<label class="col-sm-2 control-label">제목</label>
						<div class="col-sm-8">
							<input type="text" name="subject" class="form-control">
						</div>

					</div>

					<div class="form-group row">
						<label class="col-sm-2 control-label">작성자</label> <label
							class="col-sm-2 control-label"
						><%=session.getAttribute("m_id")%></label>
					</div>

					<div class="form-group row">
						<label class="col-sm-2 control-label">내용</label>
						<div class="col-sm-8">
							<textarea name="content" cols="50" rows="10" class="form-control"></textarea>
						</div>
					</div>

					<br> <br>
					<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-10 ">
							<input type="submit" class="btn btn-primary " value="글쓰기" style="float: right;">
						</div>
					</div>

				</form>
			</section>
		</div>
	</section>
<jsp:include page="../guest/footer.jsp" />

</body>
</html>
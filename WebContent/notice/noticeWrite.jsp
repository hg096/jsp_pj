<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="mvc.model.BoardDTO"%>
<%
String name = (String) request.getAttribute("name");

%>
<html>
<!-- 여기는 게시글 작성  -->
<head>
<title>공지사항 쓰기</title>
</head>
<script type="text/javascript">
	/* 공백확인  */
	function checkForm() {
		if (!document.newWrite.subject.value) {
			alert("제목을 입력하세요.");
			return false;
		}
		if (!document.newWrite.content.value) {
			alert("내용을 입력하세요.");
			return false;
		}
	}
</script>

<body>
	<jsp:include page="../admin/adminMenu.jsp" />
	<br>
	<br>
	<br>

	<div class="container">
		<hr>
		<br>
		<form name="newWrite" action="./NoticeWriteAction.do" class="form-horizontal"
			method="post" onsubmit="return checkForm()"
		>
			<!-- 작성자의 이름은 계정아이디 기본값 -->
			<div class="form-group row">
				<label class="col-sm-2 control-label">성명</label>
				<div class="col-sm-3">
					<input name="name" type="text" class="form-control" value="관리자" placeholder="name">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2 control-label">제목</label>
				<div class="col-sm-5">
					<input name="subject" type="text" class="form-control" placeholder="subject">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2 control-label">내용</label>
				<div class="col-sm-8">
					<textarea name="content" cols="50" rows="5" class="form-control"
						placeholder="content"
					></textarea>
				</div>
			</div>
			
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="submit" class="btn btn-primary " value="등록 "> <input
						type="reset" class="btn btn-primary " value="취소 "
					>
					<!-- 아쉬운게 취소가 이전이아니라 리셋 -->
					<a href="NoticeListAction.do?pageNum=1" class="btn btn-primary"> 목록</a>
					<!-- 목록으로 링크  -->
				</div>
			</div>
			
		</form>
		<hr>
	</div>
	<jsp:include page="../guest/footer.jsp" />
</body>
</html>




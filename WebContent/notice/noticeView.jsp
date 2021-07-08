<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="model.NoticeDTO"%>

<%
NoticeDTO notice = (NoticeDTO) request.getAttribute("board");	/* BoardDTO를 받아옴 */
int num = ((Integer) request.getAttribute("num")).intValue();
int nowpage = ((Integer) request.getAttribute("page")).intValue();
%>

<html>
<!-- 여기는 게시글을 선택했을때 진입 화면 수정과 삭제를 할수있음 -->
<head>
<title>공지사항</title>
</head>
<body>
	<jsp:include page="../admin/adminMenu.jsp" />
	
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

	<div class="container">	 <!-- 처음 여기에 들어올때 BoardUpdateAction으로 선택된 글의 조회수 늘리기 -->
		<form name="newUpdate" action="NoticeUpdateAction.do?num=<%=notice.getN_num()%>&pageNum=<%=nowpage%>"
			class="form-horizontal" method="post"
		>
			<div class="form-group row">
				<label class="col-sm-2 control-label">작성자</label>
				<div class="col-sm-3">
					<input name="name" class="form-control" value=" <%=notice.getName()%>">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2 control-label">제목</label>
				<div class="col-sm-5">
					<input name="subject" class="form-control" value=" <%=notice.getSubject()%>">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2 control-label">내용</label>
				<div class="col-sm-8" style="word-break: break-all;">
					<textarea name="content" class="form-control" cols="50" rows="5"> <%=notice.getContent()%></textarea>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10 ">			
						<p><a href="./NoticeDeleteAction.do?num=<%=notice.getN_num()%>&pageNum=<%=nowpage%>" class="btn btn-danger">
								삭제</a> 
								<input type="submit" class="btn btn-success" value="수정 ">
					
					<a href="./NoticeListAction.do?pageNum=<%=nowpage%>" class="btn btn-primary"> 목록</a>
				</div>
			</div>
			
			
			
		</form>
		<hr>
	</div>
	<jsp:include page="../guest/footer.jsp" />
</body>
</html>



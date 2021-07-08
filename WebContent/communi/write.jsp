<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

<%
request.setCharacterEncoding("UTF-8");
String m_id = (String)session.getAttribute("m_id");
%>
 <%-- <jsp:useBean id="빈이름" class="자바빈클래스이름" scope="범위"저장될 영역(page, request, session, application 중 하나, 기본값은 page)  --%>
<jsp:useBean id="dto" class="board.BoardDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%
dto.setM_id(m_id);
BoardDAO dao = new BoardDAO();
dao.boardWrite(dto);
%>

<script type="text/javascript">
alert("게시글이 등록되었습니다!");
location.href="c_List.jsp";
</script>
</body>
</html>
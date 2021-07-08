<%@page import="board.CommentDAO"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.CommentDTO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<!-- 댓글 -->
	<%
	request.setCharacterEncoding("UTF-8");
	CommentDTO dto = new CommentDTO();
	dto.setC_num(Integer.parseInt(request.getParameter("c_num")));
	dto.setM_id((String) session.getAttribute("m_id"));
	dto.setContent(request.getParameter("comment"));
	CommentDAO dao = new CommentDAO();
	dao.commentInsert(dto);

	response.sendRedirect("c_View.jsp?c_num=" + dto.getC_num());
	%>
</body>
</html>
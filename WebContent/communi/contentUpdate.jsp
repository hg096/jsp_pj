<%@page import="board.BoardDAO"%>
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
int c_num = Integer.parseInt(request.getParameter("c_num"));

%>

<jsp:useBean id="dto" class="board.BoardDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%
BoardDAO dao = new BoardDAO();
dao.contentUpdate(c_num, dto);
%>
<script type="text/javascript">
alert("수정 완료!");
location.href="c_List.jsp?c_num=<%=c_num%>";
</script>

</body>
</html>
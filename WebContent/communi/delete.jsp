<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
int c_num = Integer.parseInt(request.getParameter("c_num"));
BoardDAO dao = new BoardDAO();
dao.contentDelete(c_num);
//int value = Integer.parseInt(request.getParameter("value"));
String url = "c_List.jsp";
/* if(value == 1){
	url = "board.jsp";
}
else if (value == 2){
	url = "imageBoard.jsp";
}
else if (value == 3){
	url = "fileBoard.jsp";
} */

%>

<script type="text/javascript">
alert("게시글이 삭제되었습니다!")
location.href = "<%=url%>";
</script>
</body>
</html>
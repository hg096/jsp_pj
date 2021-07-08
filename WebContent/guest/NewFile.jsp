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
String uploadPath = request.getRealPath("/resources/imagesUpload");
    out.println("절대경로 : " + uploadPath +"<br/>");
    // D:\자바,이클립스\Project\TEST\jsp_pj\WebContent\resources\imagesUpload
%>
<!-- 경로를 찾지못할때 콘솔서버창 더블클릭후에 서버 옵션에 첫번째 체크박스 선택 후 저장 -->
<!-- https://m.blog.naver.com/ksi4687/220527469366 <-참고 링크 -->
</body>
</html>
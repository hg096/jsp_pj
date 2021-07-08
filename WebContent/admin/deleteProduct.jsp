<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp"%>
<%
//아이디를 가져온다
String productId = request.getParameter("id");

//실제 그 아이디가 있는지 검사
String sql = "select * from product";
pstmt = conn.prepareStatement(sql);
rs = pstmt.executeQuery(); //rs 결과

if (rs.next()) { //결과가 있으면 
	sql = "delete from product where p_id = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, productId);
	pstmt.executeUpdate(); //디비에서 삭제
} else //없으면
	out.println("일치하는 상품이 없습니다");

//연결 닫기
if (rs != null)
	rs.close();
if (pstmt != null)
	pstmt.close();
if (conn != null)
	conn.close();

//다시 원래페이지로 돌아감
response.sendRedirect("editProduct.jsp?edit=delete");
%>

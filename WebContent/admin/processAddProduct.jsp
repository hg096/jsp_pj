<%@page import="product.ProductRepository"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.sql.*"%>
<%@ include file="/admin/dbconn.jsp"%>

<%
request.setCharacterEncoding("UTF-8"); //한글처리
String uploadPath = request.getRealPath("/resources/imagesUpload");
out.println("절대경로 : " + uploadPath +"<br/>");

// MultipartRequest 객체생성및 초기화(request,저장경로,파일사이즈,인코딩,파일저장방법)
MultipartRequest multi = new MultipartRequest(request, uploadPath, 5 * 1024 * 1024, "utf-8",
		new DefaultFileRenamePolicy());

String categoryL = multi.getParameterValues("categoryL")[0];
String categoryS = multi.getParameterValues("categoryS")[0];
String productId = null;
String name = multi.getParameter("name");
String description = multi.getParameter("description");
String unitPrice = multi.getParameter("unitPrice");
Integer price;

if (unitPrice.isEmpty())
	price = 0;
else
	price = Integer.valueOf(unitPrice);


//파일의 이름을 가져온다.
String filename = multi.getFilesystemName("productImage");

ProductRepository dao = ProductRepository.getInstance();

String sql = "insert into product values(?,?, ?,?, ?,?, ?)";
pstmt = conn.prepareStatement(sql);

pstmt.setString(1, categoryL);
pstmt.setString(2, categoryS);
pstmt.setString(3, productId);
pstmt.setString(4, name);
pstmt.setString(5, description);
pstmt.setInt(6, price);
pstmt.setString(7, filename);

pstmt.executeUpdate();
//닫기

if (pstmt != null)
	pstmt.close();
if (conn != null)
	conn.close();

response.sendRedirect("editProduct.jsp");
%>

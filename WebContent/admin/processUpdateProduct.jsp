<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp"%>

<%
request.setCharacterEncoding("UTF-8"); //한글처리
//경로를 D드라이브가 아닌 프로젝트안의 폴더로 변경
String uploadPath = request.getRealPath("/resources/imagesUpload");
out.println("절대경로 : " + uploadPath +"<br/>");


//MultipartRequest 객체생성및 초기화(request,저장경로,파일사이즈,인코딩,파일저장방법)
MultipartRequest multi = new MultipartRequest(request, uploadPath, 5 * 1024 * 1024, "utf-8",
		new DefaultFileRenamePolicy());

String categoryL = multi.getParameterValues("categoryL")[0];
String categoryS = multi.getParameterValues("categoryS")[0];
String productId = multi.getParameter("productId");
String name = multi.getParameter("name");
String description = multi.getParameter("description");
String unitPrice = multi.getParameter("unitPrice");
Integer price;

if (unitPrice.isEmpty())
	price = 0;
else
	price = Integer.valueOf(unitPrice);


//이미지파일의 이름을 가져온다.
String fileName = multi.getFilesystemName("productImage");

//디비에서 받아온 내용을 업데이트
String sql = "select * from product where p_id = ?";
pstmt = conn.prepareStatement(sql);
pstmt.setString(1, productId);
rs = pstmt.executeQuery();

if (rs.next()) {
	if (fileName != null) { //사진도 같이 업데이트
		sql = "UPDATE product SET categoryL=?, categoryS=?, name=?, description=?, unitPrice=?, fileName=?  WHERE p_id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, categoryL);
		pstmt.setString(2, categoryS);
		pstmt.setString(3, name);
		pstmt.setString(4, description);
		pstmt.setInt(5, price);
		pstmt.setString(6, fileName);
		
		pstmt.setString(7, productId);

		pstmt.executeUpdate();

	} else { //사진이 없을경우
		sql = "UPDATE product SET categoryL=?, categoryS=?, name=?, description=?, unitPrice=?  WHERE p_id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, categoryL);
		pstmt.setString(2, categoryS);
		pstmt.setString(3, name);
		pstmt.setString(4, description);
		pstmt.setInt(5, price);
		
		pstmt.setString(6, productId);
		
		pstmt.executeUpdate();
	}
}
if (rs != null)
	rs.close();
if (pstmt != null)
	pstmt.close();
if (conn != null)
	conn.close();

/*  */
response.sendRedirect("editProduct.jsp");
%>



<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="product.Product"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp"%>

<!-- 장바구니를 세션(34라인)에 담아서 관리 "cartlist", list -->
<%
// 아이디로 제품을 가져옴
String id = request.getParameter("id");
// 가져오는게 비어있으면 상품목록으로 돌아가기
if (id == null || id.trim().equals("")) {
	response.sendRedirect("products.jsp");
	return;
}

// 
String sql = "select * from product where p_id=?";
// prepareStatement에서 동적 값(?)을 넣기 
pstmt = conn.prepareStatement(sql);
// (1, id) 첫번째 ? 값에 id값을 넣겠다
pstmt.setString(1, id);
// executeQuery조회하는 쿼리, 변경은 executeUpdate
rs = pstmt.executeQuery();

if (!rs.next()) { // 제품을 못찾았을 경우
	response.sendRedirect("exceptionNoProductId.jsp");
}

//장바구니 세션 불러오기
ArrayList<Product> list = (ArrayList<Product>) session.getAttribute("cartlist");
if (list == null) { // list가 없다면 최초로 고른 상품이므로 새 장바구니(list) 생성
	list = new ArrayList<Product>();
	session.setAttribute("cartlist", list); // cartlist 세션등록 (이름, 값)
}

boolean isNotInList = true; /* isNotInList 초기값 */
for (Product p : list) { 	/* 반복문 리스트에 제품을 하나씩 비교 list의 값을 순차적으로 p에 넣기*/

	if (p.getPid().equals(id)) { // 같은 값이 이미 존재하는지 확인
		p.setQuantity(p.getQuantity() + 1); /* 같은 제품이 있을 때 같은 제품 수량 +1 */
		isNotInList = false;	/* 같은 제품이 있으면 리스트에는 추가안함 */
	}
}

if (isNotInList) { // 같은 제품이 없다
	Product newItem = new Product(); // 빈 제품 객제

	sql = "select * from product where p_id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	rs = pstmt.executeQuery();

	if (rs.next()) {
		newItem.setQuantity(1); // 장바구니 담은 개수 초기값
		
		newItem.setCategoryL(rs.getString(1));
		newItem.setCategoryS(rs.getString(2));
		newItem.setPid(rs.getString(3));
		newItem.setName(rs.getString(4));
		newItem.setDescription(rs.getString(5));
		newItem.setUnitPrice(Integer.valueOf(rs.getInt(6)));
		newItem.setFileName(rs.getString(7));
		

		list.add(newItem); //장바구니에 추가 (session>>list에 저장)
	}

	// db 연결닫기 
	if (rs != null)
		rs.close();
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();

}

/* 이전페이지로 */
response.sendRedirect("product.jsp?id=" + id);
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<title>상품 편집</title>

<!-- 상품편집 상세 메인 -->
<script type="text/javascript">
	//아이디 값을 딜리트 페이지로 넘겨서 이동
	function deleteConfirm(id) {
		if (confirm("해당 상품을 삭제합니다.") == true)
			location.href = "./deleteProduct.jsp?id=" + id;
		else
			return; //취소할 경우
	}
</script>

</head>

</head>
<body>
	<jsp:include page="/admin/adminMenu.jsp" />
	<%@ include file="/admin/dbconn.jsp"%>
	
	<br> <br> <br> 
	<div class="container">
	<hr> <br> 
		<div class="row" align="center">
		
			<%
			String sql = "select * from product";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
			%>
			<div class="col-md-4">
				<img src="../resources/imagesUpload/<%=rs.getString("fileName")%>" style="width: 70%">
				<h3><%=rs.getString("name")%></h3>
				<p><%=rs.getString("description")%>
				<p><%=rs.getString("UnitPrice")%>원 <br>

					<a href="updateProduct.jsp?id=<%=rs.getString("p_id")%>" class="btn btn-success"
						role="button"
					> 수정 &raquo;></a>
					<a href="#" onclick="deleteConfirm('<%=rs.getString("p_id")%>')"
						class="btn btn-danger" role="button"
					>삭제 &raquo;></a>
			</div>
			<%
			}
			if (rs != null)
			rs.close();
			if (pstmt != null)
			pstmt.close();
			if (conn != null)
			conn.close();
			%>
		</div>
		<hr>
	</div>
	<jsp:include page="../guest/footer.jsp" />
</body>
</html>
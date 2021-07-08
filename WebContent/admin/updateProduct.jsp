<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<title>상품 수정</title>
<!-- 상품상세 화면 -->
<jsp:include page="/admin/categoryChange.jsp" />
</head>
<body>
	<jsp:include page="/admin/adminMenu.jsp" />
	<br>
	<br>
	<br>

	<%@ include file="dbconn.jsp"%>

	<%
	String productId = request.getParameter("id");

	String sql = "select * from product where p_id = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, productId);
	rs = pstmt.executeQuery();
	if (rs.next()) {
	%>

	<div class="container">
		<hr>
		<br>
		<div class="row">
			<div class="col-md-5">
				<img src="../resources/imagesUpload/<%=rs.getString("fileName")%>" alt="image"
					style="width: 100%"
				>
			</div>
			<div class="col-md-7">
				<form name="newProduct" action="./processUpdateProduct.jsp" class="form-horizontal"
					method="post" enctype="multipart/form-data"
				>

					<div class="form-group row">
						<label for="addressKindU" class="col-sm-2">대분류</label>
						<div class="col-sm-5">
							<select class="form-control" id="categoryL" name="categoryL"
								onchange="categoryChange(this)"
							>
								<option value="<%=rs.getString("categoryL")%>"><%=rs.getString("categoryL")%></option>
								<option value="아우터">아우터</option>
								<option value="상의">상의</option>
								<option value="하의">하의</option>
								<option value="신발">신발</option>
								<option value="기타">기타</option>
							</select>
						</div>
					</div>

					<div class="form-group row">
						<label for="addressKindD" class="col-sm-2">소분류</label>
						<div class="col-sm-5">
							<select class="form-control" id="categoryS" name="categoryS">
								<option value="<%=rs.getString("categoryS")%>"><%=rs.getString("categoryS")%></option>
							</select>
						</div>
					</div>

					<div class="form-group row">
						<label class="col-sm-2">상품 코드</label>
						<div class="col-sm-5">
							<input id="productId" name="productId" class="form-control" readonly="readonly" value="<%=rs.getString("p_id")%>">
							<!-- readonly="readonly"속성으로 수정 무시 -->
						</div>
					</div>

					<div class="form-group row">
						<label class="col-sm-2">상품명</label>
						<div class="col-sm-5">
							<input type="text" id="name" name="name" class="form-control"
								value="<%=rs.getString("name")%>"
							>
						</div>
					</div>

					<div class="form-group row">
						<label class="col-sm-2">상세 설명</label>
						<div class="col-sm-5">
							<textarea name="description" cols="50" rows="2" class="form-control"><%=rs.getString("description")%></textarea>
						</div>
					</div>

					<div class="form-group row">
						<label class="col-sm-2">가격</label>
						<div class="col-sm-5">
							<input type="text" id="unitPrice" name="unitPrice" class="form-control"
								value="<%=rs.getInt("unitPrice")%>"
							>
						</div>
					</div>

					<!-- 이미지 파일이 안올라갈경우 이미지 이름의 길이를 VARCHAR(20)으로 맞춰주어야 한다 -->
					<div class="form-group row">
						<label class="col-sm-2">이미지</label>
						<div class="col-sm-8">
							<input type="file" name="productImage" class="form-control">
						</div>
					</div>

					<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-10 ">
							<input type="submit" class="btn btn-primary" value="등록">
							<a href="./editProduct.jsp" class="btn btn-secondary">이전</a>
						</div>
					</div>
				</form>

			</div>
		</div>
	</div>
	<%
	}
	//디비 연결 닫기
	if (rs != null)
	rs.close();
	if (pstmt != null)
	pstmt.close();
	if (conn != null)
	conn.close();
	conn.close();
	%>
	<jsp:include page="../guest/footer.jsp" />
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>

<head>
<script type="text/javascript" src="resources/js/validation.js"></script>
<title>상품 등록</title>


<jsp:include page="/admin/categoryChange.jsp" />
</head>

<body>
	<jsp:include page="/admin/adminMenu.jsp" />

	<br>
	<br>
	<br>
	<div class="container">
		<form id="newProduct" name="newProduct" action="processAddProduct.jsp" method="POST"
			enctype="multipart/form-data"
		>
			<hr>
			<br>

			<div class="form-group row">
				<label for="addressKindU" class="col-sm-2">대분류</label>
				<div class="col-sm-3">
					<select class="form-control" id="categoryL" name="categoryL"
						onchange="categoryChange(this)"
					>
						<option></option>
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
				<div class="col-sm-3">
					<select class="form-control" id="categoryS" name="categoryS">
						<option></option>
					</select>
				</div>
			</div>

			<div class="form-group row">
				<label class="col-sm-2">상품명</label>
				<div class="col-sm-3">
					<input type="text" id="name" name="name" class="form-control">
				</div>
			</div>

			<div class="form-group row">
				<label class="col-sm-2">상세 설명</label>
				<div class="col-sm-3">
					<textarea name="description" cols="50" rows="2" class="form-control"></textarea>
				</div>
			</div>

			<div class="form-group row">
				<label class="col-sm-2">가격</label>
				<div class="col-sm-3">
					<input type="text" id="unitPrice" name="unitPrice" class="form-control">
				</div>
			</div>

			<div class="form-group row">
				<label class="col-sm-2">이미지</label>
				<div class="col-sm-5">
					<input type="file" id="productImage" name="productImage" class="form-control">
				</div>
			</div>

			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="submit" class="btn btn-primary" value="등록">
				</div>
			</div>
		</form>
	</div>

<jsp:include page="../guest/footer.jsp" />
</body>

</html>
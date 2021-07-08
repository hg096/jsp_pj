<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- sql문 사용 -->
<html>

<head>
<title>상품 목록</title>

<!-- 맨위로 버튼 -->
<style type="text/css">
.back-to-top-css {
	cursor: pointer;
	position: fixed;
	bottom: 30px;
	right: 20px;
	display: none;
}
</style>
<script>
    $(document).ready(function () {
        $(window).scroll(function () {
            if ($(this).scrollTop() > 50) {
                $('#back-to-top').fadeIn();
            } else {
                $('#back-to-top').fadeOut();
            }
        });
        // scroll body to 0px on click
        $('#back-to-top').click(function () {
            $('#back-to-top').tooltip('hide');
            $('body,html').animate({
                scrollTop: 0
            }, 800);
            return false;
        });

        $('#back-to-top').tooltip('show');

    });
</script>
<!--  -->

<jsp:include page="bootS.jsp" />
</head>
<script type="text/javascript">
.container {  width: 1120px;  max-width: none !important;}
</script>

<body class="mr-5 ml-5">
	<jsp:include page="menu.jsp" />
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
<form action="<c:url value="./ProductListAction.do"/>" method="post"> 
	<div class="row">
	
		<!-- 사이드 바 -->
		<div class="col-lg-2">
			<br> <br>
			<h2>category</h2>
			<hr>

			<!-- 사이드 아코디언  -->
			<div class="accordion" id="accordions">
				<div id="heading1">
					<a href="#" class="list-group-item list-group-item-action active" aria-current="true"
						data-toggle="collapse" data-target="#collapse1" aria-expanded="true"
						aria-controls="collapse1"
					> 아우터 </a>

					<div  id="collapse1" class="collapse" aria-labelledby="heading1"
						data-parent="#accordions"
					>
						<button type="submit"  value="플리스/덤블" class="list-group-item list-group-item-action">플리스/덤블</button>
						<a href="#" class="list-group-item list-group-item-action">패딩/다운</a>
						<a href="#" class="list-group-item list-group-item-action">코트</a>
						<a href="#" class="list-group-item list-group-item-action">자켓</a>
						<button type="submit"  value="바람막이" class="list-group-item list-group-item-action">바람막이</button>
						<a href="#" class="list-group-item list-group-item-action">가디건/베스트</a>
					</div>
				</div>

				<div id="heading2">
					<a href="#" class="list-group-item list-group-item-action active" aria-current="true"
						data-toggle="collapse" data-target="#collapse2" aria-expanded="true"
						aria-controls="collapse2"
					> 상의 </a>

					<div id="collapse2" class="collapse" aria-labelledby="heading2"
						data-parent="#accordions"
					>
						<a href="#" class="list-group-item list-group-item-action">스웨트셔츠</a>
						<a href="#" class="list-group-item list-group-item-action">후드/집업</a>
						<a href="#" class="list-group-item list-group-item-action">니트/스웨터</a>
						<a href="#" class="list-group-item list-group-item-action">긴팔티셔츠</a>
						<a href="#" class="list-group-item list-group-item-action">블라우스</a>
						<a href="#" class="list-group-item list-group-item-action">셔츠</a>
						<a href="#" class="list-group-item list-group-item-action">반팔티셔츠</a>
					</div>
				</div>

				<div id="heading3">
					<a href="#" class="list-group-item list-group-item-action active" aria-current="true"
						data-toggle="collapse" data-target="#collapse3" aria-expanded="true"
						aria-controls="collapse3"
					> 하의 </a>

					<div id="collapse3" class="collapse" aria-labelledby="heading3"
						data-parent="#accordions"
					>
						<a href="#" class="list-group-item list-group-item-action">슬랙스</a>
						<a href="#" class="list-group-item list-group-item-action">데님</a>
						<a href="#" class="list-group-item list-group-item-action">코튼팬츠</a>
						<a href="#" class="list-group-item list-group-item-action">숏츠</a>
						<a href="#" class="list-group-item list-group-item-action">스웨터/우븐팬츠</a>
						<a href="#" class="list-group-item list-group-item-action">스커트</a>
					</div>
				</div>

				<div id="heading4">
					<a href="#" class="list-group-item list-group-item-action active" aria-current="true"
						data-toggle="collapse" data-target="#collapse4" aria-expanded="true"
						aria-controls="collapse4"
					> 신발 </a>

					<div id="collapse4" class="collapse" aria-labelledby="headingOne"
						data-parent="#accordions"
					>
						<a href="#" class="list-group-item list-group-item-action">스니커즈</a>
						<a href="#" class="list-group-item list-group-item-action">샌들</a>
						<a href="#" class="list-group-item list-group-item-action">슬리퍼</a>
					</div>
				</div>

				<div id="heading5">
					<a href="#" class="list-group-item list-group-item-action active" aria-current="true"
						data-toggle="collapse" data-target="#collapse5" aria-expanded="true"
						aria-controls="collapse5"
					> 기타 </a>

					<div id="collapse5" class="collapse" aria-labelledby="heading5"
						data-parent="#accordions"
					>
						<a href="#" class="list-group-item list-group-item-action">양말</a>
						<a href="#" class="list-group-item list-group-item-action">모자</a>
						<a href="#" class="list-group-item list-group-item-action">벨트</a>
						<a href="#" class="list-group-item list-group-item-action">뷰티</a>
						<a href="#" class="list-group-item list-group-item-action">우산</a>
						<a href="#" class="list-group-item list-group-item-action">기타</a>
					</div>
				</div>
			</div>
			<!--  -->


			<br> <br>
		</div>
		<!-- 사이드 바 -->

		<%@ include file="dbconn.jsp"%>
		<div class="col-lg-9 ml-5">
			<br> <br>
			<h2>products</h2>
			<hr>
			<!-- 분류 버튼그룹 -->
			<div class="btn-toolbar justify-content-between" role="toolbar"
				aria-label="Toolbar with button groups"
			>
				<div class="btn-group" role="group" aria-label="First group" id="keyword">
					<button type="button" class="btn btn-secondary" value="아우터">아우터</button>
					<button type="button" class="btn btn-secondary" value="상의">상의</button>
					<button type="button" class="btn btn-secondary" value="하의">하의</button>
					<button type="button" class="btn btn-secondary" value="신발">신발</button>
					<button type="button" class="btn btn-secondary" value="기타">기타</button>
				</div>

				<div class="input-group">
					<div class="input-group-prepend">
						<button id="btnGroupDrop1" type="button" class="btn btn-secondary dropdown-toggle"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
						>정렬 보류</button>
						<div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
							<a class="dropdown-item" href="#">정렬1</a>
							<a class="dropdown-item" href="#">정렬2</a>
							<a class="dropdown-item" href="#">정렬3</a>
						</div>
					</div>


				</div>
			</div>
			<!-- 분류 -->
			<hr>
			<br> <br> <br>
			<!-- 상품 -->
			<div>
			
				<c:forEach var="item" items="${productlist}">
				<div class="col-md-4 mb-4">
					<a href="/product.jsp?id=${item.p_id}">
						<img src="../resources/imagesUpload/${item.fileName}" class="w-100">
					</a>
					<br> <br>
					<h5>${item.name}</h5> 
					<%-- <p><%=rs.getString("description")%> --%>

					<p class="h2 font-weight-bold">${item.unitPrice}</p> 
					<br> <br>

				</div>
				</c:forEach>
				
			</div>
			<!-- 상품 -->
		</div>
		
	</div>
	</form>
	<!-- <a id="back-to-top" href="#" class="btn btn-sm back-to-top-css" role="button"
		title="Move Top" data-toggle="tooltip" data-placement="left"
	><button type="button" class="btn btn-warning btn-sm">맨 위로</button> 
	</a>-->
	
	<jsp:include page="topButton.jsp" />
	<hr>
	<jsp:include page="footer.jsp" />

</body>

</html>
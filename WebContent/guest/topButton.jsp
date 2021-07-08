<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<!-- sql문 사용 -->
<html>

<head>
<title>맨위로 버튼</title>

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
            }, 500);
            return false;
        });

        $('#back-to-top').tooltip('show');

    });
</script>

</head>


<body >
	<jsp:include page="bootS.jsp" />

	
	<a id="back-to-top" href="#" class="btn btn-sm back-to-top-css" role="button"
		title="맨 위로" data-toggle="tooltip" data-placement="left"
	><button type="button" class="btn btn-warning btn-sm">▲</button>
	</a>

</body>

</html>
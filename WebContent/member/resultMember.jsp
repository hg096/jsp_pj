<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
<title>회원 정보</title>
</head>
<body>
	<jsp:include page="../guest/menu.jsp" />
	
	
	<br> <br> <br> <br> <br> <br> <br> <br> <br> <br> 

	<div class="container" align="center">
		<%
			//이페이지로 넘어오는 msg의 값에 따라서 아래 경고창을 표시한다.
			String msg = request.getParameter("msg");

			if (msg != null) {
				if (msg.equals("0"))
					out.println(" <h2 class='alert alert-danger'>회원정보가 수정되었습니다.</h2>");
				else if (msg.equals("1"))
					out.println(" <h2 class='alert alert-danger'>회원가입을 축하드립니다.</h2>");
				else if (msg.equals("2")) {
					// 로그인을 하면 id를 세션에 저장하고 여기서 불러옴
					String loginId = (String) session.getAttribute("m_id");
					out.println(" <h2 class='alert alert-danger'>" + loginId + "님 환영합니다</h2>");
				}				
			} else {
				out.println("<h2 class='alert alert-danger'>회원정보가 삭제되었습니다.</h2>");
			}
		%>
	</div>	
</body>
</html>
<%@ page contentType="text/html; charset=utf-8"%>

<html>
<head>
<title>Login</title>
</head>
<body>
	<jsp:include page="../guest/menu.jsp" />
	
	 
	<br> <br> <br> <br> <br> <br> <br>
	
	<div class="container" align="center">
		<div class="col-md-4 col-md-offset-4">
		<br> <br>
			<%
				String error = request.getParameter("error");
				if (error != null) {
					out.println("<div class='alert alert-danger'>");
					out.println("아이디와 비밀번호를 확인해 주세요");
					out.println("</div>");
				}
			%>
			<form class="form-signin" action="processLoginMember.jsp" method="post">

				<div class="form-group">
					<label for="inputUserName" class="sr-only">id</label> <input
						type="text" class="form-control" placeholder="id" name='m_id'
						required autofocus>
				</div>
				<div class="form-group">
					<label for="inputPassword" class="sr-only">Password</label> <input
						type="password" class="form-control" placeholder="Password"
						name='password' required>
				</div>
				<button class="btn btn btn-lg btn-success btn-block" type="submit">로그인</button>

			</form>
		</div>
	</div>
	<jsp:include page="../guest/footer.jsp" />
</body>
</html>
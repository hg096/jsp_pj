<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%
	request.setCharacterEncoding("UTF-8");
	//로그인 창으로부터 id password를 입력받아 변수저장
	String m_id = request.getParameter("m_id");
	String password = request.getParameter("password");
%>

<sql:setDataSource var="dataSource"
	url="jdbc:mysql://localhost:3306/jsp_pj?useSSL=false"
	driver="com.mysql.jdbc.Driver" user="root" password="1234" />

<!-- 쿼리는 select문 실행  결과를 resultSet에 저장 -->
<sql:query dataSource="${dataSource}" var="resultSet">
   SELECT * FROM member WHERE  m_id=? and password=?  
   <sql:param value="<%=m_id%>" />
	<sql:param value="<%=password%>" />
</sql:query>

<c:forEach var="row" items="${resultSet.rows}">
	<%
		//DB에 회원이 있으면 그 아이디를 세션에 저장 여기에서 로그인 했는지 아닌지 구분
		session.setAttribute("m_id", m_id);
	%>
	<c:redirect url="resultMember.jsp?msg=2" />
</c:forEach>
<!-- 회원정보가 없을경우 아래 주소로 이동 -->
<c:redirect url="loginMember.jsp?error=1" />

<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%
	//한글 인코딩
	request.setCharacterEncoding("UTF-8");

	String m_id = request.getParameter("m_id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	// 생일을 3개로 나눠서 첫번째 년도, 월, 일 
	String year = request.getParameter("birthyy");
	String month = request.getParameterValues("birthmm")[0];
	String day = request.getParameter("birthdd");
	// 생일을 합침 = 년도 / 월 / 날짜
	String birth = year + "/" + month + "/" + day;
	// 이메일 앞 @ 회사
	String mail1 = request.getParameter("mail1");
	String mail2 = request.getParameterValues("mail2")[0];
	// 이메일 합치기
	String mail = mail1 + "@" + mail2;
	
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	//현재 날짜와 시간을 생성한다.
	Date currentDatetime = new Date(System.currentTimeMillis());
	java.sql.Date sqlDate = new java.sql.Date(currentDatetime.getTime());
	java.sql.Timestamp timestamp = new java.sql.Timestamp(currentDatetime.getTime());
%>
<!-- DB 설정 -->
<sql:setDataSource var="dataSource"
	url="jdbc:mysql://localhost:3306/jsp_pj?useSSL=false"
	driver="com.mysql.jdbc.Driver" user="root" password="1234" />

<!-- DB에 새 유저 입력 -->
<sql:update dataSource="${dataSource}" var="resultSet">
   INSERT INTO member VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
   <sql:param value="<%=m_id%>" />
	<sql:param value="<%=password%>" />
	<sql:param value="<%=name%>" />
	<sql:param value="<%=gender%>" />
	<sql:param value="<%=birth%>" />
	<sql:param value="<%=mail%>" />
	<sql:param value="<%=phone%>" />
	<sql:param value="<%=address%>" />
	<sql:param value="<%=timestamp%>" />
</sql:update>

<!-- 업데이트(수정,삭제,입력) 결과는 정수인데 항상 1이상이다.-->
<!-- 결과가 0 이하라면 에러 -->
<c:if test="${resultSet>=1}">
	<!-- 결과가 정상이면 아래 url로 이동 -->
	<c:redirect url="resultMember.jsp?msg=1" />
</c:if>


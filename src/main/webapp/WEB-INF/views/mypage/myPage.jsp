<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	${user.userId}
	<c:forEach items="${calendarList}" var="calendar">
			${calendar.title}
	</c:forEach>
	<a href="/updateUser">회원수정</a>
</body>
</html>
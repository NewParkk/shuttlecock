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
	<form action="/updateUser" method="POST" enctype="multipart/form-data">
		<h1>로그인 사용자 정보</h1>
		<h2>
			ID : <input type="text" value="${user.userId}" readonly disabled>
		</h2>
		<h2>
			name : <input type="text" name="username" value="${user.username}">
		</h2>
		<h2>
			phone : <input type="text" name="userPhone" value="${user.userPhone}">
		</h2>
		<h2>
			email : <input type="text" name="userEmail" value="${user.userEmail}">
		</h2>
		<h2>
			image : <input type="file" name="file">
		</h2>
		<img src="${user.userImage}" alt="${user.userImage}">
		<input type="submit" value="수정">
	</form>
	<a href="/deleteUser">회원탈퇴</a>
	
	

</body>
</html>
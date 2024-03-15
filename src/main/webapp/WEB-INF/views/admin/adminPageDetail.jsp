<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<form action="/admin/${user.userId}" method="post"
		enctype="multipart/form-data">
		<div>ID:${user.userId}</div>
		<div>NAME:${user.username}</div>
		<div>EMAIL:${user.userEmail}</div>



		admin:<input type="number" name="admin" value="${user.admin}">
		<input type="submit" value="수정">
	</form>
</body>
</html>


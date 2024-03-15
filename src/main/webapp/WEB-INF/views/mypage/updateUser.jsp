<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">


</head>
<body>
<!-- wrap -->
 <div id="wrap">
<!-- header -->
<%@ include file="../include/header.jsp"%>
<main id="main">
<section id="contents">
          <!-- aside -->
          <div class="aside">
            <div class="menubar">
              <ul>
			    <li><a class="list" href="/mypage">마이페이지</a></li>
				<li><a class="list" href="/updateUser">회원수정</a></li>
				<li><a class="list" href="/record">나의활동내역</a></li>
              </ul>
            </div>
          </div>

				<div class="noticeboard">
					<div class="page-title">
						<div class="vline"></div>
						<div class="container2">
							<h3>회원 리스트</h3>
						</div>
					</div>

	<form action="/updateUser" method="POST" enctype="multipart/form-data">
		<h1>로그인 사용자 정보</h1>
		<h2>
			ID : <input type="text" value="${user.userId}" readonly disabled>
		</h2>
		<h2>
			name : <input type="text" name="username" value="${user.username}">
		</h2>
		<h2>
			email : <input type="text" name="userEmail" value="${user.userEmail}">
		</h2>
		<h2>
			image : <input type="file" name="file">
		</h2>
		<img src="https://kr.object.ncloudstorage.com/team1bucket/profile/${user.userImageName}"><br>
		<input type="submit" value="수정">	
	</form>
	<a href="/deleteUser">회원탈퇴</a>
</section>
</main>
<%@ include file="../include/footer.jsp"%>
</div>
</body>

<style>
a {
	font-size: 1.17rem; !important;
}



</style>
</html>
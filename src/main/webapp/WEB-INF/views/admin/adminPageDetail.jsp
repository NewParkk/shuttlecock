<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<link rel="stylesheet" href="/css/free.css">
</head>
<body>
	<!-- 헤더 -->
	<%@ include file="../include/header.jsp"%>

	<!-- main -->
	<main id="boardmain">

		<section id="contents">

			<div class="noticeboard">
				<div class="title">
					<div class="vline"></div>
					<div class="container2">
						<h3>회원 정보</h3>
					</div>
				</div>

				<div id="board-list">
					<div class="container2">

						<form action="/admin/${user.userId}" method="post"
							enctype="multipart/form-data">
							<div class="member-info">
								<div class="profile-picture">
									<img
										src="https://kr.object.ncloudstorage.com/team1bucket/profile/${user.userImageName}"><br>
									<br>
								</div>
								<div class="details">
									<h2>
										아이디 : <input type="text" value="${user.userId}"
											class="custom-input" readonly disabled>
									</h2>
									<br>
									<h2>
										이름 : <input type="text" name="username" class="custom-input"
											value="${user.username}" readonly disabled>
									</h2>
									<br>
									<h2>
										이메일 : <input type="text" name="userEmail" class="custom-input"
											value="${user.userEmail}" readonly disabled>
									</h2>
									<br>
									<h2>
										성별 : <input type="text" name="usergender" class="custom-input"
											value="${user.gender}" readonly disabled>
									</h2>
									<br>
								</div>



								<div class="details" style="margin-left: 100px;">
									<h2>
										관리자 권한 : <input type="checkbox" name="checkbox"
											class="checkbox" value="true">
									</h2>
									<br>
									<h2>
										<c:set var="isFlag" value="${user.admin}" />
										<c:choose>
											<c:when test="${isFlag == true}">
												관리자 입니다
											</c:when>
										</c:choose>
										<c:choose>
											<c:when test="${isFlag == false}">
												회원 입니다
											</c:when>
										</c:choose>
									</h2>
									<br> <br> <input class="update" type="submit"
										id="update" value="수정"><br>

								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</section>
	</main>
</body>
<style>
.member-info {
	background-color: #f0f0f0; /* 배경색 지정 */
	display: flex;
	align-items: center;
	margin: 50px;
	padding: 20px; /* 내부 여백 지정 */
	border-radius: 10px; /* 테두리 모서리 둥글게 만듦 */
}

.profile-picture img {
	width: 150px; /* 프로필 사진의 크기 조절 */
	height: 150px; /* 프로필 사진의 크기 조절 */
	border-radius: 50%; /* 프로필 사진을 원형으로 만듭니다. */
}

.details {
	margin-left: 20px; /* 회원 정보와 프로필 사진 사이의 간격 조절 */
}

.details h2 {
	font-size: 20px; /* 사용자 이름의 글꼴 크기 조절 */
	margin-bottom: 5px; /* 사용자 이름과 이메일 주소 사이의 간격 조절 */
}

.details p {
	font-size: 16px; /* 이메일 주소의 글꼴 크기 조절 */
	color: #666; /* 이메일 주소의 색상 변경 */
}

#wrap {
	width: 100%;
	top-margin: 30px;
}

#my_modal_delete {
	display: none;
	width: 350px;
	padding: 20px 60px;
	background-color: #fefefe;
	border: 1px solid #888;
	border-radius: 3px;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	z-index: 1000;
}

.close1 {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close1:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.update {
	background-color: #4CAF50; /* 버튼 배경색 */
	color: white; /* 버튼 글자색 */
	padding: 12px 20px; /* 내부 여백 */
	border: none; /* 테두리 없음 */
	border-radius: 4px; /* 버튼 모서리 둥글게 */
	cursor: pointer; /* 마우스 커서를 포인터로 변경 */
}

.delete-btn {
	background-color: #f44336; /* 삭제 버튼 배경색 */
	color: white; /* 삭제 버튼 글자색 */
	padding: 10px 20px; /* 내부 여백 */
	border: none; /* 테두리 없음 */
	border-radius: 4px; /* 버튼 모서리 둥글게 */
	cursor: pointer; /* 마우스 커서를 포인터로 변경 */
}

/* 버튼에 마우스를 올렸을 때의 스타일 */
.delete-btn:hover {
	background-color: #d32f2f;
}

.custom-input {
	width: 200px; /* 입력 상자의 너비 */
	padding: 10px; /* 내부 여백 */
	border: 1px solid #ccc; /* 테두리 스타일 및 색상 */
	border-radius: 4px; /* 입력 상자 모서리 둥글게 */
	font-size: 16px; /* 글꼴 크기 */
	outline: none; /* 포커스 시 테두리 제거 */
}

/* 입력 상자에 포커스를 받았을 때의 스타일 */
.custom-input:focus {
	border-color: #007bff; /* 포커스 시 테두리 색상 변경 */
}

.custom-file-upload {
	display: inline-block;
	padding: 10px 20px;
	cursor: pointer;
	color: black;
	border: none;
	border-radius: 4px;
	font-size: 16px;
}

/* 파일 업로드 버튼에 마우스를 올렸을 때의 스타일 */
.custom-file-upload:hover {
	background-color: #0056b3;
}

/* 파일 업로드 버튼에 포커스를 받았을 때의 스타일 */
.custom-file-upload:focus {
	outline: none;
}


</style>
</html>


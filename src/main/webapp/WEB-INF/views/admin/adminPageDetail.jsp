<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin-Detail</title>
<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<link rel="stylesheet" href="/css/free.css">

<style>
section {
	justify-content: center;
	align-items: center;
}
</style>
</head>
<body>
	<!-- 헤더 -->
	<%@ include file="../include/header.jsp"%>

	<!-- main -->
	<main id="main">
		<div id="slider">
			<div class="imageWrap1"></div>
		</div>

		<!-- section -->
		<section id="contents">

			<div class="noticeboard" style="margin-bottom: 20px;">
				<div class="title" style="margin: 0px;">
					<div class="vline"></div>
					<div class="container2">
						<h3>회원 정보</h3>
					</div>
				</div>
				<div class="title1" style="margin-left: 60px;">
					<div class="vline"></div>
					<h2>회원 상세정보</h2>
				</div>

				<div id="board-list">
					<div class="container2">

						<form action="/admin/${user.userId}" method="post"
							enctype="multipart/form-data"
							style="margin: 30px 60px 30px 60px;">

							<!-- 기존 div형식을 주석처리함(확인 후 지움) -->
							<%-- <div class="member-info">
								<div class="profile-picture">
									<c:if test="${user.userImageName eq null}">
									<img src="https://kr.object.ncloudstorage.com/team1bucket/profile/noprofile.png"><br>
									</c:if>
									<c:if test="${user.userImageName != null}">
									<img src="https://kr.object.ncloudstorage.com/team1bucket/profile/${user.userImageName}"><br>
									</c:if><br>
									<br>
								</div>
								<div class="details" style="margin-left: 100px;">
									<h2>
										아이디 : <img
											src="https://kr.object.ncloudstorage.com/team1bucket/badge/${user.badgeId}.png"
											width="30px" height="25px">${user.userId}
									</h2>
									<br>
									<h2>이름 : ${user.username}</h2>
									<br>
									<h2>이메일 : ${user.userEmail}</h2>
									<br>
									<h2>
										성별 :
										<c:set var="num" value="${user.gender}" />
										<c:choose>
											<c:when test="${num == 1}">
											        남자
											    </c:when>
											<c:when test="${num == 2}">
											        여자
											    </c:when>
										</c:choose>

									</h2>
									<br>
									<h2>승리 : ${user.wincount}</h2>
									<br>
									<h2>패배 : ${user.losecount}</h2>
									<br>
									<h2>게시글 수 : ${user.writeCount}</h2>
									<br>
								</div>



								<div class="details" style="margin-left: 100px;">
									<c:set var="isFlag" value="${user.admin}" />
									<h2>
										관리자 권한 : <input type="checkbox" name="checkbox"
											class="checkbox" value="true"
											<c:if test="${isFlag == true}">checked</c:if>>
									</h2>
									<br>
									<h2>
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
									<button type="submit" class="btn btn-primary goBtn updateBtn">수정</button>
									<button type="button" class="btn btn-primary goBtn updateBtn"
										onclick="redirectToPage()">목록</button>
								</div>
							</div> --%>
							<!-- //기존 div형식을 주석처리함(확인 후 지움) -->

							<!-- div를 table형식으로 변경함 -->
							<div style="float: right;">
								<c:set var="isFlag" value="${user.admin}" />
								<span class="checkbox-text"> <c:choose>
										<c:when test="${isFlag == true}">
											<span style="font-weight: bold; font-size: 14px;">&#10024;
												관리자 입니다</span>
										</c:when>
										<c:when test="${isFlag == false}">
											<span style="font-size: 14px;">&#9995;회원 입니다</span>
										</c:when>
									</c:choose>
								</span>
							</div>
							<table class="board-table">
								<colgroup>
									<col width="20%">
									<col width="10%">
									<col width="30%">
									<col width="10%">
									<col width="30%">
								</colgroup>
								<tbody>
									<tr>
										<td rowspan="4" colspan="1">
											<div class="profile-picture">
												<c:if test="${user.userImageName eq null}">
													<img
														src="https://kr.object.ncloudstorage.com/team1bucket/profile/noprofile.png">
												</c:if>
												<c:if test="${user.userImageName != null}">
													<img
														src="https://kr.object.ncloudstorage.com/team1bucket/profile/${user.userImageName}">
												</c:if>
											</div>
										</td>
										<th scope="row" bgcolor="#F9F9F9">아이디</th>
										<th scope="row" style="text-align: left; padding-left: 10px;">
											<img
											src="https://kr.object.ncloudstorage.com/team1bucket/badge/${user.badgeId}.png"
											width="18px" height="15px" style="margin-right: 3px;">${user.userId}
										</th>
										<th scope="row" bgcolor="#F9F9F9">이름</th>
										<td scope="row" style="text-align: left; padding-left: 10px;">${user.username}</td>
									</tr>
									<tr>
										<th scope="row" bgcolor="#F9F9F9">이메일</th>
										<td scope="row" style="text-align: left; padding-left: 10px;">${user.userEmail}</td>
										<th scope="row" bgcolor="#F9F9F9">성별</th>
										<td scope="row" style="text-align: left; padding-left: 10px;">
											<c:set var="num" value="${user.gender}" /> <c:choose>
												<c:when test="${num == 1}">
							                        남자
							                    </c:when>
												<c:when test="${num == 2}">
							                        여자
							                    </c:when>
											</c:choose>
										</td>
									</tr>
									<tr>
										<th scope="row" bgcolor="#F9F9F9">게시글 수</th>
										<td colspan="5" style="text-align: left; padding-left: 10px;">${user.writeCount}</td>
									</tr>
									<tr>
										<th scope="row" bgcolor="#F9F9F9">승리</th>
										<td scope="row" style="text-align: left; padding-left: 10px;">${user.wincount}</td>
										<th scope="row" bgcolor="#F9F9F9">패배</th>
										<td scope="row" style="text-align: left; padding-left: 10px;">${user.losecount}</td>
									</tr>
									<tr>
										<td colspan="5"><label class="checkbox-label"> <input
												type="checkbox" name="checkbox" class="checkbox"
												value="true" <c:if test="${isFlag == true}">checked</c:if>>
												<span class="checkbox-custom"></span>관리자 권한 <%-- <span class="checkbox-text">
								                <c:choose>
								                    <c:when test="${isFlag == true}">
								                        <span style="font-weight: bold;">&#11088; 관리자 입니다</span>
								                    </c:when>
								                    <c:when test="${isFlag == false}">
								                        - 회원 입니다
								                    </c:when>
								                </c:choose>
								            </span> --%>
										</label></td>
									</tr>
								</tbody>
							</table>

							<button type="submit" class="btn btn-primary goBtn updateBtn">수정</button>
							<button type="button" class="btn btn-primary goBtn updateBtn1"
								onclick="redirectToPage()">목록</button>

						</form>
					</div>
				</div>
			</div>
		</section>
	</main>

	<!-- footer -->
	<%@ include file="../include/footer.jsp"%>
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

/* 목록, 수정 버튼 css  */
.updateBtn, .updateBtn1 {
	margin: 10px 0px 0px 10px;
	padding: 10px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.updateBtn {
	background-color: #fff;
	color: rgb(0, 100, 0);
	border: 1px solid rgb(0, 100, 0);
}

.updateBtn:hover {
	background-color: rgb(34, 139, 34);
	color: #fff;
	border: 1px solid rgb(34, 139, 34);
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

.checkbox-label {
	display: flex;
	align-items: center;
	justify-content: center;
}

.checkbox {
	display: none;
}

.checkbox-custom {
	width: 20px;
	height: 20px;
	background-color: gray;
	border-radius: 3px;
	margin-right: 10px;
}

.checkbox-custom::after {
	content: "";
	display: none;
}

.checkbox:checked+.checkbox-custom::after {
	display: block;
	content: "";
	width: 12px;
	height: 10px;
	border: solid white;
	border-width: 0 3px 3px 0;
	transform: rotate(45deg);
	margin: 0 0 1px 3px;
}

.checkbox-text {
	margin-left: 5px;
	font-size: 13px;
}
</style>
<script>
	function redirectToPage() {
		// 원하는 페이지의 URL을 여기에 입력합니다.
		var desiredPageUrl = "/admin";

		// 페이지 이동
		window.location.href = desiredPageUrl;
	}
</script>
</html>


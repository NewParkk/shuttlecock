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
<link rel="stylesheet" href="/css/admin.css">

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
								enctype="multipart/form-data" style="margin: 30px 60px 30px 60px;">
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
							            <td colspan="5" style="text-align: left; padding-left:10px;">${user.writeCount}</td>
							        </tr>
							        <tr>
							            <th scope="row" bgcolor="#F9F9F9">승리</th>
							            <td scope="row" style="text-align: left; padding-left:10px;">${user.wincount}</td>
							            <th scope="row" bgcolor="#F9F9F9">패배</th>
							            <td scope="row" style="text-align: left; padding-left:10px;">${user.losecount}</td>
							        </tr>
							        <tr>
							            <td colspan="5">
							            <label class="checkbox-label">
								            <input type="checkbox" name="checkbox" class="checkbox" value="true"
								                   <c:if test="${isFlag == true}">checked</c:if>>
								            <span class="checkbox-custom"></span>관리자 권한
								        </label>
							            </td>
							        </tr>
							    </tbody>
							</table>

							<button type="submit" class="btn btn-primary goBtn updateBtn">수정</button>
							<button type="button" class="btn btn-primary goBtn updateBtn1"
								onclick="redirectToPage()">목록</button>

						</form>
					</div>
				</div>
				<!-- //board-list -->
			</div>
			<!-- //noticeboard -->
		</section>
		<!-- //section -->
	</main>
	<!-- //main -->

	<!-- footer -->
	<%@ include file="../include/footer.jsp"%>
</body>
<script>
	function redirectToPage() {
		// 원하는 페이지의 URL을 여기에 입력합니다.
		var desiredPageUrl = "/admin";

		// 페이지 이동
		window.location.href = desiredPageUrl;
	}
</script>
</html>


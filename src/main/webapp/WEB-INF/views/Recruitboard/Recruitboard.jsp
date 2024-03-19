<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle Cock</title>
<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<link rel="stylesheet" href="/css/free.css">
<style>
a:link {
	text-decoration: none;
	color: black;
}

a:visited {
	text-decoration: none;
}

a:hover {
	text-decoration: none;
}

a:active {
	text-decoration: none;
}

.clicked {
	font-weight: bold;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<!-- main -->
	<main id="boardmain">
		<section id="contents">

			<!-- aside -->
			<div class="aside">
				<div class="menubar">
					<ul>
						<li><a class="list" href="/Recruitboard?recruitType=0">전체</a></li>
						<li><a class="list" href="/Recruitboard?recruitType=1">리그
								단식</a></li>
						<li><a class="list" href="/Recruitboard?recruitType=2">리그
								복식</a></li>
						<li><a class="list" href="/Recruitboard?recruitType=3">단식</a></li>
						<li><a class="list" href="/Recruitboard?recruitType=4">복식</a></li>
						<li><a class="list" href="/Recruitboard?recruitType=5">심판</a></li>
					</ul>
				</div>
			</div>
			<!-- contents -->
			<div class="noticeboard">
				<div class="title" style="">
					<div class="vline"></div>
					<div class="container2">
						<h3>모집게시판</h3>
					</div>
				</div>
				<div id="board-list">
					<div class="container">
						<form action="/Recruitboard" method="get">
							<div class="search-wrap clearfix">
								<select id="category" name="category"
									style="width: 80px; margin-left: 45%">
									<option value="user_userId"
										${pageInfo.pageRequest.category == 'user_userId' ? 'selected' : ''}>
										작성자</option>
									<option value="title"
										${pageInfo.pageRequest.category == 'title' ? 'selected' : ''}>
										제목</option>
									<option value="content"
										${pageInfo.pageRequest.category == 'content' ? 'selected' : ''}>
										글내용</option>
								</select> <input id="searchKeyword" type="search" name="searchKeyword"
									placeholder="검색어를 입력해주세요." style=""
									value="${pageInfo.pageRequest.searchKeyword}"> <input
									name="pageNum" type="hidden"
									value="${pageInfo.pageRequest.pageNum}"> <input
									name="amount" type="hidden"
									value="${pageInfo.pageRequest.amount}"> <input
									name="region" type="hidden"
									value="${pageInfo.pageRequest.region}"> <input
									name="sort" type="hidden" value="${pageInfo.pageRequest.sort}">
								<input name="recruitType" type="hidden"
									value="${pageInfo.pageRequest.recruitType}">
								<button class="btn btn-primary search-btn" type="submit"
									style="margin-right: 24%">검색</button>
							</div>
						</form>

						<table class="table" style="width: 90%; margin: 0 auto;">
							<thead>
								<tr>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;" class="region-div"> <b><a
												href="/Recruitboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&recruitType=${pageInfo.pageRequest.recruitType}
										&region=0" <c:if test="${pageInfo.pageRequest.region eq 0}">style="text-decoration: underline;"</c:if>>전체</a></b>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;" class="region-div"> <b><a
												href="/Recruitboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&recruitType=${pageInfo.pageRequest.recruitType}
										&region=1" <c:if test="${pageInfo.pageRequest.region eq 1}">style="text-decoration: underline;"</c:if>>서울</a></b>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;" class="region-div"> <b><a
												href="/Recruitboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&recruitType=${pageInfo.pageRequest.recruitType}
										&region=2" <c:if test="${pageInfo.pageRequest.region eq 2}">style="text-decoration: underline;"</c:if>>경기</a></b>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;" class="region-div"> <b><a
												href="/Recruitboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&recruitType=${pageInfo.pageRequest.recruitType}
										&region=3" <c:if test="${pageInfo.pageRequest.region eq 3}">style="text-decoration: underline;"</c:if>>충청</a></b>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;" class="region-div"> <b><a
												href="/Recruitboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&recruitType=${pageInfo.pageRequest.recruitType}
										&region=4" <c:if test="${pageInfo.pageRequest.region eq 4}">style="text-decoration: underline;"</c:if>>경상</a></b>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;" class="region-div"> <b><a
												href="/Recruitboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&recruitType=${pageInfo.pageRequest.recruitType}
										&region=5" <c:if test="${pageInfo.pageRequest.region eq 5}">style="text-decoration: underline;"</c:if>>전라</a></b>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;" class="region-div"> <b><a
												href="/Recruitboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&recruitType=${pageInfo.pageRequest.recruitType}
										&region=6" <c:if test="${pageInfo.pageRequest.region eq 6}">style="text-decoration: underline;"</c:if>>강원</a></b>
									</span></th>
								</tr>
							</thead>
						</table>

						<!-- board list area -->
						<table class="board-table" style="width: 90%; margin: 0 auto; margin-top: 10px;">
							<thead>
								<tr>
									<th scope="col" class="th-num"><a
										href="/Recruitboard?sort=0">글번호</a></th>
									<th scope="col" class="th-writer">분류</th>
									<th scope="col" class="th-writer">지역</th>
									<th scope="col" class="th-title">제목</th>
									<th scope="col" class="th-writer">작성자</th>
									<th scope="col" class="th-date"><a
										href="/Recruitboard?sort=1">날짜</a></th>
									<th scope="col" class="th-hit"><a
										href="/Recruitboard?sort=2">조회수</a></th>
									<th scope="col" class="th-like"><a
										href="/Recruitboard?sort=3">추천</a></th>
									<th scope="col" class="th-like">모집여부</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${recruitboardList}" var="recruitboard">
									<tr>
										<th scope="row">${recruitboard.recruitboardId}</th>
										<td bgcolor=""><c:choose>
												<c:when test="${recruitboard.recruitType eq 0}">
														전체
													</c:when>
												<c:when test="${recruitboard.recruitType eq 1}">
														리그단식
													</c:when>
												<c:when test="${recruitboard.recruitType eq 2}">
														리그복식
													</c:when>
												<c:when test="${recruitboard.recruitType eq 3}">
														단식
													</c:when>
												<c:when test="${recruitboard.recruitType eq 4}">
														복식
													</c:when>
												<c:when test="${recruitboard.recruitType eq 5}">
														심판
													</c:when>
											</c:choose></td>
										<td bgcolor=""><c:choose>
												<c:when test="${recruitboard.region eq 0}">
													전체
												</c:when>
												<c:when test="${recruitboard.region eq 1}">
													서울
												</c:when>
												<c:when test="${recruitboard.region eq 2}">
													경기
												</c:when>
												<c:when test="${recruitboard.region eq 3}">
													충청
												</c:when>
												<c:when test="${recruitboard.region eq 4}">
													경상
												</c:when>
												<c:when test="${recruitboard.region eq 5}">
													전라
												</c:when>
												<c:when test="${recruitboard.region eq 6}">
													강원
												</c:when>
											</c:choose></td>
										<c:choose>
											<c:when test="${recruitboard.commentCount != 0}">
												<td bgcolor=""><a
													href="/Recruitboard/${recruitboard.recruitboardId}">${recruitboard.title}
														[${recruitboard.commentCount}]</a></td>
											</c:when>
											<c:when test="${recruitboard.commentCount == 0}">
												<td bgcolor=""><a
													href="/Recruitboard/${recruitboard.recruitboardId}">${recruitboard.title}</a>
												</td>
											</c:when>
										</c:choose>
										<td bgcolor="">${recruitboard.userId}</td>
										<td bgcolor=""><fmt:formatDate
												value="${recruitboard.regdate}" pattern="yyyy-MM-dd HH:mm" />
										</td>
										<td bgcolor="">${recruitboard.hit}</td>
										<td bgcolor="">${recruitboard.like}</td>
										<c:choose>
											<c:when test="${recruitboard.complete eq 1}">
												<td bgcolor="">모집완료</td>
											</c:when>
											<c:when test="${recruitboard.complete eq 0}">
												<td bgcolor="">모집중</td>
											</c:when>
										</c:choose>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<c:if test="${empty recruitboardList}">
							<div class="empty-post" style="text-align: center; margin-top: 10px;">게시물이
								없습니다.</div>
						</c:if>
					</div>
				</div>
				<c:choose>
					<c:when test="${sessionScope.userId == null}">
						<button onclick="redirectToLoginPage()"
							class="btn btn-primary whyBtn">글쓰기</button>
					</c:when>
					<c:otherwise>
						<button onclick="redirectToInsertForm()"
							class="btn btn-primary whyBtn">글쓰기</button>
					</c:otherwise>
				</c:choose>
				<div id="pageBtn" style="margin: 10px;">
					<div class="row justify-content-center"
						style="display: flex; justify-content: center;">
						<div class="col-auto">
							<table class="page navigation">
								<c:choose>
									<c:when
										test="${empty pageInfo.pageRequest.searchKeyword || pageInfo.pageRequest.searchKeyword == ''}">
										<tr class="pagination">
											<c:if test="${pageInfo.prev}">
												<th class="page-item"><a class="page-link"
													aria-label="Previous"
													href="/Recruitboard?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}
											&region=${pageInfo.pageRequest.region}&sort=${pageInfo.pageRequest.sort}
											&recruitType=${pageInfo.pageRequest.recruitType}">Prev</a>
												</th>
											</c:if>
											<c:forEach var="num" begin="${pageInfo.startPage}"
												end="${pageInfo.endPage}">
												<th
													class="page-item ${pageInfo.pageRequest.pageNum == num ? "active" : "" } ">
													<a class="page-link" style="padding: 10px;"
													href="/Recruitboard?pageNum=${num}&amount=${pageInfo.pageRequest.amount}
											&region=${pageInfo.pageRequest.region}&sort=${pageInfo.pageRequest.sort}
											&recruitType=${pageInfo.pageRequest.recruitType}">${num}
												</a>
												</th>
											</c:forEach>
											<c:if test="${pageInfo.next}">
												<th class="page-item next"><a class="page-link"
													aria-label="next"
													href="/Recruitboard?pageNum=${pageInfo.endPage + 1}&amount=${pageInfo.pageRequest.amount}
											&region=${pageInfo.pageRequest.region}&sort=${pageInfo.pageRequest.sort}
											&recruitType=${pageInfo.pageRequest.recruitType}">Next</a>
												</th>
											</c:if>
										</tr>
									</c:when>
									<c:when test="${pageInfo.pageRequest.searchKeyword != null}">
										<tr class="pagination">
											<c:if test="${pageInfo.prev}">
												<th class="page-item"><a class="page-link"
													aria-label="Previous"
													href="/Recruitboard?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}
													&searchKeyword=${pageInfo.pageRequest.searchKeyword}
													&category=${pageInfo.pageRequest.category}&region=${pageInfo.pageRequest.region}
													&sort=${pageInfo.pageRequest.sort}&recruitType=${pageInfo.pageRequest.recruitType}">Prev</a>
												</th>
											</c:if>
											<c:forEach var="num" begin="${pageInfo.startPage}"
												end="${pageInfo.endPage}">
												<th
													class="page-item ${pageInfo.pageRequest.pageNum == num ? "active" : "" } ">
													<a class="page-link" style="padding: 10px;"
													href="/Recruitboard?pageNum=${num}&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}&region=${pageInfo.pageRequest.region}
										&sort=${pageInfo.pageRequest.sort}&recruitType=${pageInfo.pageRequest.recruitType}">${num}
												</a>
												</th>
											</c:forEach>
											<c:if test="${pageInfo.next}">
												<th class="page-item next"><a class="page-link"
													aria-label="next"
													href="/Recruitboard?pageNum=${pageInfo.endPage + 1}&amount=${pageInfo.pageRequest.amount}
													&searchKeyword=${pageInfo.pageRequest.searchKeyword}
													&category=${pageInfo.pageRequest.category}&region=${pageInfo.pageRequest.region}
													&sort=${pageInfo.pageRequest.sort}&recruitType=${pageInfo.pageRequest.recruitType}">Next</a>
												</th>
											</c:if>
										</tr>
									</c:when>
								</c:choose>
							</table>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<!-- wrap -->
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script>
		function redirectToInsertForm() {
			window.location.href = "/Recruitboard/insert";
		}
		function redirectToLoginPage() {
			window.location.href = "/login";
		}
		function checkKeyword() {
			let mainForm = document.getElementById('mainForm');
			// 검색 시 항상 pageNum을 1로 설정
			mainForm.pageNum.value = 1;
			if (mainForm.searchKeyword.value === null
					|| mainForm.searchKeyword.value === '') {
				mainForm.searchKeyword.remove();
			}
		}
		$('.region-div').click(function() {
			$(this).addClass('clicked');
		});
	</script>
</body>
</html>

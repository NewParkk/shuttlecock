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
<!-- <link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"> -->
<style>
.info p {
	white-space: pre-wrap; /* Or normal */
}

.container1 {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
	width: 80%;
	margin: 0 auto;
}

.image-container {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin: 10px;
}

.image {
	width: 200px;
	height: 200px;
	object-fit: cover;
}

.info {
	display: flex;
	justify-content: space-between;
	width: 100%;
	margin-top: 5px;
}

.info p {
	margin: 0;
	padding: 0 5px;
}

.mainTitle {
	text-align: center;
}

.whyBtn {
	margin-left: 46%;
}

.whyBtn1 {
	margin-left: 69%;
}

.del-btn {
	margin-left: 95%
}

h1 {
	padding-top: 30px;
	padding-bottom: 30px
}

.paging {
	margin-left: auto;
	margin-right: auto;
	display: table;
}

.whyBtn {
	margin-left: 80%;
	margin-top: 30px;
}

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
/*---검색버튼--- */
.search-wrap {
	overflow: hidden; /*부모요소에 히든 */
	margin-bottom: 20px;
}

.search-btn, .search-input, .search-select {
	float: right; /*우측 플로팅 */
}

.search-input {
	width: 140px;
}

#search-select {
	width: 80px;
}
</style>
</head>
<body>
	<div id="wrap">
		<spring:eval
			expression="@environment.getProperty('NCP.STORAGE.APIURL')"
			var="imgUrl" />
		<%@ include file="/WEB-INF/views/include/header.jsp"%>
		<%-- <%@ include file="category.jsp"%> --%>
		<!-- main -->
		<main id="main">
			<section id="section">
				<!-- aside -->
				<div class="aside">
					<div class="menubar">
						<ul>
							<li><a href="/Recruitboard?recruitType=0">전체</a></li>
							<li><a href="/Recruitboard?recruitType=1">리그 단식</a></li>
							<li><a href="/Recruitboard?recruitType=2">리그 복식</a></li>
							<li><a href="/Recruitboard?recruitType=3">단식</a></li>
							<li><a href="/Recruitboard?recruitType=4">복식</a></li>
							<li><a href="/Recruitboard?recruitType=5">심판</a></li>
						</ul>
					</div>
				</div>
				<!-- contents -->
				<div class="contents">
					<div class="title" style="">
						<div class="vline"></div>
						<h2>모집게시판</h2>
					</div>
					<div class="container">
						<form action="/Recruitboard" method="get">
							<div class="search-wrap clearfix">
								<select id="category" name="category"
									style="width: 80px; margin-left: 54%">
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
									placeholder="검색어를 입력해주세요."
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
									style="margin-right: 16%">검색</button>
							</div>
						</form>

						<table class="table" style="width: 70%; margin: 0 auto;">
							<thead>
								<tr>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;"> <b><a
												href="/Recruitboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&recruitType=${pageInfo.pageRequest.recruitType}
										&region=0">전체</a></b>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;"> <b><a
												href="/Recruitboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&recruitType=${pageInfo.pageRequest.recruitType}
										&region=1">서울</a></b>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;"> <b><a
												href="/Recruitboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&recruitType=${pageInfo.pageRequest.recruitType}
										&region=2">경기</a></b>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;"> <b><a
												href="/Recruitboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&recruitType=${pageInfo.pageRequest.recruitType}
										&region=3">충청</a></b>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;"> <b><a
												href="/Recruitboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&recruitType=${pageInfo.pageRequest.recruitType}
										&region=4">경상</a></b>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;"> <b><a
												href="/Recruitboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&recruitType=${pageInfo.pageRequest.recruitType}
										&region=5">전라</a></b>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;"> <b><a
												href="/Recruitboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&recruitType=${pageInfo.pageRequest.recruitType}
										&region=6">강원</a></b>
									</span></th>
								</tr>
							</thead>
						</table>

						<!-- board list area -->
						<div id="board-list">
							<div class="container">
								<table class="table" style="width: 70%; margin: 0 auto;">
									<thead>
										<tr>
											<th scope="col" style="text-align: center;"><a
												href="/Recruitboard?sort=0">글번호</a></th>
											<th scope="col" style="text-align: center;">분류</th>
											<th scope="col" style="text-align: center;">지역</th>
											<th scope="col" style="text-align: center;">제목</th>
											<th scope="col" style="text-align: center;">작성자</th>
											<th scope="col" style="text-align: center;"><a
												href="/Recruitboard?sort=1">날짜</a></th>
											<th scope="col" style="text-align: center;"><a
												href="/Recruitboard?sort=2">조회수</a></th>
											<th scope="col" style="text-align: center;"><a
												href="/Recruitboard?sort=3">추천</a></th>
											<th scope="col" style="text-align: center;">모집여부</th>
										</tr>
									</thead>
									<c:forEach items="${recruitboardList}" var="recruitboard">
										<tbody>
											<tr>
												<td bgcolor="">
													<p align="center">
														<span style="font-size: 12pt;"> <b>${recruitboard.recruitboardId}</b>
														</span>
													</p>
												</td>
												<td bgcolor="">
													<p align="center">
														<c:choose>
															<c:when test="${recruitboard.recruitType eq 0}">
																<span style="font-size: 12pt;"> <b>전체</b></span>
															</c:when>
															<c:when test="${recruitboard.recruitType eq 1}">
																<span style="font-size: 12pt;"> <b>리그단식</b></span>
															</c:when>
															<c:when test="${recruitboard.recruitType eq 2}">
																<span style="font-size: 12pt;"> <b>리그복식</b></span>
															</c:when>
															<c:when test="${recruitboard.recruitType eq 3}">
																<span style="font-size: 12pt;"> <b>단식</b></span>
															</c:when>
															<c:when test="${recruitboard.recruitType eq 4}">
																<span style="font-size: 12pt;"> <b>복식</b></span>
															</c:when>
															<c:when test="${recruitboard.recruitType eq 5}">
																<span style="font-size: 12pt;"> <b>심판</b></span>
															</c:when>
														</c:choose>
													</p>
												</td>
												<td bgcolor="">
													<p align="center">
														<span style="font-size: 12pt;"> <c:choose>
																<c:when test="${recruitboard.region eq 0}">
																	<b>전체</b>
																</c:when>
																<c:when test="${recruitboard.region eq 1}">
																	<b>서울</b>
																</c:when>
																<c:when test="${recruitboard.region eq 2}">
																	<b>경기</b>
																</c:when>
																<c:when test="${recruitboard.region eq 3}">
																	<b>충청</b>
																</c:when>
																<c:when test="${recruitboard.region eq 4}">
																	<b>경상</b>
																</c:when>
																<c:when test="${recruitboard.region eq 5}">
																	<b>전라</b>
																</c:when>
																<c:when test="${recruitboard.region eq 6}">
																	<b>강원</b>
																</c:when>
															</c:choose>
														</span>
													</p>
												</td>
												<c:choose>
													<c:when test="${recruitboard.commentCount != 0}">
														<td bgcolor="">
															<p align="center">
																<span style="font-size: 12pt;"> <b><a
																		href="/Recruitboard/${recruitboard.recruitboardId}">${recruitboard.title}
																			[${recruitboard.commentCount}]</a></b>
																</span>
															</p>
														</td>
													</c:when>
													<c:when test="${recruitboard.commentCount == 0}">
														<td bgcolor="">
															<p align="center">
																<span style="font-size: 12pt;"> <b><a
																		href="/Recruitboard/${recruitboard.recruitboardId}">${recruitboard.title}</a></b>
																</span>
															</p>
														</td>
													</c:when>
												</c:choose>
												<td bgcolor="">
													<p align="center">
														<span style="font-size: 12pt;"> <b>${recruitboard.userId}</b>
														</span>
													</p>
												</td>
												<td bgcolor="">
													<p align="center">
														<span style="font-size: 12pt;"> <b><fmt:formatDate
																	value="${recruitboard.regdate}"
																	pattern="yyyy-MM-dd HH:mm" /></b>
														</span>
													</p>
												</td>
												<td bgcolor="">
													<p align="center">
														<span style="font-size: 12pt;"> <b>${recruitboard.hit}</b>
														</span>
													</p>
												</td>
												<td bgcolor="">
													<p align="center">
														<span style="font-size: 12pt;"> <b>${recruitboard.like}</b>
														</span>
													</p>
												</td>
												<c:choose>
													<c:when test="${recruitboard.complete eq 1}">
														<td bgcolor="">
															<p align="center">
																<span style="font-size: 12pt;"> <b>모집완료</b>
																</span>
															</p>
														</td>
													</c:when>
													<c:when test="${recruitboard.complete eq 0}">
														<td bgcolor="">
															<p align="center">
																<span style="font-size: 12pt;"> <b>모집중</b>
																</span>
															</p>
														</td>
													</c:when>
												</c:choose>
											</tr>
										</tbody>
									</c:forEach>
								</table>
								<c:if test="${empty recruitboardList}">
									<div class="empty-post" style="text-align: center;">게시물이
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
				</div>
			</section>
		</main>
		<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	</div>
	<!-- wrap -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
	</script>
</body>
</html>

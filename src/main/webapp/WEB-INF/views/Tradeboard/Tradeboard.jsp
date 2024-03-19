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
.grid-container {
	display: inline-block;
}

.container1 {
	padding: 20px;
	display: inline-block;
	width: 190px;
	height: 400px justify-content: space-between;
	flex-direction: column;
}

.container1 img {
	width: 150px;
	height: 150px;
	overflow: hidden;
}

.container1 a {
	width: 150px;
	height: 150px;
	overflow: hidden;
}

.container1 dl {
	width: 150px;
	height: 120px;
	margin-top: 10px;
}

.info {
	width: 200px;
	height: 150px;
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

.clicked {
	font-weight: bold;
}
</style>
</head>
<body>
	<spring:eval
		expression="@environment.getProperty('NCP.STORAGE.APIURL')"
		var="imgUrl" />
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<!-- main -->
	<main id="boardmain">
		<section id="contents">
			<!-- aside -->
			<div class="aside">
				<div class="menubar">
					<ul>
						<li><a class="list" href="/Tradeboard?itemClass=0">전체</a></li>
						<li><a class="list" href="/Tradeboard?itemClass=1">의류</a></li>
						<li><a class="list" href="/Tradeboard?itemClass=2">라켓</a></li>
						<li><a class="list" href="/Tradeboard?itemClass=3">보호대</a></li>
						<li><a class="list" href="/Tradeboard?itemClass=4">신발</a></li>
						<li><a class="list" href="/Tradeboard?itemClass=5">기타</a></li>
					</ul>
				</div>
			</div>
			<!-- contents -->
			<div class="noticeboard">
				<div class="title" style="">
					<div class="vline"></div>
					<div class="container2">
						<h3>물품거래소</h3>
					</div>
				</div>
				<div id="board-list">
					<div class="container">
						<form action="/Tradeboard" method="get">
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
									placeholder="검색어를 입력해주세요."
									value="${pageInfo.pageRequest.searchKeyword}"> <input
									name="pageNum" type="hidden"
									value="${pageInfo.pageRequest.pageNum}"> <input
									name="amount" type="hidden"
									value="${pageInfo.pageRequest.amount}"> <input
									name="region" type="hidden"
									value="${pageInfo.pageRequest.region}"> <input
									name="sort" type="hidden" value="${pageInfo.pageRequest.sort}">
								<input name="itemClass" type="hidden"
									value="${pageInfo.pageRequest.itemClass}">
								<button class="btn btn-primary search-btn" type="submit"
									style="margin-right: 24%">검색</button>
							</div>
						</form>

						<table class="table" style="width: 90%; margin: 0 auto;">
							<thead>
								<tr>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;"> <a class="region-div"
											href="/Tradeboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&itemClass=${pageInfo.pageRequest.itemClass}
										&region=0"
											<c:if test="${pageInfo.pageRequest.region eq 0}">style="text-decoration: underline;"</c:if>>전체</a>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;"> <a class="region-div"
											href="/Tradeboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&itemClass=${pageInfo.pageRequest.itemClass}
										&region=1" <c:if test="${pageInfo.pageRequest.region eq 1}">style="text-decoration: underline;"</c:if>>서울</a>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;"> <a class="region-div"
											href="/Tradeboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&itemClass=${pageInfo.pageRequest.itemClass}
										&region=2" <c:if test="${pageInfo.pageRequest.region eq 2}">style="text-decoration: underline;"</c:if>>경기</a>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;"> <a class="region-div"
											href="/Tradeboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&itemClass=${pageInfo.pageRequest.itemClass}
										&region=3" <c:if test="${pageInfo.pageRequest.region eq 3}">style="text-decoration: underline;"</c:if>>충청</a>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;"> <a class="region-div"
											href="/Tradeboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&itemClass=${pageInfo.pageRequest.itemClass}
										&region=4" <c:if test="${pageInfo.pageRequest.region eq 4}">style="text-decoration: underline;"</c:if>>경상</a>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;"> <a class="region-div"
											href="/Tradeboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&itemClass=${pageInfo.pageRequest.itemClass}
										&region=5" <c:if test="${pageInfo.pageRequest.region eq 5}">style="text-decoration: underline;"</c:if>>전라</a>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;"> <a class="region-div"
											href="/Tradeboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&itemClass=${pageInfo.pageRequest.itemClass}
										&region=6" <c:if test="${pageInfo.pageRequest.region eq 6}">style="text-decoration: underline;"</c:if>>강원</a>
									</span></th>
								</tr>
							</thead>
						</table>
						<table class="board-table" style="width: 90%; margin: 0 auto; margin-top: 10px;">
							<thead>
								<tr>
									<th scope="col" style="text-align: center;"><a
										href="/Tradeboard?sort=0&region=${pageInfo.pageRequest.region}&itemClass=${pageInfo.pageRequest.itemClass}">글번호순</a></th>
									<th scope="col" style="text-align: center;"><a
										href="/Tradeboard?sort=1&region=${pageInfo.pageRequest.region}&itemClass=${pageInfo.pageRequest.itemClass}">최신순</a></th>
									<th scope="col" style="text-align: center;"><a
										href="/Tradeboard?sort=2&region=${pageInfo.pageRequest.region}&itemClass=${pageInfo.pageRequest.itemClass}">조회수순</a></th>
									<th scope="col" style="text-align: center;"><a
										href="/Tradeboard?sort=3&region=${pageInfo.pageRequest.region}&itemClass=${pageInfo.pageRequest.itemClass}">추천순</a></th>
								</tr>
							</thead>
						</table>
						<div class="grid-container">
							<c:forEach items="${tradeboardList}" var="tradeboard">
								<div class="container1">
									<a href="/Tradeboard/${tradeboard.tradeboardId}"><img
										src="${imgUrl}/boardFile/3_${tradeboard.imageName}.png"></a><br>
									<dl class="info">
										<c:choose>
											<c:when test="${tradeboard.commentCount != 0}">
												<dt align="center">
													<span style="font-size: 13pt;"> <b><a
															href="/Tradeboard/${tradeboard.tradeboardId}">${tradeboard.title}[${tradeboard.commentCount}]</a></b>
													</span>
												</dt>
											</c:when>
											<c:when test="${tradeboard.commentCount == 0}">
												<dt align="center">
													<span style="font-size: 13pt;"> <b><a
															href="/Tradeboard/${tradeboard.tradeboardId}">${tradeboard.title}</a></b>
													</span>
												</dt>
											</c:when>
										</c:choose>
										<dd align="center">
											<span style="font-size: 11pt;"> <b>조회:
													${tradeboard.hit}</b>
											</span> <span style="font-size: 11pt;"> <b>추천:
													${tradeboard.like}</b>
											</span>
										</dd>
										<dd align="center">
											<span style="font-size: 11pt;"> <b><fmt:formatDate
														value="${tradeboard.regdate}" pattern="yyyy-MM-dd HH:mm" /></b>
											</span>
										</dd>
										<dd align="center">
											<span style="font-size: 11pt;"> <b>${tradeboard.userId}</b>
											</span><br>
										</dd>
										<c:choose>
											<c:when test="${tradeboard.complete eq 1}">
												<dd align="center">
													<span style="font-size: 11pt;"> <b>판매완료</b>
													</span>
												</dd>
											</c:when>
											<c:when test="${tradeboard.complete eq 0}">
												<dd align="center">
													<span style="font-size: 11pt;"> <b>판매중</b>
													</span>
												</dd>
											</c:when>
										</c:choose>
									</dl>

								</div>
							</c:forEach>
						</div>
						<c:if test="${empty tradeboardList}">
							<div class="empty-post" style="text-align: center; margin-top: 10px;">게시물이
								없습니다.</div>
						</c:if>
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
														href="/Tradeboard?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}
											&region=${pageInfo.pageRequest.region}&sort=${pageInfo.pageRequest.sort}
											&itemClass=${pageInfo.pageRequest.itemClass}">Prev</a>
													</th>
												</c:if>
												<c:forEach var="num" begin="${pageInfo.startPage}"
													end="${pageInfo.endPage}">
													<th
														class="page-item ${pageInfo.pageRequest.pageNum == num ? "active" : "" } ">
														<a class="page-link" style="padding: 10px;"
														href="/Tradeboard?pageNum=${num}&amount=${pageInfo.pageRequest.amount}
											&region=${pageInfo.pageRequest.region}&sort=${pageInfo.pageRequest.sort}
											&itemClass=${pageInfo.pageRequest.itemClass}">${num}
													</a>
													</th>
												</c:forEach>
												<c:if test="${pageInfo.next}">
													<th class="page-item next"><a class="page-link"
														aria-label="next"
														href="/Tradeboard?pageNum=${pageInfo.endPage + 1}&amount=${pageInfo.pageRequest.amount}
											&region=${pageInfo.pageRequest.region}&sort=${pageInfo.pageRequest.sort}
											&itemClass=${pageInfo.pageRequest.itemClass}">Next</a>
													</th>
												</c:if>
											</tr>
										</c:when>
										<c:when test="${pageInfo.pageRequest.searchKeyword != null}">
											<tr class="pagination">
												<c:if test="${pageInfo.prev}">
													<th class="page-item"><a class="page-link"
														aria-label="Previous"
														href="/Tradeboard?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}
													&searchKeyword=${pageInfo.pageRequest.searchKeyword}
													&category=${pageInfo.pageRequest.category}&region=${pageInfo.pageRequest.region}
													&sort=${pageInfo.pageRequest.sort}&itemClass=${pageInfo.pageRequest.itemClass}">Prev</a>
													</th>
												</c:if>
												<c:forEach var="num" begin="${pageInfo.startPage}"
													end="${pageInfo.endPage}">
													<th
														class="page-item ${pageInfo.pageRequest.pageNum == num ? "active" : "" } ">
														<a class="page-link" style="padding: 10px;"
														href="/Tradeboard?pageNum=${num}&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}&region=${pageInfo.pageRequest.region}
										&sort=${pageInfo.pageRequest.sort}&itemClass=${pageInfo.pageRequest.itemClass}">${num}
													</a>
													</th>
												</c:forEach>
												<c:if test="${pageInfo.next}">
													<th class="page-item next"><a class="page-link"
														aria-label="next"
														href="/Tradeboard?pageNum=${pageInfo.endPage + 1}&amount=${pageInfo.pageRequest.amount}
													&searchKeyword=${pageInfo.pageRequest.searchKeyword}
													&category=${pageInfo.pageRequest.category}&region=${pageInfo.pageRequest.region}
													&sort=${pageInfo.pageRequest.sort}&itemClass=${pageInfo.pageRequest.itemClass}">Next</a>
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
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script>
		function redirectToInsertForm() {
			window.location.href = "/Tradeboard/insert";
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
	    function makeBold(element) {
	    	element.style.textDecoration = 'underline';
	    }

	    document.querySelectorAll('.region-div').forEach(item => {
	        item.addEventListener('click', event => {
	            makeBold(event.target);
	        });
	    });
	</script>
</body>
</html>

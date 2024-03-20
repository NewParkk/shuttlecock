<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle Cock</title>
<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<link rel="stylesheet" href="/css/free.css">

<style>
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

.card-container {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}

.card {
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	padding: 20px;
	margin: 10px;
	width: 300px;
	max-width: 80%;
}

.card img {
	width: 100%;
	border-radius: 8px;
	margin-bottom: 10px;
}

.card h2 {
	margin-top: 0;
	margin-bottom: 10px;
}

.card p {
	margin-top: 0;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<main id="boardmain">
		<section id="contents">

			<div class="aside">
				<div class="menubar">
					<ul>
						<li><a class="list" href="/LeagueBoard">리그게시판</a></li>
						<li><a class="list" href="/LeagueBoardRanking">리그순위</a></li>
					</ul>
				</div>
			</div>

			<div class="noticeboard">
				<div class="title" style="">
					<div class="vline"></div>
					<div class="container2">
						<h3>리그 순위</h3>
					</div>
				</div>
				<div id="board-list">
					<div class="container">
						<form action="/LeagueBoard/search" method="get">
							<div class="search-wrap clearfix">
								<input id="searchKeyword" type="search" name="searchKeyword"
									placeholder="이름을 입력해주세요."
									value="${pageInfo.pageRequest.searchKeyword}"> <input
									name="pageNum" type="hidden"
									value="${pageInfo.pageRequest.pageNum}"> <input
									name="sort" type="hidden" value="${pageInfo.pageRequest.sort}">
								<input name="amount" type="hidden"
									value="${pageInfo.pageRequest.amount}">
								<button class="btn btn-primary search-btn" type="submit"
									style="margin-right: 24%">검색</button>
							</div>
						</form>
						<!-- board list area -->
						<table class="board-table" style="width: 90%; margin: 0 auto;">
							<thead>
								<tr>
									<th scope="col" class="th-num"><a
										href="/LeagueBoard?sort=0">등수</a></th>
									<th scope="col" class="th-title">유저</th>
									<th scope="col" class="th-title">승</th>
									<th scope="col" class="th-title">패</th>
									<th scope="col" class="th-title">승점</th>
									<th scope="col" class="th-title">승률</th>
									<!-- <th scope="col">조회수</th> -->
									
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${leagueRankingList}" var="user">
									<div class="card">
										<p>${user.username}(${user.userId})
											<img src=""> ${user.wincount} ${user.losecount}
											${user.wincount - user.losecount} <b> <c:set
													var="winRatio"
													value="${(user.wincount * 1.0 / (user.wincount + user.losecount)) * 100}" />
												<fmt:formatNumber value="${winRatio}" pattern="###.##" />%
											</b>
										</p>
									</div>
								</c:forEach>
							</tbody>
						</table>
						<c:if test="${empty leagueRankingList}">
							<div class="empty-post"
								style="text-align: center; margin-top: 10px;">리그에 참여한 유저가 없습니다.</div>
						</c:if>
					</div>

					<div id="pageBtn" style="margin: 10px;">
						<div class="row justify-content-center"
							style="display: flex; justify-content: center;">
							<div class="col-auto">
								<table class="page navigation">
									<tr class="pagination">
										<c:if test="${pageInfo.prev}">
											<th class="page-item"><a class="page-link"
												aria-label="Previous"
												href="/LeagueBoard?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}
													&searchKeyword=${pageInfo.pageRequest.searchKeyword}">Prev</a>
											</th>
										</c:if>
										<c:if test="${pageInfo.pageRequest.category == null}">
											<c:forEach var="num" begin="${pageInfo.startPage}"
												end="${pageInfo.endPage}">
												<th
													class="page-item ${pageInfo.pageRequest.pageNum == num ? "active" : "" } ">
													<a class="page-link" style="padding: 10px;"
													href="/LeagueBoard?pageNum=${num}&amount=${pageInfo.pageRequest.amount}&sort=${pageInfo.pageRequest.sort}
 													">${num}</a>
												</th>
											</c:forEach>
										</c:if>
										<c:if test="${pageInfo.pageRequest.category != null}">
											<c:forEach var="num" begin="${pageInfo.startPage}"
												end="${pageInfo.endPage}">
												<th
													class="page-item ${pageInfo.pageRequest.pageNum == num ? "active" : "" } ">
													<a class="page-link" style="padding: 10px;"
													href="/LeagueBoard/search?pageNum=${num}&amount=${pageInfo.pageRequest.amount}&searchKeyword=${pageInfo.pageRequest.searchKeyword}
									&dropdown=${pageInfo.pageRequest.category}&sort=${pageInfo.pageRequest.sort}
 													">${num}</a>
												</th>
											</c:forEach>
										</c:if>
										<c:if test="${pageInfo.next}">
											<th class="page-item next"><a class="page-link"
												aria-label="next"
												href="/LeagueBoard?pageNum=${pageInfo.endPage + 1}&amount=${pageInfo.pageRequest.amount}
													&searchKeyword=${pageInfo.pageRequest.searchKeyword}">Next</a>
											</th>
										</c:if>
									</tr>
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
			window.location.href = "/LeagueBoard/insert";
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

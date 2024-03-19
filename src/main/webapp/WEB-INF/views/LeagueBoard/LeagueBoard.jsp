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
						<h3>리그게시판</h3>
					</div>
				</div>
				<div id="board-list">
					<div class="container">
						<form action="/LeagueBoard/search" method="get">
							<div class="search-wrap clearfix">
								<select id="dropdown" name="dropdown"
									style="width: 80px; margin-left: 45%">
									<option value="user_userId"
										${pageInfo.pageRequest.category == 'user_userId' ? 'selected' : ''}>
										작성자</option>
									<option value="title"
										${pageInfo.pageRequest.category == 'title' ? 'selected' : ''}>
										제목</option>
								</select> <input id="searchKeyword" type="search" name="searchKeyword"
									placeholder="검색어를 입력해주세요."
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
										href="/LeagueBoard?sort=0">글번호</a></th>
									<th scope="col" class="th-title">제목</th>
									<th scope="col" class="th-title">작성자</th>
									<th scope="col" class="th-date"><a
										href="/LeagueBoard?sort=1">날짜</a></th>
									<!-- <th scope="col">조회수</th> -->
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${leagueboardList}" var="leagueboard">
									<tr>
										<th scope="row" bgcolor="">${leagueboard.leagueboardId}</th>
										<td bgcolor=""><a
											href="/LeagueBoard/${leagueboard.leagueboardId}">${leagueboard.title}</a>
										</td>
										<td bgcolor="">${leagueboard.userId}</td>
										<td bgcolor=""><fmt:formatDate
												value="${leagueboard.regdate}" pattern="yyyy-MM-dd HH:mm" />
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<c:if test="${empty leagueboardList}">
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

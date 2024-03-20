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
.current-page {
	background-color: #405448 !important;
	color: #fff !important;
	padding: 5px 10px !important;
	border-radius: 5px !important;
}

.search-wrap {
	display: flex !important;
	justify-content: center !important;
	align-items: center !important;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<main id="boardmain">
		<section id="contents">

			<%@ include file="category.jsp"%>

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
								<select name="dropdown" style="width: 100px; margin-left: 10px;"
									class="form-control" id="search-select">
									<option value="user_userId"
										${pageInfo.pageRequest.category == 'user_userId' ? 'selected' : ''}>
										작성자</option>
									<option value="title"
										${pageInfo.pageRequest.category == 'title' ? 'selected' : ''}>
										제목</option>
								</select> <input id="searchKeyword" type="search" name="searchKeyword"
									placeholder="검색어를 입력해주세요." style="width: 300px;"
									class="form-control search-input"
									value="${pageInfo.pageRequest.searchKeyword}"> <input
									name="pageNum" type="hidden"
									value="${pageInfo.pageRequest.pageNum}"> <input
									name="sort" type="hidden" value="${pageInfo.pageRequest.sort}">
								<input name="amount" type="hidden"
									value="${pageInfo.pageRequest.amount}">
								<button class="btn btn-primary search-btn" type="submit"
									style="margin-left: 10px">검색</button>
							</div>
						</form>
						<form id="sortForm" action="/LeagueBoard" method="get">
							<select name="sort" id="sort" class="sort-select"
								onchange="submitForm()">
								<option value="0"
									${pageInfo.pageRequest.sort == '0' ? 'selected' : ''}>글번호순</option>
								<option value="1"
									${pageInfo.pageRequest.sort == '1' ? 'selected' : ''}>최신순</option>
							</select> <input name="pageNum" type="hidden"
								value="${pageInfo.pageRequest.pageNum}"> <input
								name="amount" type="hidden"
								value="${pageInfo.pageRequest.amount}"> <input
								name="searchKeyword" type="hidden"
								value="${pageInfo.pageRequest.searchKeyword}"> <input
								name="category" type="hidden"
								value="${pageInfo.pageRequest.category}">
						</form>

						<!-- board list area -->
						<table class="board-table" style="width: 90%; margin: 20px auto 0"">
							<thead>
								<tr>
									<th scope="col" class="th-num">글번호</th>
									<th scope="col" class="th-title">제목</th>
									<th scope="col" class="th-title">작성자</th>
									<th scope="col" class="th-date">날짜</th>
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
							<div class="empty-post"
								style="text-align: center; margin-top: 10px;">게시물이 없습니다.</div>
						</c:if>
					</div>
					<div class="newsWrite" style="margin-top: 20px;">
						<c:choose>
							<c:when test="${sessionScope.userId == null}">
								<button onclick="redirectToLoginPage()"
									class="btn btn-primary WriteBtn">글작성</button>
							</c:when>
							<c:otherwise>
								<button onclick="redirectToInsertForm()"
									class="btn btn-primary WriteBtn">글작성</button>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="paging">
						<div class="row justify-content-center"
							style="display: flex; justify-content: center;">
							<div class="col-auto">
								<table class="page navigation">
									<tr class="pagination">
										<c:if test="${pageInfo.prev}">
											<th class="page-item"><a class="page-link"
												aria-label="Previous"
												href="/LeagueBoard?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}
													&searchKeyword=${pageInfo.pageRequest.searchKeyword}&dropdown=${pageInfo.pageRequest.category}&sort=${pageInfo.pageRequest.sort}">Prev</a>
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
													&searchKeyword=${pageInfo.pageRequest.searchKeyword}&dropdown=${pageInfo.pageRequest.category}&sort=${pageInfo.pageRequest.sort}">Next</a>
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

		function submitForm() {
			document.getElementById("sortForm").submit();
		}

		window.onload = function() {
			const pageNum = ${pageInfo.pageRequest.pageNum};
			console.log(pageNum);
			$('#pbtn_' + pageNum).toggleClass('current-page');
		};
	</script>
</body>
</html>

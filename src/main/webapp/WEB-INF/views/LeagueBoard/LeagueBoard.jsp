<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle Cock</title>
<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<!-- aisde-js 파일 -->
<script src="/js/aside-js.js"></script>
<link rel="stylesheet" href="/css/free.css">
<style>
.current-page {
   background-color: #607d67 !important;
   color: #fff !important;
   padding: 5px 10px !important;
   border: 1px solid #607d67 !important; 
   border-radius: 5px !important;
} 

.search-wrap {
	display: flex !important;
	justify-content: center !important;
	align-items: center !important;
}
.board-table .th-writer {
    width: 170px !important;
    text-align: center !important;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<!-- main -->
	<main id= "main">
        <div id="slider">
          <div class="imageWrap1"></div>
        </div>

		<!-- section -->
		<section id="contents">

			<%@ include file="category.jsp"%>

			<div class="noticeboard">
				<div class="title" style="margin:0px;">
					<div class="vline"></div>
					<div class="container2">
						<h3>리그게시판</h3>
					</div>
				</div>
				<div id="board-list">
					<div class="container">
						<form id="sortForm" action="/LeagueBoard" method="get">
							<select name="sort" id="sort" class="sort-select"
								onchange="submitForm()">
								<option value="0"
									${pageInfo.pageRequest.sort == '0' ? 'selected' : ''}>글번호순</option>
								<option value="1"
									${pageInfo.pageRequest.sort == '1' ? 'selected' : ''}>최신순</option>
							</select> 
							<%-- <input name="pageNum" type="hidden"
								value="1"> <input
								name="amount" type="hidden"
								value="${pageInfo.pageRequest.amount}">  --%>
								<input
								name="searchKeyword" type="hidden"
								value="${pageInfo.pageRequest.searchKeyword}"> <input
								name="category" type="hidden"
								value="${pageInfo.pageRequest.category}">
						</form>

						<!-- board list area -->
						<table class="board-table" style="width: 92%; margin: 20px auto 0"">
							<thead>
								<tr style="background-color: rgba(103, 141, 115, 0.1);">
									<th scope="col" class="th-num">번호</th>
									<th scope="col" class="th-title">제목</th>
									<th scope="col" class="th-writer">작성자</th>
									<th scope="col" class="th-date">날짜</th>
									<!-- <th scope="col">조회수</th> -->
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${leagueboardList}" var="leagueboard">
									<tr>
										<td scope="row" class="th-num" bgcolor="" style="font-size:11px;">${leagueboard.leagueboardId}</td>
										<td bgcolor="" style="text-align:left; padding-left:20px;"><a
											href="/LeagueBoard/${leagueboard.leagueboardId}">${leagueboard.title}</a>
										</td>
										<td bgcolor="" style="color:gray;"><img src="/badge/${leagueboard.badgeName}.jpg" style="height:15px; width:15px;">${leagueboard.userId}
										</td>
										<td bgcolor="" style="color:gray;"><fmt:formatDate
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
					
					<div class="paging">
						<div class="row justify-content-center"
							style="display: flex; justify-content: center;">
							<div class="col-auto">
								 <div class="page navigation">
									<ul class="pagination">
										<c:if test="${pageInfo.prev}">
											<li class="page-item"><a class="page-link"
												aria-label="Previous"
												href="/LeagueBoard?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}
													&searchKeyword=${pageInfo.pageRequest.searchKeyword}&category=${pageInfo.pageRequest.category}
													&sort=${pageInfo.pageRequest.sort}">Prev</a>
											</li>
										</c:if>
										<c:forEach var="num" begin="${pageInfo.startPage}"
													end="${pageInfo.endPage}">
													<li class="page-item ${pageInfo.pageRequest.pageNum == num ? "active" : "" } ">
														<a id="pbtn_${num}" class="page-link"
														href="/LeagueBoard?pageNum=${num}&amount=${pageInfo.pageRequest.amount}
														&searchKeyword=${pageInfo.pageRequest.searchKeyword}&sort=${pageInfo.pageRequest.sort}
														&category=${pageInfo.pageRequest.category}">
														${num}</a>
													</li>
										</c:forEach>
										<c:if test="${pageInfo.next}">
											<li class="page-item next"><a class="page-link"
												aria-label="next"
												href="/LeagueBoard?pageNum=${pageInfo.endPage + 1}&amount=${pageInfo.pageRequest.amount}
													&searchKeyword=${pageInfo.pageRequest.searchKeyword}&category=${pageInfo.pageRequest.category}
													&sort=${pageInfo.pageRequest.sort}">Next</a>
											</li>
										</c:if>
									</ul>
								</div>
							</div>
						</div>
					</div>
					
					<!-- 검색창 -->
					<form action="/LeagueBoard" method="get">
							<div class="search-wrap clearfix">
								<select name="category" style="width: 100px; margin-left: 10px;"
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
									value="${pageInfo.pageRequest.searchKeyword}"> 
									 <input name="sort" type="hidden" value="${pageInfo.pageRequest.sort}">
								<button class="btn btn-primary search-btn" type="submit">검색</button>
							</div>
						</form>
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

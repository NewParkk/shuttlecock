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
<link rel="stylesheet" href="/css/league-rank.css">
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<!-- main -->
	<main id="main">
		<div id="slider">
			<div class="imageWrap1"></div>
		</div>

		<!-- section -->
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
				<div class="title" style="margin: 0px;">
					<div class="vline"></div>
					<div class="container2">
						<h3>리그 순위</h3>
					</div>
				</div>
				<div id="board-list">
					<div class="container">
						<form action="/LeagueBoardRanking/search" method="get"
							style="text-align: right; margin: 30px 50px 10px 0px;">
							<div class="search-wrap clearfix">
								<input id="searchKeyword" type="search" name="searchKeyword"
									placeholder="이름을 입력해주세요." style="width: 300px;"
									class="form-control search-input"
									value="${pageInfo.pageRequest.searchKeyword}"> <input
									name="pageNum" type="hidden"
									value="${pageInfo.pageRequest.pageNum >= 2 ? 1 : pageInfo.pageRequest.pageNum}"> <input
									name="sort" type="hidden" value="${pageInfo.pageRequest.sort}">
								<input name="amount" type="hidden"
									value="${pageInfo.pageRequest.amount}"> <input
									type="hidden" id="startDate1" name="startDate"
									value="${pageInfo.pageRequest.startDate}"> <input type="hidden"
									id="endDate1" name="endDate" value="${pageInfo.pageRequest.endDate}">
								<button class="btn btn-primary search-btn" type="submit"
									style="margin-right: 10px">검색</button>
							</div>
						</form>
						
						<!-- 시즌버튼으로 클릭시 하위메뉴가 보이게 함 -->
						<form id="dateForm" action="/LeagueBoardRanking/search"	method="get">
							<input type="hidden" id="startDate" name="startDate"> 
							<input type="hidden" id="endDate" name="endDate">
							<div class="season-container" style="width: 92%; margin: 0 auto;">
								<button class="season-btn" type="button" data-kind="season"><strong>Season</strong>
									<span class="triangle-container down-arrow">&#9662;</span>
								</button>
								<ul class="season-list" data-opened="false">
									<li class="season-item" data-selected="false" onclick="setDateRange(null, null)">전체 기간</li>
								    <li class="season-item" data-selected="false" onclick="setDateRange('2024-01-01', '2024-03-31')">2024 1분기</li>
								    <li class="season-item" data-selected="false" onclick="setDateRange('2024-04-01', '2024-06-30')">2024 2분기</li>
								    <li class="season-item" data-selected="false" onclick="setDateRange('2024-07-01', '2024-09-30')">2024 3분기</li>
								    <li class="season-item" data-selected="false" onclick="setDateRange('2024-10-01', '2024-12-31')">2024 4분기</li>
								</ul>
							</div>
						</form>
						<!-- div를 table형식으로 변경함 -->
						<table class="board-table" style="width: 92%; margin: 10px auto 0;">
							<thead>
								<tr style="background-color: rgba(103, 141, 115, 0.1);">
									<th scope="col" class="th-title">순위</th>
									<th scope="col" class="th-title">유저</th>
									<th scope="col" class="th-title">승</th>
									<th scope="col" class="th-title">패</th>
									<th scope="col" class="th-title">승점</th>
									<th scope="col" class="th-title">승률</th>
								</tr>
							</thead>
															
							<tbody>
								<c:forEach items="${leagueRankingList}" var="leagueRankDTO"
									varStatus="status">
									<tr>
										<td><c:choose>
												<c:when test="${leagueRankDTO.idx == 1}">
													<img
														src="https://kr.object.ncloudstorage.com/team1bucket/badge/leaguebadge3.png"
														width="70px" height="80px">
												</c:when>
												<c:when test="${leagueRankDTO.idx == 2}">
													<img
														src="https://kr.object.ncloudstorage.com/team1bucket/badge/leaguebadge2.png"
														width="60px" height="70px">
												</c:when>
												<c:when test="${leagueRankDTO.idx == 3}">
													<img
														src="https://kr.object.ncloudstorage.com/team1bucket/badge/leaguebadge1.png"
														width="50px" height="60px">
												</c:when>
												<c:otherwise>${leagueRankDTO.idx}</c:otherwise>
											</c:choose></td>
										<td>${leagueRankDTO.username}(${leagueRankDTO.userId})</td>
										<td>${leagueRankDTO.wincount}승</td>
										<td>${leagueRankDTO.losecount}패</td>
										<td>${leagueRankDTO.wincount - leagueRankDTO.losecount}점</td>
										<td><b> <c:set var="winRatio"
													value="${(leagueRankDTO.wincount * 1.0 / (leagueRankDTO.wincount + leagueRankDTO.losecount)) * 100}" />
												<fmt:formatNumber value="${winRatio}" pattern="###.##" />%
										</b></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<!-- //div를 table형식으로 변경함 -->

						<c:if test="${empty leagueRankingList}">
							<div class="empty-post"
								style="text-align: center; margin: 100px;">리그에 참여한 유저가
								없습니다.</div>
							<div class="line" style="width: 92%; margin: 0 auto;"></div>
						</c:if>

						<!-- table형식을 ul/li식으로 변경함 -->
						<div class="paging">
							<div class="row justify-content-center"
								style="display: flex; justify-content: center;">
								<div class="col-auto">
									<div class="page navigation">
										<ul class="pagination">
											<c:if test="${pageInfo.prev}">
												<li class="page-item"><a class="page-link"
													aria-label="Previous"
													href="/LeagueBoardRanking?startDate=${pageInfo.pageRequest.startDate}&endDate=${pageInfo.pageRequest.endDate}&pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}
													&searchKeyword=${pageInfo.pageRequest.searchKeyword}">Prev</a>
												</li>
											</c:if>
											<c:if test="${pageInfo.pageRequest.searchKeyword == null}">
												<c:forEach var="num" begin="${pageInfo.startPage}"
													end="${pageInfo.endPage}">
													<li
														class="page-item ${pageInfo.pageRequest.pageNum == num ? "active" : "" } ">
														<a id="pbtn_${num}" class="page-link"
														href="/LeagueBoardRanking?startDate=${pageInfo.pageRequest.startDate}&endDate=${pageInfo.pageRequest.endDate}
													&pageNum=${num}&amount=${pageInfo.pageRequest.amount}&sort=${pageInfo.pageRequest.sort}">${num}</a>
													</li>
												</c:forEach>
											</c:if>
											<c:if test="${pageInfo.pageRequest.searchKeyword != null}">
												<c:forEach var="num" begin="${pageInfo.startPage}"
													end="${pageInfo.endPage}">
													<li
														class="page-item ${pageInfo.pageRequest.pageNum == num ? "active" : "" } ">
														<a id="pbtn_${num}" class="page-link"
														href="/LeagueBoardRanking/search?startDate=${pageInfo.pageRequest.startDate}&endDate=${pageInfo.pageRequest.endDate}
														&searchKeyword=${pageInfo.pageRequest.searchKeyword}&pageNum=${num}&amount=${pageInfo.pageRequest.amount}&sort=${pageInfo.pageRequest.sort}">${num}</a>
													</li>
												</c:forEach>
											</c:if>
											<c:if test="${pageInfo.next}">
												<li class="page-item next"><a class="page-link"
													aria-label="next"
													href="/LeagueBoardRanking?startDate=${pageInfo.pageRequest.startDate}&endDate=${pageInfo.pageRequest.endDate}&pageNum=${pageInfo.endPage + 1}&amount=${pageInfo.pageRequest.amount}
													&searchKeyword=${pageInfo.pageRequest.searchKeyword}">Next</a>
												</li>
											</c:if>
										</ul>
									</div>
								</div>
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
		document.addEventListener('DOMContentLoaded', function() {
			var menuItems = document.querySelectorAll('.menubar .list');
			var currentPageUrl = window.location.pathname; // 현재 페이지의 경로 부분만 추출

			menuItems.forEach(function(item) {
				var menuItemUrl = item.getAttribute('href');

				// 메뉴 항목의 URL이 현재 페이지의 경로 부분과 정확히 일치하는지 확인
				if (currentPageUrl === menuItemUrl) {
					item.classList.add('active');
				}

				// 메뉴 항목 클릭 시 active 클래스 설정
				item.addEventListener('click', function(event) {
					menuItems.forEach(function(menuItem) {
						menuItem.classList.remove('active');
					});
					this.classList.add('active');
				});
			});
		});

		// 리그 순위 기간에 대한 함수
	    function setDateRange(startDate, endDate) {
	        
	        document.getElementById('startDate').value = startDate;
	        document.getElementById('endDate').value = endDate;
	        
	        // 폼을 서버로 제출
	        document.getElementById('dateForm').submit();
	    }
		
		//버튼 클릭시 시즌별로 찾아볼 수 있게 구현함
	    document.addEventListener('DOMContentLoaded', function () {
	        const seasonBtn = document.querySelector('.season-btn');
	        const seasonList = document.querySelector('.season-list');

	        seasonBtn.addEventListener('click', function () {
	            const isOpened = seasonList.getAttribute('data-opened') === 'true';
	            seasonList.setAttribute('data-opened', isOpened ? 'false' : 'true');
	            seasonList.style.display = isOpened ? 'none' : 'block';
	        });
	        
	        //URL에서 시작일과 종료일 파라미터 가져오기
	        const urlParams = new URLSearchParams(window.location.search);
	        const startDateParam = urlParams.get('startDate');
	        const endDateParam = urlParams.get('endDate');

	        //URL에 따라 버튼 텍스트 설정
	        if (!startDateParam || !endDateParam) {
	            //전체 기간
	            seasonBtn.querySelector('strong').textContent = '전체 기간';
	        } else if (startDateParam === '2024-01-01' && endDateParam === '2024-03-31') {
	            //1분기
	            seasonBtn.querySelector('strong').textContent = '2024 1분기';
	        } else if (startDateParam === '2024-04-01' && endDateParam === '2024-06-30') {
	            //2분기
	            seasonBtn.querySelector('strong').textContent = '2024 2분기';
	        } else if (startDateParam === '2024-07-01' && endDateParam === '2024-09-30') {
	            //3분기
	            seasonBtn.querySelector('strong').textContent = '2024 3분기';
	        } else if (startDateParam === '2024-10-01' && endDateParam === '2024-12-31') {
	            //4분기
	            seasonBtn.querySelector('strong').textContent = '2024 4분기';
	        }
	        
	        //페이지네이션 js
	        const pageNum = ${pageInfo.pageRequest.pageNum};
			console.log(pageNum);
			$('#pbtn_' + pageNum).toggleClass('current-page');

	    });
	    
	    /* aside가 (/LeagueBoardRanking)url이 같은 페이지로 인식되도록 작성함 */
	    var currentPageUrl = "/LeagueBoardRanking"; 
	    var menuItems = document.querySelectorAll('.menubar .list');
	    menuItems.forEach(function(item) {
	        if (item.getAttribute('href') === currentPageUrl) {
	            item.classList.add('active');
	        }
	    });
	    
	</script>

</body>
</html>

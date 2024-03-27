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

/* .paging {
	margin-left: auto;
	margin-right: auto;
	display: table;
} */
.current-page {
   background-color: #607d67 !important;
   color: #fff !important;
   padding: 5px 10px !important;
   border: 1px solid #607d67 !important; 
   border-radius: 5px !important;
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
	/* margin-bottom: 20px; */
}

/* .search-btn, .search-input, .search-select {
	float: right; /*우측 플로팅 */
} */

.search-input {
	width: 140px;
}

#search-select {
	width: 80px;
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

			<div class="aside">
				<div class="menubar">
					<ul>
						<li><a class="list" href="/LeagueBoard">리그게시판</a></li>
						<li><a class="list" href="/LeagueBoardRanking">리그순위</a></li>
					</ul>
				</div>
			</div>

			<div class="noticeboard">
				<div class="title" style="margin:0px;">
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
									value="${pageInfo.pageRequest.searchKeyword}"> 
								<input name="pageNum" type="hidden"
									value="${pageInfo.pageRequest.pageNum}"> 
								<input name="sort" type="hidden" value="${pageInfo.pageRequest.sort}">
								<input name="amount" type="hidden" value="${pageInfo.pageRequest.amount}">
								<input type="hidden" id="startDate1" name="startDate" value = "${startDate}" >
					    		<input type="hidden" id="endDate1" name="endDate" value = "${endDate}">
								<button class="btn btn-primary search-btn" type="submit"
									style="margin-right: 10px">검색</button>
							</div>
						</form>
						<!-- board list area -->
						
						<!-- div를 table형식으로 변경함 -->
						<table class="board-table" style="width: 92%; margin: 20px auto 0;">
							<thead>
							
								<tr>
									<th scope="col" style="text-align: center;">
												<span style="font-size: 12pt;">
												<a class="item-div" onclick="setDateRange('2024-01-01', '2024-03-31')">
												2024 1분기
												</a></span>
											</th>
											<th scope="col" style="text-align: center;">
												<span style="font-size: 12pt;">
												<a class="item-div" onclick="setDateRange('2024-04-01', '2024-06-30')">
												2024 2분기
												</a></span>
											</th>
											<th scope="col" style="text-align: center;">
												<span style="font-size: 12pt;" onclick="setDateRange('2024-07-01', '2024-09-30')">
												<a class="item-div" >
												2024 3분기
												</a></span>
											</th>
											<th scope="col" style="text-align: center;">
												<span style="font-size: 12pt;" onclick="setDateRange('2024-10-01', '2024-12-31')">
												<a class="item-div" >
												2024 4분기
												</a></span>
											</th>
								
									</tr>
									
								<tr style="background-color: rgba(103, 141, 115, 0.1);">
									<th scope="col" class="th-writer"><a
										href="/LeagueBoard?sort=0">순위</a></th>
									<th scope="col" class="th-date">유저</th>
									<th scope="col" class="th-title">승</th>
									<th scope="col" class="th-title">패</th>
									<th scope="col" class="th-title">승점</th>
									<th scope="col" class="th-title">승률</th>
									<!-- <th scope="col">조회수</th> -->
								</tr>
							</thead>
							<tbody>
						        <c:forEach items="${leagueRankingList}" var="leagueRankDTO" varStatus="status">
						            <tr>
						                <td>
						                    <c:choose>
						                        <c:when test="${leagueRankDTO.idx == 1}">
						                            <img src="https://kr.object.ncloudstorage.com/team1bucket/badge/leaguebadge3.png" width="70px" height="80px">
						                        </c:when>
						                        <c:when test="${leagueRankDTO.idx == 2}">
						                            <img src="https://kr.object.ncloudstorage.com/team1bucket/badge/leaguebadge2.png" width="60px" height="70px">
						                        </c:when>
						                        <c:when test="${leagueRankDTO.idx == 3}">
						                            <img src="https://kr.object.ncloudstorage.com/team1bucket/badge/leaguebadge1.png" width="50px" height="60px">
						                        </c:when>
						                        <c:otherwise>${leagueRankDTO.idx}</c:otherwise>
						                    </c:choose>
						                </td>
						                <td>${leagueRankDTO.username}(${leagueRankDTO.userId})</td>
						                <td>${leagueRankDTO.wincount}승</td>
						                <td>${leagueRankDTO.losecount}패</td>
						                <td>${leagueRankDTO.wincount - leagueRankDTO.losecount}점</td>
						                <td>
						                    <b>
						                        <c:set var="winRatio" value="${(leagueRankDTO.wincount * 1.0 / (leagueRankDTO.wincount + leagueRankDTO.losecount)) * 100}" />
						                        <fmt:formatNumber value="${winRatio}" pattern="###.##" />%
						                    </b>
						                </td>
						            </tr>
						        </c:forEach>
						    </tbody>
						</table>
						<!-- //div를 table형식으로 변경함 -->
						
						<c:if test="${empty leagueRankingList}">
							<div class="empty-post"
								style="text-align: center; margin:100px;">리그에 참여한 유저가 없습니다.</div>
							<div class="line" style="width:92%; margin: 0 auto;"></div>
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
													<a class="page-link" 
													href="/LeagueBoardRanking?startDate=${pageInfo.pageRequest.startDate}&endDate=${pageInfo.pageRequest.endDate}
													&pageNum=${num}&amount=${pageInfo.pageRequest.amount}&sort=${pageInfo.pageRequest.sort}
 													">${num}</a>
												</li>
											</c:forEach>
										</c:if>
										<c:if test="${pageInfo.pageRequest.searchKeyword != null}">
											<c:forEach var="num" begin="${pageInfo.startPage}"
												end="${pageInfo.endPage}">
												<li
													class="page-item ${pageInfo.pageRequest.pageNum == num ? "active" : "" } ">
													<a class="page-link" 
														href="/LeagueBoardRanking?startDate=${pageInfo.pageRequest.startDate}&endDate=${pageInfo.pageRequest.endDate}
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
				
					<form id="dateForm" action="/LeagueBoardRanking/search" method="get">
					    <input type="hidden" id="startDate" name="startDate" >
					    <input type="hidden" id="endDate" name="endDate" >
					    
					    <button onclick="setDateRange('2024-01-01', '2024-03-31')">1분기</button>
					    <button onclick="setDateRange('2024-04-01', '2024-06-30')">2분기</button>
					    <button onclick="setDateRange('2024-07-01', '2024-09-30')">3분기</button>
					    <button onclick="setDateRange('2024-10-01', '2024-12-31')">4분기</button>
					</form>
					
					
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
			console.log(startDate, endDate);
	        
	        document.getElementById('startDate').value = startDate;
	        document.getElementById('startDate1').value = startDate;
	        document.getElementById('endDate').value = endDate;
	        document.getElementById('endDate1').value = endDate;
	        
	        console.log(document.getElementById('startDate1').value);
	        console.log(document.getElementById('endDate1').value);
	        // 폼을 서버로 제출합니다.
	        document.getElementById('dateForm').submit();
	    }
	</script>
		
</body>
</html>

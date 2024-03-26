<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle Cock</title>
<style type="text/css">
.current-page {
   background-color: #607d67 !important;
   color: #fff !important;
   padding: 5px 10px !important;
   border: 1px solid #607d67 !important; 
   border-radius: 5px !important;
} 

/* .table th {
    text-align: center;
    padding: 10px;
}

.table a {
    text-decoration: none;
    color: #405448;
    display: inline-block;
    transition: background-color 0.3s;
}


.table th a.active,
.table th a:hover {
    text-decoration: underline;
}


.table th a.active {
    font-weight: bold;
} */
.table th {
    text-align: center;
    padding: 10px;
}

.table a {
    text-decoration: none;
    color: #b0b0b0; 
    display: inline-block;
    transition: color 0.3s; 
}

.table th a.active,
.table th a:hover {
    /* text-decoration: underline; */
    font-weight: bold;
    color: #000; 
}

.table th a.active {
    font-weight: bold;
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

			<!-- aside -->
			<%@ include file="category.jsp"%>
			
			<div class="noticeboard">
				<div class="title" style="margin:0px;">
					<div class="vline"></div>
					<div class="container2">
						<h3>모집게시판</h3>
					</div>
				</div>
				
				<div id="board-list">
					<div class="container2">
						<form id="sortForm" action="/Recruitboard" method="get">
							<select name="sort" id="sort" class="sort-select"
								onchange="submitForm()">
								<option value="0"
									${pageInfo.pageRequest.sort == '0' ? 'selected' : ''}>글번호순</option>
								<option value="1"
									${pageInfo.pageRequest.sort == '1' ? 'selected' : ''}>최신순</option>
								<option value="2"
									${pageInfo.pageRequest.sort == '2' ? 'selected' : ''}>조회수순</option>
								<option value="3"
									${pageInfo.pageRequest.sort == '3' ? 'selected' : ''}>추천순</option>
							</select> <input
								name="region" type="hidden"
								value="${pageInfo.pageRequest.region}"> <input
								name="recruitType" type="hidden"
								value="${pageInfo.pageRequest.recruitType}"> <input
								name="searchKeyword" type="hidden"
								value="${pageInfo.pageRequest.searchKeyword}"> <input
								name="category" type="hidden"
								value="${pageInfo.pageRequest.category}">
						</form>

						<table class="table" style="width: 90%; margin: 0 auto;">
							<thead>
								<tr>
									<th scope="col" style="text-align: center;">
										<span style="font-size: 12pt;" class="region-div"> 
										<b><a href="/Recruitboard?
											&searchKeyword=${pageInfo.pageRequest.searchKeyword}
											&category=${pageInfo.pageRequest.category}
											&sort=${pageInfo.pageRequest.sort}
											&recruitType=${pageInfo.pageRequest.recruitType}
											&region=0" 
											class="${pageInfo.pageRequest.region eq 0 ? 'active' : ''}"
											<c:if test="${pageInfo.pageRequest.region eq 0}"></c:if>>전체</a></b>
											 <!-- style="text-decoration: underline;" -->
										</span>
									</th>
									<th scope="col" style="text-align: center;">
										<span style="font-size: 12pt;" class="region-div"> 
										<b><a href="/Recruitboard?
											&searchKeyword=${pageInfo.pageRequest.searchKeyword}
											&category=${pageInfo.pageRequest.category}
											&sort=${pageInfo.pageRequest.sort}
											&recruitType=${pageInfo.pageRequest.recruitType}
											&region=1"
											 class="${pageInfo.pageRequest.region eq 1 ? 'active' : ''}"
											<c:if test="${pageInfo.pageRequest.region eq 1}"><!-- style=""--></c:if>>서울${pageInfo.pageRequest.region eq 1 ? '🏸' : ''}</a></b>
										</span>
									</th>
									<th scope="col" style="text-align: center;">
										<span style="font-size: 12pt;" class="region-div"> 
										<b><a href="/Recruitboard?
											&searchKeyword=${pageInfo.pageRequest.searchKeyword}
											&category=${pageInfo.pageRequest.category}
											&sort=${pageInfo.pageRequest.sort}
											&recruitType=${pageInfo.pageRequest.recruitType}
											&region=2"
											class="${pageInfo.pageRequest.region eq 2 ? 'active' : ''}"
											<c:if test="${pageInfo.pageRequest.region eq 2}"><!-- style="" --></c:if>>경기${pageInfo.pageRequest.region eq 2 ? '🏸' : ''}</a></b>
										</span>
									</th>
									<th scope="col" style="text-align: center;">
										<span style="font-size: 12pt;" class="region-div"> 
										<b><a href="/Recruitboard?
											&searchKeyword=${pageInfo.pageRequest.searchKeyword}
											&category=${pageInfo.pageRequest.category}
											&sort=${pageInfo.pageRequest.sort}
											&recruitType=${pageInfo.pageRequest.recruitType}
											&region=3"
											class="${pageInfo.pageRequest.region eq 3 ? 'active' : ''}"
											<c:if test="${pageInfo.pageRequest.region eq 3}"><!-- style="" --></c:if>>충청${pageInfo.pageRequest.region eq 3 ? '🏸' : ''}</a></b>
										</span>
									</th>
									<th scope="col" style="text-align: center;">
										<span style="font-size: 12pt;" class="region-div"> 
										<b><a href="/Recruitboard?
											&searchKeyword=${pageInfo.pageRequest.searchKeyword}
											&category=${pageInfo.pageRequest.category}
											&sort=${pageInfo.pageRequest.sort}
											&recruitType=${pageInfo.pageRequest.recruitType}
											&region=4"
											class="${pageInfo.pageRequest.region eq 4 ? 'active' : ''}"
											<c:if test="${pageInfo.pageRequest.region eq 4}"><!-- style="" --></c:if>>경상${pageInfo.pageRequest.region eq 4 ? '🏸' : ''}</a></b>
										</span>
									</th>
									<th scope="col" style="text-align: center;">
										<span style="font-size: 12pt;" class="region-div"> 
											<b><a href="/Recruitboard?
											&searchKeyword=${pageInfo.pageRequest.searchKeyword}
											&category=${pageInfo.pageRequest.category}
											&sort=${pageInfo.pageRequest.sort}
											&recruitType=${pageInfo.pageRequest.recruitType}
											&region=5"
											class="${pageInfo.pageRequest.region eq 5 ? 'active' : ''}"
											<c:if test="${pageInfo.pageRequest.region eq 5}"><!-- style="" --></c:if>>전라${pageInfo.pageRequest.region eq 5 ? '🏸' : ''}</a></b>
										</span>
									</th>
									<th scope="col" style="text-align: center;">
										<span style="font-size: 12pt;" class="region-div"> 
										<b><a href="/Recruitboard?
											&searchKeyword=${pageInfo.pageRequest.searchKeyword}
											&category=${pageInfo.pageRequest.category}
											&sort=${pageInfo.pageRequest.sort}
											&recruitType=${pageInfo.pageRequest.recruitType}
											&region=6"
											class="${pageInfo.pageRequest.region eq 6 ? 'active' : ''}"
											<c:if test="${pageInfo.pageRequest.region eq 6}"><!-- style="" --></c:if>>강원${pageInfo.pageRequest.region eq 6 ? '🏸' : ''}</a></b>
										</span>
									</th>
								</tr>
							</thead>
						</table>

						<!-- board list area -->
						<table class="board-table" style="width: 92%; margin: 0px auto 0;">
							<thead>
								<tr style="background-color: rgba(103, 141, 115, 0.1);">
									<th scope="col" class="th-num">번호</th>
									<th scope="col" class="th-writer">분류</th>
									<th scope="col" class="th-writer">지역</th>
									<th scope="col" class="th-title">제목</th>
									<th scope="col" class="th-writer">작성자</th>
									<th scope="col" class="th-date">날짜</th>
									<th scope="col" class="th-hit">조회수</th>
									<th scope="col" class="th-like">추천</th>
									<th scope="col" class="th-like">모집여부</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${recruitboardList}" var="recruitboard">
									<tr>
										<td scope="row" style="font-size:11px;">${recruitboard.recruitboardId}</td>
										<td bgcolor="#f9f9f9"><c:choose>
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
												<td bgcolor="" style="text-align:left;"><a
													href="/Recruitboard/${recruitboard.recruitboardId}">${recruitboard.title}
														[${recruitboard.commentCount}]</a></td>
											</c:when>
											<c:when test="${recruitboard.commentCount == 0}">
												<td bgcolor="" style="text-align:left;"><a
													href="/Recruitboard/${recruitboard.recruitboardId}">${recruitboard.title}</a>
												</td>
											</c:when>
										</c:choose>
										<td bgcolor="" style="color:gray;"><img src="/badge/${recruitboard.badgeName}.jpg" style="height:15px; width:15px;">${recruitboard.userId}</td>
										<td bgcolor="" style="color:gray;"><fmt:formatDate
												value="${recruitboard.regdate}" pattern="yyyy-MM-dd HH:mm" />
										</td>
										<td bgcolor="" style="color:gray;">${recruitboard.hit}</td>
										<td bgcolor="" style="color:gray;">${recruitboard.like}</td>
										<c:choose>
											<c:when test="${recruitboard.complete eq 1}">
												<td bgcolor="" style="color:gray;">모집완료</td>
											</c:when>
											<c:when test="${recruitboard.complete eq 0}">
												<td bgcolor="" style="font-weight: bold;">모집중</td>
											</c:when>
										</c:choose>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						
						<c:if test="${empty recruitboardList}">
							<div class="empty-post"
								style="text-align: center; margin:100px;">게시물이 없습니다.</div>
							<div class="line" style="width:92%; margin: 0 auto;"></div>
						</c:if>
						
						<div class="newsWrite" style="margin-top: 10px; margin-right:50px;">
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
							<form action="/Recruitboard" method="get">
								<div class="row justify-content-center"
									style="display: flex; justify-content: center;">
									<div class="col-auto">
										<!-- 기존 table형식의 페이지네이션을 list 형식으로 바꿈 -->
										<div class="page navigation">
											<ul class="pagination">
												<c:if test="${pageInfo.prev}">
													<li class="page-item"><a class="page-link"
														aria-label="Previous"
														href="/Recruitboard?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}
													&searchKeyword=${pageInfo.pageRequest.searchKeyword}
													&category=${pageInfo.pageRequest.category}&region=${pageInfo.pageRequest.region}
													&sort=${pageInfo.pageRequest.sort}&recruitType=${pageInfo.pageRequest.recruitType}">Prev</a>
													</li>
												</c:if>
												<c:forEach var="num" begin="${pageInfo.startPage}"
													end="${pageInfo.endPage}">
													<li class="page-item ${pageInfo.pageRequest.pageNum == num ? "active" : "" } ">
														<a id="pbtn_${num}" class="page-link"
														href="/Recruitboard?pageNum=${num}&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}&region=${pageInfo.pageRequest.region}
										&sort=${pageInfo.pageRequest.sort}&recruitType=${pageInfo.pageRequest.recruitType}">${num}
													</a>
													</li>
												</c:forEach>
												<c:if test="${pageInfo.next}">
													<li class="page-item next"><a class="page-link"
														aria-label="next"
														href="/Recruitboard?pageNum=${pageInfo.endPage + 1}&amount=${pageInfo.pageRequest.amount}
													&searchKeyword=${pageInfo.pageRequest.searchKeyword}
													&category=${pageInfo.pageRequest.category}&region=${pageInfo.pageRequest.region}
													&sort=${pageInfo.pageRequest.sort}&recruitType=${pageInfo.pageRequest.recruitType}">Next</a>
													</li>
												</c:if>
											</ul>
										</div>
									</div>
								</div>
							</form>
						</div>
						
						<!-- 검색창 -->
						<form action="/Recruitboard" method="get"
							style="text-align: center;">
							<div class="search-wrap clearfix">
								<select name="category" style="width: 100px; margin-left: 10px;"
									class="form-control" id="search-select">
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
									placeholder="검색어를 입력해주세요." style="width: 300px;"
									class="form-control search-input"
									value="${pageInfo.pageRequest.searchKeyword}"> <input
									name="region" type="hidden"
									value="${pageInfo.pageRequest.region}"> <input
									name="sort" type="hidden" value="${pageInfo.pageRequest.sort}">
								<input name="recruitType" type="hidden"
									value="${pageInfo.pageRequest.recruitType}">
								<button class="btn btn-primary search-btn" type="submit">검색</button>
							</div>
						</form>
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

		function submitForm() {
			document.getElementById("sortForm").submit();
		}
		
		window.onload = function(){
			const pageNum = ${pageInfo.pageRequest.pageNum};
			console.log(pageNum);
			$('#pbtn_' + pageNum).toggleClass('current-page');
		};
		
	</script>
</body>
</html>

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
<!-- aisde-js 파일 -->
<script src="/js/aside-js.js"></script>
<link rel="stylesheet" href="/css/free.css">
<style>
.grid-container {
    margin: 0 auto;
    display: flex;
    flex-wrap: wrap;
}

.container1 {
    position: relative;
    width: 200px;
    height: 300px; 
    margin-bottom: 20px; 
    border: 1px solid #ccc; 
    border-radius: 5px; 
    overflow: hidden; 
    margin: 20px 14px 10px 14px;
}

.container1 img {
    width: 100%;
    height: 50%; 
    object-fit: cover;
    border-radius: 5px 5px 0 0; 
}

.info1 {
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 50%;
    padding: 10px;
    box-sizing: border-box;
    text-align: left;
    border-radius: 0 0 5px 5px;
}
.current-page {
   background-color: #607d67 !important;
   color: #fff !important;
   padding: 5px 10px !important;
   border: 1px solid #607d67 !important; 
   border-radius: 5px !important;
} 

.search-wrap {
	display: flex;
	justify-content: center;
	align-items: center;
}
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
    font-weight: bold;
    color: #000; 
}

.table th a.active {
    font-weight: bold;
}

.dt-wrapper {
    width: 180px; /* 예시로 200px로 설정 */
    white-space: nowrap; /* 텍스트가 줄 바꿈되지 않도록 설정 */
    overflow: hidden; /* 넘치는 내용은 숨김 처리 */
    text-overflow: ellipsis; /* 텍스트가 넘칠 때 "..."으로 대체될 수 있도록 설정 */
}
</style>
</head>
<body>
	<spring:eval
		expression="@environment.getProperty('NCP.STORAGE.APIURL')"
		var="imgUrl" />
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
			<!-- contents -->
			<div class="noticeboard">
				<div class="title" style="margin:0px;">
					<div class="vline"></div>
					<div class="container2">
						<h3>물품거래소</h3>
					</div>
				</div>
				
				<div id="board-list">
					<div class="container2">
						<form id="sortForm" action="/Tradeboard" method="get">
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
								name="itemClass" type="hidden"
								value="${pageInfo.pageRequest.itemClass}"> <input
								name="searchKeyword" type="hidden"
								value="${pageInfo.pageRequest.searchKeyword}"> <input
								name="category" type="hidden"
								value="${pageInfo.pageRequest.category}">
						</form>

						<table class="table" style="width: 90%; margin: 0 auto;">
							<thead>
								<tr>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;" class="region-div"> 
										<a href="/Tradeboard?
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&itemClass=${pageInfo.pageRequest.itemClass}
										&region=0"
										class="${pageInfo.pageRequest.region eq 0 ? 'active' : ''}"
											<c:if test="${pageInfo.pageRequest.region eq 0}"></c:if>>전체</a>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;" class="region-div"> 
										<a href="/Tradeboard?
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&itemClass=${pageInfo.pageRequest.itemClass}
										&region=1"
										class="${pageInfo.pageRequest.region eq 1 ? 'active' : ''}"> 
										<c:if test="${pageInfo.pageRequest.region eq 1}">&#9889;</c:if>서울</a>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;" class="region-div"> 
										<a href="/Tradeboard?
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&itemClass=${pageInfo.pageRequest.itemClass}
										&region=2"
										class="${pageInfo.pageRequest.region eq 2 ? 'active' : ''}">
										<c:if test="${pageInfo.pageRequest.region eq 2}">&#9889;</c:if>경기</a>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;" class="region-div"> 
										<a href="/Tradeboard?
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&itemClass=${pageInfo.pageRequest.itemClass}
										&region=3"
										class="${pageInfo.pageRequest.region eq 3 ? 'active' : ''}">
										<c:if test="${pageInfo.pageRequest.region eq 3}">&#9889;</c:if>충청</a>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;" class="region-div"> 
										<a href="/Tradeboard?
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&itemClass=${pageInfo.pageRequest.itemClass}
										&region=4"
										class="${pageInfo.pageRequest.region eq 4 ? 'active' : ''}">
										<c:if test="${pageInfo.pageRequest.region eq 4}">&#9889;</c:if>경상</a>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;" class="region-div"> 
										<a href="/Tradeboard?
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&itemClass=${pageInfo.pageRequest.itemClass}
										&region=5"
										class="${pageInfo.pageRequest.region eq 5 ? 'active' : ''}">
											<c:if test="${pageInfo.pageRequest.region eq 5}">&#9889;</c:if>전라</a>
									</span></th>
									<th scope="col" style="text-align: center;"><span
										style="font-size: 12pt;" class="region-div"> 
										<a href="/Tradeboard?
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}
										&sort=${pageInfo.pageRequest.sort}
										&itemClass=${pageInfo.pageRequest.itemClass}
										&region=6"
										class="${pageInfo.pageRequest.region eq 6 ? 'active' : ''}">
											<c:if test="${pageInfo.pageRequest.region eq 6}">&#9889;</c:if>강원</a>
									</span></th>
								</tr>
							</thead>
						</table>
						<div class="line" style="width:92%; margin: 0 auto;"></div>
						<div class="grid-container" style="width: 92%; margin: 20px auto;">
							<c:forEach items="${tradeboardList}" var="tradeboard">
								<div class="container1">
									<a href="/Tradeboard/${tradeboard.tradeboardId}">
									<img src="${imgUrl}/boardFile/3_${tradeboard.imageName}.png"></a>
									<dl class="info1" style="text-align:left;">
										<c:choose>
											<c:when test="${tradeboard.commentCount != 0}">
												<dt class="dt-wrapper">
													<span style="font-size: 14pt;"> <a
															href="/Tradeboard/${tradeboard.tradeboardId}">${tradeboard.title}[${tradeboard.commentCount}]</a>
													</span>
												</dt>
											</c:when>
											<c:when test="${tradeboard.commentCount == 0}">
												<dt class="dt-wrapper">
													<span style="font-size: 14pt;"> <a
															href="/Tradeboard/${tradeboard.tradeboardId}">${tradeboard.title}</a>
													</span>
												</dt>
											</c:when>
										</c:choose>
										<c:choose>
											<c:when test="${tradeboard.complete eq 1}">
												<dd>
													<span style="font-size: 12pt; color:red; text-decoration: line-through;"> <b>거래완료</b>
													</span>
												</dd>
											</c:when>
											<c:when test="${tradeboard.complete eq 0}">
												<dd>
													<span style="font-size: 12pt;"> <b>거래중</b>
													</span>
												</dd>
											</c:when>
										</c:choose>
										<dd>
											<span style="font-size: 10pt;"> <img src="/badge/${tradeboard.badgeName}.jpg" style="height:15px; width:15px;">${tradeboard.userId}
											</span><br>
										</dd>
										
										<dd>
											<span style="font-size: 10pt; color:#868e96;"> 
												<fmt:formatDate value="${tradeboard.regdate}" pattern="yyyy-MM-dd HH:mm" />
											</span>
										</dd>
										<dd>
											<span style="font-size: 10pt; color:#868e96;">조회
													${tradeboard.hit}&nbsp;
											</span> <span style="font-size: 10pt; color:#868e96;">추천
													${tradeboard.like}
											</span>
										</dd>
										
										
									</dl>

								</div>
							</c:forEach>
						</div>
						
						<c:if test="${empty tradeboardList}">
							<div class="empty-post"
								style="text-align: center; margin:100px;">게시물이 없습니다.</div>
						</c:if>
					
					<div class="line" style="width:92%; margin: 0 auto;"></div>
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
						<div class="row justify-content-center"
							style="display: flex; justify-content: center;">
							<div class="col-auto">
								<div class="page navigation">
									<ul class="pagination">
										<c:if test="${pageInfo.prev}">
											<li class="page-item"><a class="page-link"
												aria-label="Previous"
												href="/Tradeboard?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}
													&searchKeyword=${pageInfo.pageRequest.searchKeyword}
													&category=${pageInfo.pageRequest.category}&region=${pageInfo.pageRequest.region}
													&sort=${pageInfo.pageRequest.sort}&itemClass=${pageInfo.pageRequest.itemClass}">Prev</a>
											</li>
										</c:if>
										<c:forEach var="num" begin="${pageInfo.startPage}"
											end="${pageInfo.endPage}">
											<li
												class="page-item ${pageInfo.pageRequest.pageNum == num ? "active" : "" } ">
												<a id="pbtn_${num}" class="page-link"
												href="/Tradeboard?pageNum=${num}&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}&region=${pageInfo.pageRequest.region}
										&sort=${pageInfo.pageRequest.sort}&itemClass=${pageInfo.pageRequest.itemClass}">${num}
											</a>
											</li>
										</c:forEach>
										<c:if test="${pageInfo.next}">
											<li class="page-item next"><a class="page-link"
												aria-label="next"
												href="/Tradeboard?pageNum=${pageInfo.endPage + 1}&amount=${pageInfo.pageRequest.amount}
													&searchKeyword=${pageInfo.pageRequest.searchKeyword}
													&category=${pageInfo.pageRequest.category}&region=${pageInfo.pageRequest.region}
													&sort=${pageInfo.pageRequest.sort}&itemClass=${pageInfo.pageRequest.itemClass}">Next</a>
											</li>
										</c:if>
									</ul>
								</div>
								
							</div>
						</div>
					</div>
					
					<!-- 검색창 -->
					<form action="/Tradeboard" method="get" style="text-align: center;">
							<div class="search-wrap clearfix" style="margin-left: 30px;">
								<select name="category" style="width: 100px; margin-left: 10px"
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
								<input name="itemClass" type="hidden"
									value="${pageInfo.pageRequest.itemClass}">
								<button class="btn btn-primary search-btn" type="submit">검색</button>
							</div>
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
	    
	    document.querySelectorAll('.item-div').forEach(item => {
	        item.addEventListener('click', event => {
	            makeBold(event.target);
	        });
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

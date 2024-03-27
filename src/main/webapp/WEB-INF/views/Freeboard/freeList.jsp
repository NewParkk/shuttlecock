<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Shuttle Cock</title>
<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<!-- aisde-js 파일 -->
<script src="/js/aside-js.js"></script>
<link rel="stylesheet" href="/css/free.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 헤더 -->
	<%@ include file="../include/header.jsp"%>

	<!-- main -->
	<main id= "main">
        <div id="slider">
          <div class="imageWrap1"></div>
        </div>

		<!-- section -->
		<section id="contents">

			<!-- aside -->
			<div class="aside">
				<div class="menubar">
					<ul>
						<li><a class="list" href="/Freeboard/freeList">자유게시판</a></li>
						<li><a class="list" href="/Tradeboard">물품거래소</a></li>
					</ul>
				</div>
			</div>

			<!-- noticeboard -->
			<div class="noticeboard">
				<div class="title" style="margin:0px;">
					<div class="vline"></div>
					<div class="container2">
						<h3>자유 게시판</h3>
					</div>
				</div>

				<div id="board-list">
					<div class="container2">
						<form id="sortForm" action="/Freeboard/freeList" method="get">
							<select name="sort" id="sort" class="sort-select"
								onchange="submitForm()">
								<option value="0" ${param.sort == '0' ? 'selected' : ''}>글번호순</option>
								<option value="1" ${param.sort == '1' ? 'selected' : ''}>최신순</option>
								<option value="2" ${param.sort == '2' ? 'selected' : ''}>조회수순</option>
								<option value="3" ${param.sort == '3' ? 'selected' : ''}>추천순</option>
							</select>
						</form>

						<table class="board-table"
							style="width: 92%; margin: 20px auto 0;">
							<thead>
								<tr style="background-color: rgba(103, 141, 115, 0.1);">
									<th scope="col" class="th-num">번호</th>
									<th scope="col" class="th-title">제목</th>
									<th scope="col" class="th-writer">작성자</th>
									<th scope="col" class="th-date">작성시간</th>
									<th scope="col" class="th-hit">조회수</th>
									<th scope="col" class="th-like">추천</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="vo" items="${freeList}">
									<tr>
										<td scope="row" style="font-size:11px;">${vo.freeboardId}</td>
										<c:choose>
											<c:when test="${vo.commentCount != 0}">
												<td bgcolor="" style="text-align:left; padding-left:20px;"><a
													href="/Freeboard/freeDetail/${vo.freeboardId}">${vo.title}
														[${vo.commentCount}]</a></td>
											</c:when>
											<c:when test="${vo.commentCount == 0}">
												<td bgcolor="" style="text-align:left; padding-left:20px;"><a
													href="/Freeboard/freeDetail/${vo.freeboardId}">${vo.title}</a>
												</td>
											</c:when>
										</c:choose>
										<td style="color:gray;"><img src="/badge/${vo.badgeName}.jpg" style="height:15px; width:15px;">${vo.userId}</td>
										<td style="color:gray;"><fmt:formatDate value="${vo.regdate}" pattern="yyyy-MM-dd HH:mm"/></td> <%-- ${vo.regdate} --%>
										<td style="color:gray;">${vo.hit}</td>
										<td style="color:gray;">${vo.like}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						
						<c:if test="${empty freeList}">
							<div class="empty-post"
								style="text-align: center; margin:100px;">게시물이 없습니다.</div>
						</c:if>

						<!-- 글작성 -->

						<div class="newsWrite" style="margin-top: 10px; margin-right:50px;">
							<button type="button" class="btn btn-primary WriteBtn">글작성</button>
						</div>

						<!-- 페이징 -->

						<div class="paging">
							<form action="<c:url value='/Freeboard/freeList' />"
								name="pageForm">
								<div class="text-center clearfix">
									<ul class="pagination" id="pagination">
										<c:if test="${pageInfo.prev}">
											<li class="page-item"><a class="page-link" href="#"
												data-pageNum="${pageInfo.startPage-1}">Prev</a></li>
										</c:if>

										<c:forEach var="num" begin="${pageInfo.startPage}"
											end="${pageInfo.endPage}">
											<li class="page-item"><c:choose>
													<c:when test="${pageInfo.vo.pageNum == num}">
														<span class="page-link current-page">${num}</span>
													</c:when>
													<c:otherwise>
														<a class="page-link" href="#" data-pageNum="${num}">${num}</a>
													</c:otherwise>
												</c:choose></li>
										</c:forEach>

										<c:if test="${pageInfo.next}">
											<li class="page-item"><a class="page-link" href="#"
												data-pageNum="${pageInfo.endPage+1}">Next</a></li>
										</c:if>
									</ul>

									<!-- 페이지 관련 버튼을 클릭 시 같이 숨겨서 보낼 값 -->
									<input type="hidden" name="pageNum"
										value="${pageInfo.vo.pageNum}"> <input type="hidden"
										name="countPerPage" value="${pageInfo.vo.countPerPage}">
									<input type="hidden" name="keyword"
										value="${pageInfo.vo.keyword}"> <input type="hidden"
										name="condition" value="${pageInfo.vo.condition}"> <input
										type="hidden" name="pagecnt" value="10">
								</div>
							</form>
						</div>

						<!-- 검색창 -->
						<form action="<c:url value='/Freeboard/freeList'/>"
							style="text-align: center;">
							<div class="search-wrap clearfix">
								<select class="form-control" id="search-select" name="condition" style="width: 100px; margin-left: 10px;">
									<option value="title"
										${pageInfo.vo.condition == 'title' ? 'selected' : ''}>제목</option>
									<option value="content"
										${pageInfo.vo.condition == 'content' ? 'selected' : ''}>내용</option>
									<option value="userId"
										${pageInfo.vo.condition == 'userId' ? 'selected' : ''}>작성자</option>
								</select>
								<input type="text" name="keyword"
									class="form-control search-input" value="${pageInfo.vo.keyword}"
									style="width: 300px;" placeholder="검색어를 입력하세요"> 
								<button type="submit" class="btn btn-primary search-btn">검색</button>
							</div>
						</form> 
						
					</div>
				</div>
			</div>
			<!-- // noticeboard -->
			
		</section>
		<!-- //section -->
	</main>
	<!-- //main -->
	
	<!-- footer -->
	<%@include file="../include/footer.jsp"%>
</body>

<script>
	
	$(function() {
		/* $('.WriteBtn').click(function() {
			location.href = '<c:url value="/Freeboard/freeWrite"/>';
		}) */
		//세션이 있는 경우 글작성 페이지로 이동
		<c:if test="${not empty sessionScope.userId or sessionScope.isAdmin}">
	        $('.WriteBtn').click(function() {
	            window.location.href = '<c:url value="/Freeboard/freeWrite"/>';
	        });
    	</c:if>
		
    	//세션이 없으면 로그인 페이지로 이동
	    <c:if test="${empty sessionScope.userId and empty sessionScope.isAdmin}">
	        $('.WriteBtn').click(function() {
	        	if(confirm("로그인이 필요한 작업입니다. 로그인 페이지로 이동하시겠습니까?")){
					location.href = "/login";
				}
	        });
	    </c:if>
		
		
		$('#pagination').on('click', 'a', function(e) {
			e.preventDefault();
			console.log($(this));
			const value = $(this).data('pagenum');
			console.log(value);
			document.pageForm.pageNum.value = value;
			document.pageForm.submit();
		});

	})

	function submitForm() {
		document.getElementById("sortForm").submit();
	}
</script>
</html>
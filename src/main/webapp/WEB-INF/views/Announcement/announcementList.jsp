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
<link rel="stylesheet" href="/css/free.css">
<!-- aisde-js 파일 -->
<script src="/js/aside-js.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>
	<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // 지난 시간으로 설정하여 캐시 무효화
	%>
	<!-- 헤더 -->
	<%@ include file="../include/header.jsp"%>
<div id="wrap">
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
                <li><a class="list" href="/Announcement/">공지사항</a></li>
                <li><a class="list" href="/getNews">배드민턴 정보</a></li>
                <li><a class="list" href="/getGame">정규대회 일정</a></li>
              </ul>
            </div>
          </div>
			
		 <!-- noticeboard -->
		 <div class="noticeboard">
			<div class="title" style="margin:0px;">
				<div class="vline"></div>
				<div class="container2">
					<h3>공지사항 게시판</h3>
				</div>
			</div>

			<div id="board-list">
				<div class="container2" style="margin-top:60px;">
				
					<table class="board-table"
						style="width: 92%; margin: 20px auto 0;">
						<thead>
							<tr style="background-color: rgba(103, 141, 115, 0.1);">
								<th scope="col" class="th-num">번호</th>
								<th scope="col" class="th-title">제목</th>
								<th scope="col" class="th-writer">작성자</th>
								<th scope="col" class="th-date">작성시간</th>
								<th scope="col" class="th-hit">조회수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="post" items="${postList}">
								<tr>
									<td scope="row" style="font-size:11px;">${post.announcementNo}</td>
									<td style="text-align:left; padding-left:20px;"><a
										href="<c:url value='/Announcement/postDetail/${post.announcementNo}'/>">${post.title}
										</a></td>
									<td style="color:gray;">${post.userId}</td>
									<td style="color:gray;"><fmt:formatDate value="${post.regdate}" pattern="yyyy-MM-dd HH:mm" /></td>
									<td style="color:gray;">${post.hit}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<!-- 글작성 -->

					<div class="newsWrite" style="margin-top: 10px; margin-right: 50px;">
					<c:if test="${not empty sessionScope.userId and sessionScope.isAdmin eq true}">
						<button type="button" class="btn btn-primary WriteBtn" style="margin-left: 10px;">글작성</button>
					</c:if>
						<button type="button" class="btn btn-primary goBtn">목록</button>
					</div>
					
					<!-- 페이징 -->

					<div class="paging">
						<c:forEach begin="1" end="${totalPage}" var="pageNum">
							<c:choose>
								<c:when test="${pageNum == currentPage}">
									<li class="page-item">
										<span class="page-link current-page">${pageNum}</span>
									</li>
								</c:when>
								<c:otherwise>
									 <li class="page-item">
										<a class="page-link" href="?page=${pageNum}&query=${param.query}">${pageNum}</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>
					
					<form action="<c:url value='/Announcement/postList/search'/>"
						style="text-align: center;">
						<input type="text" name="query"
								class="form-control search-input" value="${param.query}"
								style="width: 300px;" placeholder="검색어를 입력하세요">
						<button type="submit" class="btn btn-primary search-btn"
								>검색</button>
					</form>

				</div>
			</div>
		 </div>
		 <!-- //noticeboard -->
		 
		</section>
		<!-- //section -->
	</main>
	<!-- //main -->
	
	<!-- footer -->
	<%@include file="../include/footer.jsp"%>
	</div>
</body>


<script>
$(function() {
	$('.WriteBtn').click(function() {
		location.href = '<c:url value="/Announcement/register"/>';
	})
	
	$('.goBtn').click(function() {
		location.href = '<c:url value="/Announcement/"/>';
	})
})


</script>
</html>
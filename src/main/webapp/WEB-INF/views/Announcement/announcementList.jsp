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
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</head>
<body>
	<!-- 헤더 -->
	<%@ include file="../include/header.jsp"%>

	<!-- main -->
	<main id="boardmain">


		<section id="contents">

		
			<div class="noticeboard">
				<div class="title">
					<div class="vline"></div>
					<div class="container2">
						<h3>공지사항 게시판</h3>
					</div>
				</div>

				<div id="board-list">
					<div class="container2">

						<form action="<c:url value='/Announcement/postList/search'/>"
							style="text-align: center;">
							<input type="text" name="query"
									class="form-control search-input" value="${param.query}"
									style="width: 300px;" placeholder="검색어를 입력하세요">
							<button type="submit" class="btn btn-primary search-btn"
									style="margin-left: 10px;">검색</button>
						</form>
						<table class="board-table"
							style="width: 90%; margin: 20px auto 0;">
							<thead>
								<tr>
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
										<th scope="row">${post.announcementNo}</th>
										<td><a
											href="<c:url value='/Announcement/postDetail/${post.announcementNo}'/>">${post.title}
											</a></td>
										<td>${post.userId}</td>
										<td><fmt:formatDate value="${post.regdate}" pattern="yyyy-MM-dd HH:mm" /></td>
										<td>${post.hit}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						<!-- 글작성 -->

						<div class="newsWrite" style="margin-top: 20px;">
							<button type="button" class="btn btn-primary WriteBtn">글작성</button>
							<button type="button" class="btn btn-primary goBtn" style="margin-right: 3px;">목록</button>
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

					</div>
				</div>
			</div>
		</section>
	</main>
	<%@include file="../include/footer.jsp"%>
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
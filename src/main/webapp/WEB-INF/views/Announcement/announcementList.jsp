<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<title>PostList</title>
<link rel="stylesheet" href="/css/mainstyle.css">

<style>

a {
	font-size: 1.17rem; !important;
}

.post-preview {
	border: 1px solid #ddd;
	padding: 15px;
	margin-bottom: 10px;
	cursor: pointer;
	background-color: #f8f8f8;
	height: 100px;
	overflow: hidden;
}

.post-preview h4, .post-preview p {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

#title-p {
	text-align: center;
	padding: 5px 10px;
	border: 1px solid #ddd;
	margin: 10px 2px;
}

.empty-post {
	text-align: center;
	color: #999;
}

#pagination {
	display: flex;
	justify-content: center;
	padding-top: 20px;
}

#pagination a {
	color: #007bff;
	text-decoration: none;
	padding: 5px 10px;
	border: 1px solid #ddd;
	margin: 0 2px;
}

#pagination a:hover {
	background-color: #f8f8f8;
}

#pagination span {
	padding: 5px 10px;
	border: 1px solid #ddd;
	margin: 0 2px;
	background-color: #007bff;
	color: white;
}

.button-group {
	text-align: right;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
<%@ include file="../include/header.jsp"%>
	<div class="container" style="margin-top: 50px">
	<h1 id="title-p">공지사항 게시판</h1>
		<c:choose>
			<c:when test="${not empty postList}">
				<c:forEach items="${postList}" var="post">
					<div class="post-preview"
						onclick="location.href='/Announcement/postDetail/${post.announcementNo}'">
						<h4>${post.title}</h4>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="empty-post">게시글이 없습니다.</div>
			</c:otherwise>
		</c:choose>
		<div class="button-group">
			<c:if test="${sessionScope.isAdmin}">
				<button class="btn btn-primary writepost"
					onclick="location.href='/Announcement/register'">글쓰기</button>
			</c:if>
		</div>
		<nav id="pagination">
			<c:forEach begin="1" end="${totalPage}" var="pageNum">
				<c:choose>
					<c:when test="${pageNum == currentPage}">
						<span>${pageNum}</span>
					</c:when>
					<c:otherwise>
						<a href="?page=${pageNum}&query=${param.query}">${pageNum}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</nav>
		<form action="/Announcement/postList/search" method="get">
			<div class="input-group mb-3">
				<input type="text" class="form-control" placeholder="검색어 입력"
					name="query">
				<div class="input-group-append">
					<button class="btn btn-outline-secondary" type="submit">검색</button>
				</div>
			</div>
		</form>
	</div>
	<%@ include file="../include/footer.jsp"%>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/loginstyle.css">
<link rel="stylesheet" href="/css/aside.css">

</head>

<body>
	<!-- wrap -->
	<div id="wrap">
		<!-- header -->
		<%@ include file="../include/header.jsp"%>
		<main id="boardmain">
			<section id="contents">
				<!-- aside -->
				<div class="aside">
					<div class="menubar">
						<ul>
						    <li><a class="list" href="/mypage">마이페이지</a></li>
							<li><a class="list" href="/updateUser">회원수정</a></li>
							<li><a class="list" href="/record">나의활동내역</a></li>
						</ul>
					</div>
				</div>

				<div class="noticeboard">
					<div class="page-title">
						<div class="vline"></div>
						<div class="container2">
							<h3>회원 리스트</h3>
						</div>
					</div>

				<div id="board-list">
					<div class="container2">

						<form action="<c:url value='/Freeboard/freeList'/>">
							<div class="search-wrap clearfix">
								<button type="submit" class="btn btn-primary search-btn"
									style="margin-right: 24%;">검색</button>
								<input type="text" name="keyword"
									class="form-control search-input" value="${pc.paging.keyword}"
									style="width: 200px;"> <select class="form-control"
									id="search-select" name="condition"
									style="width: 80px; margin-left: 45%">
									<option value="title"
										${pc.paging.condition == 'title' ? 'selected' : ''}>제목</option>
									<option value="content"
										${pc.paging.condition == 'content' ? 'selected' : ''}>내용</option>
									<option value="writer"
										${pc.paging.condition == 'userId' ? 'selected' : ''}>작성자</option>
								</select>
							</div>
						</form>


						<table class="board-table" style="width: 90%; margin: 0 auto;">
							<thead>
								<tr>
									<th scope="col" class="th-num">아이디</th>
									<th scope="col" class="th-title">이메일</th>
									<th scope="col" class="th-writer">이름</th>
									<th scope="col" class="th-date">사진</th>
									<th scope="col" class="th-hit">성별</th>
									<th scope="col" class="th-like">작성게시글</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="user" items="${userList}">
									<tr>
										<th scope="row">${user.userId}</th>
										<td><a href="">${user.userEmail}
												(${user.username})</a></td>
										<td>${user.userImageName}</td>
										<td>${user.gender}</td>
										<td>${user.writeCount}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>





<%-- 					<c:forEach items="${userList}" var="user">
						<b> <a href="admin/${user.userId}">${user.userId}</a>
						</b>
					</c:forEach> --%>
			</section>
		</main>
		<%@ include file="../include/footer.jsp"%>
	</div>

</body>
<style>
.noticeboard {
	width: 100%;
}

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

.paging {
	margin-left: auto;
	margin-right: auto;
	display: table;
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
	margin-bottom: 20px;
}

.search-btn, .search-input, .search-select {
	float: right; /*우측 플로팅 */
}

.search-input {
	width: 140px;
}

#search-select {
	width: 80px;
}
</style>
</html>
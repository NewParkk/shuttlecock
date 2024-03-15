<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
	<!-- header -->
	<%@ include file="../include/header.jsp"%>

	<!-- main -->
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
						<h3>나의 활동내역</h3>
					</div>
				</div>


				<div id="board-list">
					<div class="container2">

						<%--<form action="<c:url value='/Freeboard/freeList'/>">
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
							</form> --%>

						<table class="board-table" style="width: 90%; margin: 0 auto;">
							<form>
								<select id="selectbox" name="selectbox"
									onchange="chageLangSelect()">
									<option value="boardList">게시물</option>
									<option value="likeList">좋아요</option>
									<option value="commentList">댓글</option>
								</select>
							</form>

							<thead id="board">
								<tr>
									<th scope="col" class="th-num">번호</th>
									<th scope="col" class="th-title">제목</th>
									<!-- <th scope="col" class="th-title">내용</th> -->
									<th scope="col" class="th-date">날짜</th>
									<!-- <th scope="col" class="th-writer">이름</th>
											<th scope="col" class="th-date">사진</th>
											<th scope="col" class="th-hit">성별</th>
											<th scope="col" class="th-like">작성게시글</th> -->
								</tr>
							</thead>

							<tbody id="board1">
								<!-- <div id="board" style="display:"> -->
								<c:forEach items="${league}" var="legue">
									<tr>
										<th scope="row">${legue.leagueboardId}</th>
										<td>${legue.title}</td>
										<td>${legue.regdate}</td>
									</tr>
								</c:forEach>
								<c:forEach items="${free}" var="free">
									<tr>
										<th scope="row">${free.freeboardId}</th>
										<td>${free.title}</td>
										<td>${free.regdate}</td>
									</tr>
								</c:forEach>
								<c:forEach items="${trade}" var="trade">
									<tr>
										<th scope="row">${trade.tradeboardId}</th>
										<td>${trade.title}</td>
										<td>${trade.regdate}</td>
									</tr>
								</c:forEach>
								<c:forEach items="${recruit}" var="recruit">
									<tr>
										<th scope="row">${recruit.recruitboardId}</th>
										<td>${recruit.title}</td>
										<td>${recruit.regdate}</td>
									</tr>
								</c:forEach>
								<!-- </div> -->
							</tbody>

							<thead id="comment1" style="display:none">
								<tr>
									<th scope="col" class="th-writer">분류</th>
									<th scope="col" class="th-title">내용</th>
									<!-- <th scope="col" class="th-title">내용</th> -->
									<th scope="col" class="th-date">날짜</th>
									<!-- 					<th scope="col" class="th-writer">이름</th>
											<th scope="col" class="th-date">사진</th>
											<th scope="col" class="th-hit">성별</th>
											<th scope="col" class="th-like">작성게시글</th> -->
								</tr>
							</thead>
							<tbody id="comment" style="display:none">
								<!-- 			<div id="comment" style="display: none"> -->
								<c:forEach items="${comment}" var="comment">
									<tr>
										<th scope="row"><c:set var="num" value="${comment.bno}" />
											<c:choose>
												<c:when test="${num == 1}">
													<!-- 조건 1이 true일 때 실행되는 부분 -->
											        공지게시판
											    </c:when>
												<c:when test="${num == 2}">
													<!-- 조건 2가 true일 때 실행되는 부분 -->
											        자유게시판
											    </c:when>
												<c:when test="${num == 3}">
													<!-- 조건 2가 true일 때 실행되는 부분 -->
											        거래게시판
											    </c:when>
												<c:when test="${num == 4}">
													<!-- 조건 2가 true일 때 실행되는 부분 -->
											        모집게시판
											    </c:when>
												<c:when test="${num == 5}">
													<!-- 조건 2가 true일 때 실행되는 부분 -->
											        리그게시판
											    </c:when>
												<c:otherwise>
													<!-- 모든 조건이 false일 때 실행되는 부분 -->

												</c:otherwise>
											</c:choose>
										</th>
										<td>${comment.content}</td>
										<td>${comment.regdate}</td>
									</tr>
								</c:forEach>
								<!-- 	</div> -->
							</tbody>
							<thead id="like1" style="display:none">
								<tr>
									<th scope="col" class="th-date">분류</th>
									<th scope="col" class="th-title">제목</th>
									<!-- <th scope="col" class="th-title">내용</th> -->
									<th scope="col" class="th-date">날짜</th>
									<!-- 					<th scope="col" class="th-writer">이름</th>
											<th scope="col" class="th-date">사진</th>
											<th scope="col" class="th-hit">성별</th>
											<th scope="col" class="th-like">작성게시글</th> -->
								</tr>
							</thead>
							<tbody id="like" style="display:none">
								<!-- <div id="like" style="display: none"> -->
								<c:forEach items="${like}" var="like">
									<tr>
										<th scope="row"><c:set var="num" value="${like.likes_type}" />
											<c:choose>
												<c:when test="${num == 1}">
													<!-- 조건 1이 true일 때 실행되는 부분 -->
											        공지게시판
											    </c:when>
												<c:when test="${num == 2}">
													<!-- 조건 2가 true일 때 실행되는 부분 -->
											        자유게시판
											    </c:when>
												<c:when test="${num == 3}">
													<!-- 조건 2가 true일 때 실행되는 부분 -->
											        거래게시판
											    </c:when>
												<c:when test="${num == 4}">
													<!-- 조건 2가 true일 때 실행되는 부분 -->
											        모집게시판
											    </c:when>
												<c:when test="${num == 5}">
													<!-- 조건 2가 true일 때 실행되는 부분 -->
											        리그게시판
											    </c:when>
												<c:otherwise>
													<!-- 모든 조건이 false일 때 실행되는 부분 -->

												</c:otherwise>
											</c:choose>
										</th>
										<td>${like.title}</td>
										<td>${like.regdate}</td>
									</tr>
								</c:forEach>
								<!-- </div> -->
							</tbody>


						</table>


					</div>
				</div>


			</div>
		</section>
	</main>
	</div>




	<%-- <tbody id="board">
									<!-- <div id="board" style="display:"> -->
	<c:forEach items="${league}" var="legue">
		<tr>
			<th scope="row">${legue.title}</th>
			<td>${legue.content}</td>
		</tr>
	</c:forEach>
	<c:forEach items="${free}" var="free">
		<tr>
			<th scope="row">${free.title}</th>
			<td>${free.content}</td>
		</tr>
	</c:forEach>
	<c:forEach items="${trade}" var="trade">
		<tr>
			<th scope="row">${trade.title}</th>
			<td>${trade.content}</td>
		</tr>
	</c:forEach>
	<c:forEach items="${recruit}" var="recruit">
		<tr>
			<th scope="row">${recruit.title}</th>
			<td>${recruit.content}</td>
		</tr>
	</c:forEach>
	<!-- </div> -->
	</tbody>
	
	<tbody id="comment">
		<!-- 			<div id="comment" style="display: none"> -->
		<c:forEach items="${comment}" var="comment">
			<tr>
				<th scope="row">${comment.content}</th>
				<td>${comment.content}</td>
			</tr>
		</c:forEach>
		<!-- 	</div> -->
	</tbody>

	<tbody id="like">
		<!-- <div id="like" style="display: none"> -->
		<c:forEach items="${like}" var="like">
			<tr>
				<th scope="row">${like.title}</th>
				<td>${like.content}</td>
			</tr>
		</c:forEach>
		<!-- </div> -->
	</tbody>
	</form>
	</tbody>
	</table>
	</div>
	</div>
	</div>
	</section>
	</main>
	</div>
	--%>
















	<!-- 	//1. onchange 속성 select change 발생event -> function
	//2. function -> select -> selected -> test2 -> likeid -> div display / display:none -->
	<script>
		function chageLangSelect() {
			var langSelect = document.getElementById("selectbox");

			var selectValue = langSelect.options[langSelect.selectedIndex].value;
			var board = document.getElementById("board").getAttribute('id');
			var comment = document.getElementById("comment").getAttribute('id');
			var like = document.getElementById("like").getAttribute('id');
			
			var board1 = document.getElementById("board").getAttribute('id');
			var comment1 = document.getElementById("comment").getAttribute('id');
			var like1 = document.getElementById("like").getAttribute('id');

			console.log(selectValue);

			if (selectValue == "boardList") {
				document.getElementById("board").style.display = "";
				document.getElementById("like").style.display = "none";
				document.getElementById("comment").style.display = "none";
				document.getElementById("board1").style.display = "";
				document.getElementById("like1").style.display = "none";
				document.getElementById("comment1").style.display = "none";

			} else if (selectValue == "commentList") {
				document.getElementById("comment").style.display = "";
				document.getElementById("like").style.display = "none";
				document.getElementById("board").style.display = "none";
				document.getElementById("comment1").style.display = "";
				document.getElementById("like1").style.display = "none";
				document.getElementById("board1").style.display = "none";

			} else if (selectValue == "likeList") {
				document.getElementById("like").style.display = "";
				document.getElementById("comment").style.display = "none";
				document.getElementById("board").style.display = "none";
				document.getElementById("like1").style.display = "";
				document.getElementById("comment1").style.display = "none";
				document.getElementById("board1").style.display = "none";
			} else {
				document.getElementById("like").style.display = "none";
				document.getElementById("comment").style.display = "none";
				document.getElementById("board").style.display = "none";
				document.getElementById("like1").style.display = "none";
				document.getElementById("comment1").style.display = "none";
				document.getElementById("board1").style.display = "none";
			}

		}
	</script>
	<%@ include file="../include/footer.jsp"%>
</body>
<style>
a {
	font-size: 1.17rem;
	!
	important;
}

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
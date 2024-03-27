<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>

<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<!-- aisde-js 파일 -->
<script src="/js/aside-js.js"></script>
<link rel="stylesheet" href="/css/free.css">
<link rel="stylesheet" href="/css/mypage1.css">

</head>
<body>
<div id="wrap">
	<!-- header -->
	<%@ include file="../include/header.jsp"%>

	<!-- main -->
	<main id="main">
		<div id="slider">
			<div class="imageWrap1"></div>
		</div>

		<!-- section -->
		<section id="contents">


			<!-- aside -->
			<div class="aside">
				<div class="menubar">
					<ul>
						<li><a class="list" href="/mypage">마이페이지</a></li>
						<li><a class="list" href="/updateUser">내 프로필</a></li>
						<li><a class="list" href="/record">나의활동내역</a></li>
						<li><a class="list" href="/manageBlockedUser">차단유저관리</a></li>
					</ul>
				</div>
			</div>
			<div class="noticeboard">
				<div class="title" style="margin: 0px;">
					<div class="vline"></div>
					<div class="container2">
						<h3>나의 활동내역 &#10095</h3>
					</div>
				</div>


				<div id="board-list">
					<div class="container2">

						<form style="float: right; margin: 30px 50px 10px 0;">
							<select class="selectbox" id="selectbox" name="selectbox"
								onchange="chageLangSelect()" style="margin-left: 50px">
								<option value="boardList">게시물</option>
								<option value="likeList">좋아요</option>
								<option value="commentList">댓글</option>
							</select>
						</form>

						<table class="board-table"
							style="width: 92%; margin: 20px auto 0;">
							<thead id="board">
								<tr style="background-color: rgba(103, 141, 115, 0.1);">
									<th scope="col" class="th-num">번호</th>
									<th scope="col" class="th-date">분류</th>
									<th scope="col" class="th-title">제목</th>
									<th scope="col" class="th-date">날짜</th>
								</tr>
							</thead>

							<tbody id="board1">

								<c:forEach items="${league}" var="league">
									<tr>
										<td scope="row" style="font-size: 11px;">${league.leagueboardId}</td>
										<td bgcolor="#f9f9f9">리그게시판</td>
										<td><a href="/LeagueBoard/${league.leagueboardId}">${league.title}</a></td>
										<td style="color: gray;"><fmt:formatDate
												value="${league.regdate}" pattern="yyyy-MM-dd HH:mm" /></td>
									</tr>
								</c:forEach>
								<c:forEach items="${free}" var="free">
									<c:choose>
										<c:when test="${free.commentCount != 0}">
											<tr>
												<td scope="row" style="font-size: 11px;">${free.freeboardId}</td>
												<td bgcolor="#f9f9f9">자유게시판</td>
												<td><a href="/Freeboard/freeDetail/${free.freeboardId}">${free.title}[${free.commentCount}]</a></td>
												<td style="color: gray;"><fmt:formatDate
														value="${free.regdate}" pattern="yyyy-MM-dd HH:mm" /></td>
											</tr>
										</c:when>
										<c:when test="${free.commentCount == 0}">
											<tr>
												<td scope="row" style="font-size: 11px;">${free.freeboardId}</td>
												<td bgcolor="#f9f9f9">자유게시판</td>
												<td><a href="/Freeboard/freeDetail/${free.freeboardId}">${free.title}</a></td>
												<td style="color: gray;"><fmt:formatDate
														value="${free.regdate}" pattern="yyyy-MM-dd HH:mm" /></td>
											</tr>
										</c:when>
									</c:choose>
								</c:forEach>
								<c:forEach items="${trade}" var="trade">
									<c:choose>
										<c:when test="${trade.commentCount != 0}">
											<tr>
												<td scope="row" style="font-size: 11px;">${trade.tradeboardId}</td>
												<td bgcolor="#f9f9f9">거래게시판</td>
												<td><a href="Tradeboard/${trade.tradeboardId}">${trade.title}[${trade.commentCount}]</a></td>
												<td style="color: gray;"><fmt:formatDate
														value="${trade.regdate}" pattern="yyyy-MM-dd HH:mm" /></td>
											</tr>
										</c:when>
										<c:when test="${trade.commentCount == 0}">
											<tr>
												<td scope="row" style="font-size: 11px;">${trade.tradeboardId}</td>
												<td bgcolor="#f9f9f9">거래게시판</td>
												<td><a href="Tradeboard/${trade.tradeboardId}">${trade.title}</a></td>
												<td style="color: gray;"><fmt:formatDate
														value="${trade.regdate}" pattern="yyyy-MM-dd HH:mm" /></td>
											</tr>
										</c:when>
									</c:choose>
								</c:forEach>
								<c:forEach items="${recruit}" var="recruit">
									<c:choose>
										<c:when test="${recruit.commentCount != 0}">
											<tr>
												<td scope="row" style="font-size: 11px;">${recruit.recruitboardId}</td>
												<td bgcolor="#f9f9f9">모집게시판</td>
												<td><a href="Recruitboard/${recruit.recruitboardId}">${recruit.title}[${recruit.commentCount}]</a></td>
												<td style="color: gray;"><fmt:formatDate
														value="${recruit.regdate}" pattern="yyyy-MM-dd HH:mm" /></td>

											</tr>
										</c:when>
										<c:when test="${recruit.commentCount == 0}">
											<tr>
												<td scope="row" style="font-size: 11px;">${recruit.recruitboardId}</td>
												<td bgcolor="#f9f9f9">모집게시판</td>
												<td><a href="Recruitboard/${recruit.recruitboardId}">${recruit.title}</a></td>
												<td style="color: gray;"><fmt:formatDate
														value="${recruit.regdate}" pattern="yyyy-MM-dd HH:mm" /></td>

											</tr>
										</c:when>
									</c:choose>
								</c:forEach>
							</tbody>

							<thead id="comment1" style="display: none">
								<tr style="background-color: rgba(103, 141, 115, 0.1);">
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
							<tbody id="comment" style="display: none">
								<!-- 			<div id="comment" style="display: none"> -->
								<c:forEach items="${comment}" var="comment">
									<tr>
										<th scope="row"><c:set var="num"
												value="${comment.commentType}" /> <c:choose>
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
											</c:choose></th>
										<td scope="row"><c:set var="num"
												value="${comment.commentType}" /> <c:choose>
												<c:when test="${num == 1}">
													<!-- 조건 1이 true일 때 실행되는 부분 -->
											        공지게시판
											    </c:when>
												<c:when test="${num == 2}">
													<!-- 조건 2가 true일 때 실행되는 부분 -->
													<a href="Freeboard/freeDetail/${comment.bno}">${comment.content}</a>
												</c:when>
												<c:when test="${num == 3}">
													<!-- 조건 2가 true일 때 실행되는 부분 -->
													<a href="Tradeboard/${comment.bno}">${comment.content}</a>
												</c:when>
												<c:when test="${num == 4}">
													<!-- 조건 2가 true일 때 실행되는 부분 -->
													<a href="Recruitboard/${comment.bno}">${comment.content}</a>
												</c:when>
												<c:otherwise>
													<!-- 모든 조건이 false일 때 실행되는 부분 -->

												</c:otherwise>
											</c:choose></td>
										<td>${comment.regdate}</td>
									</tr>
								</c:forEach>
								<!-- 	</div> -->
							</tbody>
							<thead id="like1" style="display: none">
								<tr style="background-color: rgba(103, 141, 115, 0.1);">
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
							<tbody id="like" style="display: none">
								<!-- <div id="like" style="display: none"> -->
								<c:forEach items="${tradeLikeList}" var="trade">
									<tr>
										<th scope="row">거래게시판</th>
										<td><a href="Tradeboard/${trade.tradeboardId}">${trade.title}</a></td>
										<td>${trade.regdate}</td>
									</tr>
								</c:forEach>
								<c:forEach items="${freeLikeList}" var="free">
									<tr>
										<th scope="row">자유게시판</th>
										<td><a href="/Freeboard/freeDetail/${free.freeboardId}">${free.title}</a></td>
										<td>${free.regdate}</td>
									</tr>
								</c:forEach>
								<c:forEach items="${recruitLike}" var="recruit">
									<tr>
										<th scope="row">모집게시판</th>
										<td><a href="Recruitboard/${recruit.recruitboardId}">${recruit.title}</a></td>
										<td>${recruit.regdate}</td>
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
	<%@ include file="../include/footer.jsp"%>
</div>

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
			var comment1 = document.getElementById("comment")
					.getAttribute('id');
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
</body>
</html>
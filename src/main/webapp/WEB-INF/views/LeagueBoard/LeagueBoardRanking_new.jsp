<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle Cock</title>
<link rel="stylesheet" href="/css/mainstyle.css">

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

.card-container {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}

.card {
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	padding: 20px;
	margin: 10px;
	width: 300px;
	max-width: 80%;
}

.card img {
	width: 100%;
	border-radius: 8px;
	margin-bottom: 10px;
}

.card h2 {
	margin-top: 0;
	margin-bottom: 10px;
}

.card p {
	margin-top: 0;
}


</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<%@ include file="category.jsp"%>
	<div class="mainTitle">
		<h1>리그게시판</h1>
	</div>
	<div class="container">
		<div class="card-container">
		<div class="card">
			<span style="width:20%">이름</span> <span style="width:20%" >이미지</span> <span style="width:20%">승</span><span style="width:20%">승</span><span style="width:20%">승</span>
		</div>
		<c:forEach items="${leagueRankingList}" var="user">
			<div class="card">
				<p>${user.username} <img src="" >
									${user.wincount} ${user.losecount} ${user.wincount - user.losecount}
									<b> <c:set var="winRatio"
											value="${(user.wincount * 1.0 / (user.wincount + user.losecount)) * 100}" />
										<fmt:formatNumber value="${winRatio}" pattern="###.##" />%
									</b></p>
			</div>
		</c:forEach>
		
		</div>
		
		<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script>
		function redirectToInsertForm() {
			window.location.href = "/LeagueBoard/insert";
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
	</script>
</body>
</html>

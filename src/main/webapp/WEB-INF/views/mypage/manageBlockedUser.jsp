<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle Cock</title>
<link rel="stylesheet" href="/css/loginstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<link rel="stylesheet" href="/css/free.css">
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<style type="text/css">
.delbtn {
	float: right;
	margin: 0;
}

th {
	text-align: center;
	font-size: 20px;
}
</style>
</head>
<body>
	<div id="wrap">
		<%@ include file="../include/header.jsp"%>

		<main id="main">
			<section id="contents">

				<!-- aside -->
				<div class="aside">
					<div class="menubar">
						<ul>
							<li><a class="list" href="/mypage">마이페이지</a></li>
							<li><a class="list" href="/updateUser">회원수정</a></li>
							<li><a class="list" href="/record">나의활동내역</a></li>
							<li><a class="list" href="/manageBlockedUser">차단유저관리</a></li>
						</ul>
					</div>
				</div>

				<div class="noticeboard">
					<div class="page-title">
						<div class="vline"></div>
						<div class="container2">
							<h3>차단유저관리</h3>
						</div>
					</div>
					<div id="board-list">
						<div class="container">
							<form action="/Recruitboard" method="get"
								style="text-align: center;">
								<div class="search-wrap clearfix">
									<input id="searchKeyword" type="search" name="searchKeyword"
										placeholder="검색할 아이디를 입력해주세요." style="width: 300px;"
										class="form-control search-input"
										value="${pageInfo.pageRequest.searchKeyword}"> <input
										name="pageNum" type="hidden"
										value="${pageInfo.pageRequest.pageNum}"> <input
										name="amount" type="hidden"
										value="${pageInfo.pageRequest.amount}"> <input
										name="userId" type="hidden"
										value="${pageInfo.pageRequest.userId}">
									<button class="btn btn-primary search-btn" type="submit"
										style="margin-left: 10px;">검색</button>
								</div>
							</form>

							<!-- board list area -->
							<table class="board-table" style="width: 90%; margin: 0 auto;">
								<thead>
									<tr>
										<th scope="col" class="th-title" style="font-size: 13px;">차단된
											사용자 목록</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${blockeduserList}" var="blockuser">
										<tr>
											<th scope="row" bgcolor="" style="text-align: center;">${blockuser.blockedUser}
												<button class="btn btn-primary goBtn delbtn"
													value="${blockuser.blockedUser}">차단해제</button>
											</th>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<c:if test="${empty blockeduserList}">
								<div class="empty-post"
									style="text-align: center; margin-top: 10px;">차단된 사용자가
									없습니다.</div>
							</c:if>
						</div>
					</div>
				</div>
			</section>
		</main>
	</div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script>
		function checkKeyword() {
			let mainForm = document.getElementById('mainForm');
			// 검색 시 항상 pageNum을 1로 설정
			mainForm.pageNum.value = 1;
			if (mainForm.searchKeyword.value === null
					|| mainForm.searchKeyword.value === '') {
				mainForm.searchKeyword.remove();
			}
		}

		$('.delbtn').click(function() {
			const blockedUser = $('.delbtn').val();
			console.log(blockedUser);
			$.ajax({
				type : "post",
				url : '<c:url value="/unblockuser"/>',
				data : {
					"userId" : "${sessionScope.userId}",
					"blockedUser" : blockedUser
				},
				success : function(data) {
					alert(blockedUser + "님의 차단이 해제되었습니다.");
					location.reload();
				}
			});
		}); // click
	</script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle Cock</title>
<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<link rel="stylesheet" href="/css/free.css">
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<style>
.delbtn{
	float: right;
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
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<main id="boardmain">
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
				<div class="title" style="">
					<div class="vline"></div>
					<div class="container2">
						<h3>차단유저관리</h3>
					</div>
				</div>
				<div id="board-list">
					<div class="container">
						<!-- board list area -->
						<table class="board-table" style="width: 90%; margin: 0 auto;">
							<thead>
								<tr>
									<th scope="col" class="th-title">차단된 사용자 목록</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${blockeduserList}" var="blockuser">
									<tr>
										<th scope="row" bgcolor="" style="text-align: center;">${blockuser.blockedUser}
											<button class="delbtn" value="${blockuser.blockedUser}">차단해제</button>
										</th>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<c:if test="${empty blockeduserList}">
							<div class="empty-post" style="text-align: center; margin-top: 10px;">차단된
								사용자가 없습니다.</div>
						</c:if>
					</div>
				</div>
			</div>
		</section>
	</main>
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
		
		$('.delbtn').click(function(){
			const blockedUser = $('.delbtn').val();
			console.log(blockedUser);
			$.ajax({
				type : "post",
				url : '<c:url value="/unblockuser"/>',
				data : {
					"userId" : "${sessionScope.userId}",
					"blockedUser" : blockedUser
				},
				success : function(data){
					alert(blockedUser + "님의 차단이 해제되었습니다.");
					location.reload();
				}
			});
		}); // click
	</script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shuttle Cock</title>
<link rel="stylesheet" href="/css/loginstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<!-- aisde-js 파일 -->
<script src="/js/aside-js.js"></script>
<link rel="stylesheet" href="/css/free.css">
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<style type="text/css">
.delbtn {
	float: right;
	margin: 0;
}

th {
	text-align: center;
	font-size: 17px;
}
.current-page {
   background-color: #607d67 !important;
   color: #fff !important;
   padding: 5px 10px !important;
   border: 1px solid #607d67 !important; 
   border-radius: 5px !important;
} 
</style>
</head>
<body>
	<div id="wrap">
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
							<li><a class="list" href="/mypage">마이페이지</a></li>
							<li><a class="list" href="/updateUser">내 프로필</a></li>
							<li><a class="list" href="/record">나의활동내역</a></li>
							<li><a class="list" href="/manageBlockedUser">차단유저관리</a></li>
						</ul>
					</div>
				</div>

				<div class="noticeboard">
					<div class="title" style="margin:0px;">
						<div class="vline"></div>
						<div class="container2">
							<h3>차단유저관리</h3>
						</div>
					</div>
					<div id="board-list">
						<div class="container">
							<form action="/manageBlockedUser" method="get"
								style="text-align: right; margin: 20px 50px 10px 0px;">
								<div class="search-wrap clearfix">
									<input id="searchKeyword" type="search" name="searchKeyword"
										placeholder="검색할 아이디를 입력해주세요." style="width: 300px;"
										class="form-control search-input"
										value="${pageInfo.pageRequest.searchKeyword}">  <input
										name="userId" type="hidden"
										value="${pageInfo.pageRequest.userId}">
									<button class="btn btn-primary search-btn" type="submit"
										>검색</button>
								</div>
							</form>

							<!-- board list area -->
							<table class="board-table" style="width: 92%; margin: 0 auto;">
								<thead>
									<tr style="background-color: rgba(103, 141, 115, 0.1);">
										<th scope="col" style="width:90%; font-size: 13px;">차단된
											사용자 목록</th>
										<td></td>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${blockeduserList}" var="blockuser">
										<tr>
											<th scope="row" bgcolor="" style="text-align: center;">${blockuser.blockedUser}
											</th>
											<td><button class="btn btn-primary goBtn1 delbtn"
												value="${blockuser.blockedUser}">차단해제</button>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<c:if test="${empty blockeduserList}">
								<div class="empty-post"
									style="text-align: center; margin-top: 10px;">차단된 사용자가
									없습니다.</div>
							</c:if>
							<div class="paging">
							<form action="/manageBlockedUser" method="get">
								<div class="row justify-content-center"
									style="display: flex; justify-content: center;">
									<div class="col-auto">
									
										<div class="page navigation">
											<ul class="pagination">
												<c:if test="${pageInfo.prev}">
													<li class="page-item"><a class="page-link"
														aria-label="Previous"
														href="/manageBlockedUser?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}
														&searchKeyword=${pageInfo.pageRequest.searchKeyword}">Prev</a>
													</li>
												</c:if>
												<c:forEach var="num" begin="${pageInfo.startPage}"
													end="${pageInfo.endPage}">
													<li class="page-item ${pageInfo.pageRequest.pageNum == num ? "active" : "" } ">
														<a id="pbtn_${num}" class="page-link"
														href="/manageBlockedUser?pageNum=${num}&amount=${pageInfo.pageRequest.amount}
														&searchKeyword=${pageInfo.pageRequest.searchKeyword}">${num}</a>
													</li>
												</c:forEach>
												<c:if test="${pageInfo.next}">
													<li class="page-item next"><a class="page-link"
														aria-label="next"
														href="/manageBlockedUser?pageNum=${pageInfo.endPage + 1}&amount=${pageInfo.pageRequest.amount}
														&searchKeyword=${pageInfo.pageRequest.searchKeyword}">Next</a>
													</li>
												</c:if>
											</ul>
										</div>
									</div>
								</div>
							</form>
						</div>
						</div>
					</div>
				</div>
			</section>
		</main>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	</div>
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
		
		window.onload = function(){
			const pageNum = ${pageInfo.pageRequest.pageNum};
			console.log(pageNum);
			$('#pbtn_' + pageNum).toggleClass('current-page');
		};
	</script>
</body>
</html>

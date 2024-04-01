<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin</title>
<link rel="stylesheet" href="/css/loginstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<link rel="stylesheet" href="/css/free.css">
<link rel="stylesheet" href="/css/admin.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<style>
.noticeboard {
	width: 90%;
}
</style>
</head>
<body>
		<!-- wrap -->
		<div id="wrap">
			<!-- header -->
			<%@ include file="../include/header.jsp"%>
			
			<!-- main -->
			<main id= "main">
		        <div id="slider">
		          <div class="imageWrap1"></div>
		        </div>
		
				<!-- section -->
				<section id="contents">
					<div class="noticeboard">
						<div class="title" style="margin:0px;">
							<div class="vline"></div>
							<div class="container2">
								<h3>회원 리스트</h3>
							</div>
						</div>
						<div id="board-list">
							<div class="container2">
								<%-- <form id="mainForm" action="/admin" onsubmit="checkKeyword()"
								style="text-align: center;">
								<div class="search-wrap clearfix">
									<select class="form-control" id="search-select" name="category"
										onchange="chageLangSelect()"
										style="width: 100px; margin-left: 10px;">
										<option value="userId">아이디</option>
										<option value="username">이름</option>
									</select> <input type="text" class="form-control search-input"
										id="searchKeyword" placeholder="SearchKeyword"
										name="searchKeyword" style="width: 300px"
										value="${pageInfo.pageRequest.searchKeyword}">
									<!-- hidden -->
									<input name="pageNum" type="hidden"
										value="${pageInfo.pageRequest.pageNum}"> <input
										name="amount" type="hidden"
										value="${pageInfo.pageRequest.amount}"> <input
										type="submit" class="btn btn-primary search-btn" value="검색"
										style="margin-left: 100px;" />
								</div>
							</form> --%>
								
								<!-- 검색창 -->
								<form action="<c:url value='/admin'/>" onsubmit="checkKeyword()"
									style="text-align: center;">
									<div class="search-wrap clearfix"
										style="display: flex; justify-content: flex-end;">
										<select class="form-control" id="search-select"
											onchange="chageLangSelect()" name="category"
											style="width: 100px; margin-left: 10px;">
											<option value="userId"
												${pageInfo.pageRequest.category == 'userId' ? 'selected' : ''}>아이디</option>
											<option value="username"
												${pageInfo.pageRequest.category == 'username' ? 'selected' : ''}>이름</option>
										</select> <input type="text" id="keyword" name="searchKeyword"
											class="form-control search-input"
											value="${pageInfo.pageRequest.searchKeyword}"
											style="width: 300px;" placeholder="검색어를 입력하세요">
										<button type="submit" class="btn btn-primary search-btn">검색</button>
									</div>
								</form>
								<table class="board-table" style="width: 90%; margin: 0 auto;">
									<thead>
										<tr style="background-color: rgba(103, 141, 115, 0.1);">
											<th scope="col" class="th-writer">이름</th>
											<th scope="col" class="th-title">이메일(아이디)</th>
											<th scope="col" class="th-date">권한</th>
											<th scope="col" class="th-hit">성별</th>
											<th scope="col"></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="user" items="${userSearchList}">
											<tr>
												<td scope="row" style="text-align:left; padding-left:30px;">${user.username}</td>
												<th style="text-align:center;"><a href="/admin/${user.userId}">${user.userEmail}
														(${user.userId})</a></th>
												<td><c:set var="isFlag" value="${user.admin}" /> <c:choose>
														<c:when test="${isFlag == true}">
															<span style="font-weight: bold;">&#10024;관리자</span>
														</c:when>
													</c:choose> <c:choose>
														<c:when test="${isFlag == false}">
														 	<span style="color: gray;">회원</span>
														</c:when>
													</c:choose></td>
												<td style="color:gray;"><c:set var="num" value="${user.gender}" /> <c:choose>
														<c:when test="${num == 1}">
														남
													</c:when>
													</c:choose> <c:choose>
														<c:when test="${num == 2}">
														여
													</c:when>
													</c:choose></td>
												<td><input type="hidden" value="${user.userId}">
													<button type="button" class="btn btn-primary delBtn" style="margin-bottom:0px;">삭제</button>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<!-- 페이징 -->
								<div class="paging">
									<form action="<c:url value='/admin' />" name="pageForm">
										<div class="text-center clearfix">
											<ul class="pagination" id="pagination">
												<c:if test="${pageInfo.prev}">
													<li class="page-item"><a class="page" href="/admin?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}"
														data-pageNum="${pageInfo.startPage-1}">Prev</a></li>
												</c:if>
												<c:forEach var="num" begin="${pageInfo.startPage}"
													end="${pageInfo.endPage}">
													<li class="page-item"><c:choose>
															<c:when test="${pageInfo.pageRequest.pageNum == num}">
																<span class="page-link current-page">${num}</span>
															</c:when>
															<c:otherwise>
																<a class="page-link" href="#" data-pageNum="${num}">${num}</a>
															</c:otherwise>
														</c:choose></li>
												</c:forEach>
												<c:if test="${pageInfo.next}">
													<li class="page-item"><a class="page" href="/admin?pageNum=${pageInfo.endPage + 1}&amount=${pageInfo.pageRequest.amount}"
														data-pageNum="${pageInfo.endPage+1}">Next</a></li>
												</c:if>
											</ul>
											<!-- 페이지 관련 버튼을 클릭 시 같이 숨겨서 보낼 값 -->
											<input type="hidden" name="pageNum"
												value="${pageInfo.pageRequest.pageNum}"> <input
												type="hidden" name="amount"
												value="${pageInfo.pageRequest.amount}"> <input
												type="hidden" name="searchKeyword"
												value="${pageInfo.pageRequest.searchKeyword}"> <input
												type="hidden" name="category"
												value="${pageInfo.pageRequest.category}">
										</div>
									</form>
								</div>
								<!--// 페이징 -->
							</div>
						</div>
						<!-- //board-list -->
					</div>
					<!-- //noticeboard -->
				</section>
				<!-- //section -->
			</main>
			<!-- //main -->
			
			<!-- footer -->
			<%@ include file="../include/footer.jsp"%>
			
		</div>
		<!-- //wrap -->
</body>
<script>
	document.addEventListener("DOMContentLoaded", function () {
	    // 페이지네이션 버튼에 이벤트 리스너 등록
	    Array.from(document.getElementsByClassName('page-link'))
	        .forEach((pagingButton) => {
	            pagingButton.addEventListener('click', function(e) {
	                e.preventDefault();
	                // 페이지 번호를 가져옴
	                let pageNum = parseInt(e.target.innerHTML);
	               
	                // 폼을 찾아서 pageNum 값을 변경
	                let pageForm = document.forms.pageForm;
	                pageForm.pageNum.value = pageNum;
	               
	                // 폼 제출
	                pageForm.submit();
	            });
	        });
	   
	   
	       
	    // 삭제 버튼 클릭 이벤트를 처리합니다.
	    document.querySelectorAll(".delBtn").forEach(function (button) {
	        button.addEventListener("click", function (e) {
	            e.preventDefault();
	           
	            // 현재 버튼의 부모 tr 요소를 찾아서 해당 사용자의 userId를 가져옵니다.
	            var userId = this.closest("tr").querySelector("input[type='hidden']").value;
	           
	            // 알림을 통해 사용자에게 삭제 여부를 확인할 수 있습니다.
	            var isConfirmed = confirm("사용자를 삭제하시겠습니까?");
	            console.log("출력 : "+userId);
	            if (isConfirmed) {
	                // 액시오스를 사용하여 서버로 DELETE 요청을 보냅니다.
	                console.log(userId);
	                axios.delete('/admin/delete/' + userId)
	                .then(function (response) {
	                    console.log(response.data);
	                    alert("사용자가 삭제되었습니다.");
	                 // 페이지 새로고침
	                    window.location.reload();
	                })
	                .catch(function (error) {
	                    console.error('Error during user deletion:', error);
	                    alert("삭제할 권한이 없습니다");
	                });
	            }
	        });
	    });
	});
	
	function checkKeyword() {
		let mainFormkey = document.getElementById('mainForm');
		if(mainForm.searchKeyword.value === null || mainForm.searchKeyword.value === '') {
			mainForm.searchKeyword.remove();
		}
	}
</script>
</html>
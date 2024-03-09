<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Muti 게시판</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/resources/css/layout1.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/layout2.css" rel="stylesheet" type="text/css" />
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
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

.delete-btn {
	margin-left: 95%
}

h1 {
	padding-top: 30px;
	padding-bottom: 30px
}
</style>
<body>
	<div id="wrap">
		<%@ include file="/WEB-INF/views/include/header.jsp"%>
		<%@ include file="category.jsp"%>

		<div class="mainTitle">
			<h1>리그게시판</h1>
		</div>

		<!-- main  -->
		<main id="main">
			<section class="notice">
				<div class="page-title">
					<div class="container"></div>
				</div>

				<form action="/LeagueBoard/update/${leagueboardId}" method="GET"
					name="detailForm" id="detailForm">
					<div id="board-list">
						<div class="container">
							<div class="mb-3" style="width: 50%; margin: 0 auto;">
								<label for="exampleFormControlInput1" class="form-label">제목</label>
								<input type="text" class="form-control"
									id="exampleFormControlInput1" value="${leagueboard.title}"
									readonly>
							</div>
							<div class="row g-3"
								style="width: 51%; margin: 0 auto; margin-top: -25px">
								<div class="col">
									<label for="exampleFormControlInput1" class="form-label">작성자</label>
									<input type="text" class="form-control"
										id="exampleFormControlInput1"
										value="${leagueboard.userId}" readonly>
								</div>
								<div class="col">
									<label for="exampleFormControlInput1" class="form-label">작성
										시간</label> <input type="text" class="form-control"
										id="exampleFormControlInput2" readonly>
								</div>
							</div>
							<div class="row g-3"
								style="width: 51%; margin: 0 auto; margin-top: -10px">
								<div class="col">
									<label for="exampleFormControlInput1" class="form-label">승자</label>
									<input type="text" class="form-control"
										id="exampleFormControlInput1" value="${leagueboard.winner}"
										readonly>
								</div>
								<div class="col">
									<label for="exampleFormControlInput1" class="form-label">패자</label>
									<input type="text" class="form-control"
										id="exampleFormControlInput1" value="${leagueboard.loser}"
										readonly>
								</div>
							</div>

							<div class="mb-3" style="width: 50%; margin: 0 auto;">
								<label for="exampleFormControlTextarea1" class="form-label"></label>
								<div>${leagueboard.content}</div>
							</div>

							<div class="container"
								style="height: 50px; display: flex; justify-content: right;">
								<c:if test="${sessionScope.userId eq leagueboard.userId}">
									<input type="submit" value="수정" class="Btn"
										style="margin-left: 10px;">
								</c:if>
								<c:if
									test="${sessionScope.userId eq leagueboard.userId or sessionScope.admin eq 1}">
									<button type="button" class="delete_btn btn btn-danger"
										style="margin-left: 10px;">삭제</button>
								</c:if>
							</div>
						</div>
					</div>
				</form>
				<div class="container" style="height: 50px;">
					<span style="font-size: 12pt; float: left; margin-right: 7px;"><input
						type="button" value="글 목록" class="Btn"
						onclick="location.href='/LeagueBoard'"></span>
				</div>

			</section>
		</main>

		<%@ include file="/WEB-INF/views/include/footer.jsp"%>

	</div>
	<script type="text/javascript">
		
		document.addEventListener("DOMContentLoaded", function () {
		    // 삭제 버튼 클릭 이벤트를 처리합니다.
		    document.querySelector(".delete_btn").addEventListener("click", function (e) {
		    	e.preventDefault();
		    	
		    	// 알림을 통해 사용자에게 삭제 여부를 확인할 수 있습니다.
		        var isConfirmed = confirm("게시글을 삭제하시겠습니까?");

		        if (isConfirmed) {
		            // 액시오스를 사용하여 서버로 DELETE 요청을 보냅니다.
		            axios.delete('/LeagueBoard/${leagueboard.leagueboardId}')
		            .then(function (response) {
		            	//ResponseEntity.ok 보내주면
		                console.log(response.data);
		                alert("게시글이 삭제되었습니다.");
		                window.location.href = "/LeagueBoard";
		            })
		            .catch(function (error) {
		                // 아닐시
		                console.error('Error during board deletion:', error);
		                alert("게시글 삭제 실패");
		            });
		        }
		    });
		});
		
		
	    // leagueboard.regdate 값을 포맷팅하여 input 태그에 적용
	    var regdate = "${leagueboard.regdate}";
	    var formattedDate = new Date(regdate).toLocaleString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit'}); // 날짜 포맷팅
	    document.getElementById("exampleFormControlInput2").value = formattedDate;
	</script>
</body>
</html>
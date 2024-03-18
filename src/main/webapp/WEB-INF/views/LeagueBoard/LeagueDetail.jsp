<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Shuttle Cock</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/css/mainstyle.css">
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
#main{
	 width: 70%; /* 메인 섹션의 너비를 조정 */
     margin: 0 auto; /* 좌우 여백을 자동으로 설정하여 중앙에 정렬 */
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
							<div class="mb-3" style="width: 70%; margin: 0 auto;">
								<label for="exampleFormControlInput1" class="form-label">제목</label>
								<input type="text" class="form-control"
									id="exampleFormControlInput1" value="${leagueboard.title}"
									readonly>
							</div>
							<div class="row g-3" style="width: 70%; margin: 0 auto;">
								<div class="col">
									<%-- <label for="exampleFormControlInput1" class="form-label">작성자</label>
									<input type="text" class="form-control"
										id="exampleFormControlInput1"
										value="${leagueboard.userId}" readonly> --%>
									<label for="exampleFormControlInput1" class="form-label">작성자</label>
									<input type="text" class="form-control block"
										id="exampleFormControlInput1"
										value="${leagueboard.userId}" readonly>

								</div>
								<div class="col">
									<label for="exampleFormControlInput1" class="form-label">작성
										시간</label> <input type="text" class="form-control"
										id="exampleFormControlInput2" readonly>
								</div>
							</div>
							<div class="row g-3" style="width: 70%; margin: 0 auto;">
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

							<div class="mb-3" style="width: 70%; margin: 0 auto;">
								<label for="exampleFormControlTextarea1" class="form-label"></label>
								<div>${leagueboard.content}</div>
							</div>


							<div class="container"
								style="height: 30px; display: flex; justify-content: flex-end; align-items: center;">
								<button type="button" class="btn btn-primary whyBtn listBtn"
									id="goList" style="margin-top: 30px;">목록</button>
								<c:if test="${sessionScope.userId eq leagueboard.userId}">
									<button type="submit"
										class="btn btn-primary CancleBtn updateBtn"
										style="margin-left: 10px;">수정</button>
								</c:if>
								<c:if
									test="${sessionScope.userId eq leagueboard.userId or sessionScope.isAdmin eq true}">
									<button type="button" class="delete_btn btn btn-danger"
										style="margin-left: 10px;">삭제</button>
								</c:if>
								<c:if test="${sessionScope.userId != leagueboard.userId and not empty sessionScope.userId}">
									<button type="button" id="userblock" style="margin-top: 30px;">게시자차단</button>
								</c:if>
							</div>
						</div>
					</div>
				</form>
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
		
		//목록
		$('#goList').click(function(){
			console.log("33");
			location.href = "/LeagueBoard";
		})
		
	    // leagueboard.regdate 값을 포맷팅하여 input 태그에 적용
	    var regdate = "${leagueboard.regdate}";
	    var formattedDate = new Date(regdate).toLocaleString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit'}); // 날짜 포맷팅
	    document.getElementById("exampleFormControlInput2").value = formattedDate;
	    
	    $('#userblock').click(function(){
	    	alert("${sessionScope.userId}");
	    	$.ajax({
	    		type :"POST",
	    		url : "/blockuser",
	    		data : {
	    			"userId" : "${sessionScope.userId}",
	    			"blockedUser" : "${leagueboard.userId}"
	    		},
	    		success : function(data){
	    			alert(data);
	    			location.reload();
	    		} // success
	    	}) // ajax
	    }) //버튼 클릭
	</script>
</body>
</html>
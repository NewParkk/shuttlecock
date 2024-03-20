<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Shuttle Cock</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<link rel="stylesheet" href="/css/free.css">
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<style>
.contents {
	width: 80%;
}
</style>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<!-- main -->
	<main id="boardmain">
		<section id="contents">
			<%@ include file="category.jsp"%>

			<div class="noticeboard">
				<div class="title" style="">
					<div class="vline"></div>
					<div class="container2">
						<h3>리그게시판</h3>
					</div>
				</div>

				<!-- main  -->
				<div class="post-info">
					<p class="post-title">
						<strong>${leagueboard.title}</strong>
					</p>
					<p class="post-metadata">
						<span class="post-info-text"> <strong>작성자:</strong>
							${leagueboard.userId}
						</span> <span class="post-info-text"> <strong>작성 시간:</strong>
							<fmt:formatDate value="${leagueboard.regdate}" pattern="yyyy-MM-dd HH:mm" />
						</span>
					</p>
				</div>
				<div class="post-content" id="post-content">${leagueboard.content}</div>
				<br>
				<div class="post-info">
				<p class="post-metadata">
					<span class="post-info-text"> <strong>승자:</strong>
						${leagueboard.winner}
					</span> 
					<br>
					<br>
					<span class="post-info-text"> <strong>패자:</strong>
						${leagueboard.loser}
					</span>
				</p>
				</div>


				<div class="post-buttons">
					<button type="button" class="btn btn-primary whyBtn listBtn"
						id="goList" style="margin: 0px 0px 20px 10px;">목록</button>
					<c:if test="${sessionScope.userId eq leagueboard.userId}">
						<button type="submit" class="btn btn-primary goBtn updateBtn" 
						style="margin: 0px 0px 20px 10px;">수정</button>
					</c:if>
					<c:if
						test="${sessionScope.userId eq leagueboard.userId or sessionScope.isAdmin eq true}">
						<button type="button" class="btn btn-primary goBtn delbtn">삭제</button>
					</c:if>
					<c:if
						test="${sessionScope.userId != leagueboard.userId and not empty sessionScope.userId}">
						<button type="button" id="userblock" style="margin: 0px 0px 20px 10px;">게시자차단</button>
					</c:if>
				</div>
			</div>
		</section>
	</main>

	<%@ include file="/WEB-INF/views/include/footer.jsp"%>

	<script type="text/javascript">
	
		document.addEventListener("DOMContentLoaded", function () {
		    // 삭제 버튼 클릭 이벤트를 처리합니다.
		    document.querySelector(".delbtn").addEventListener("click", function (e) {
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
		
		//글수정
		$('.updateBtn').click(function() {
			location.href = "<c:url value='/LeagueBoard/update/${leagueboard.leagueboardId}'/>";
		})
		
		//목록
		$('#goList').click(function(){
			location.href = "/LeagueBoard";
		})
		
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
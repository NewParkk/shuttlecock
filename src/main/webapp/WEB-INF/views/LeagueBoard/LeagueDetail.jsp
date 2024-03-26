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
<!-- aisde-js 파일 -->
<script src="/js/aside-js.js"></script>
<link rel="stylesheet" href="/css/free.css">
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<style>
.contents {
	width: 80%;
}

.post-metadata1 {
	border: 1px solid #ccc;
	padding: 10px;
	box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
}
</style>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<!-- main -->
	<main id="main">
		<div id="slider">
			<div class="imageWrap1"></div>
		</div>

		<!-- section -->
		<section id="contents">

			<%@ include file="category.jsp"%>

			<div class="noticeboard">
				<div class="title" style="margin: 0px;">
					<div class="vline"></div>
					<div class="container2">
						<h3>리그게시판 &#10095</h3>
					</div>
				</div>

				<!-- main  -->
				<div class="post-info">
					<p class="post-title">
						<strong>${leagueboard.title}</strong>
					</p>
					<p class="post-metadata">
						<span class="post-info-text">작성자: <img
							src="/badge/${badgeName}.jpg" style="height: 15px; width: 15px;">
							<strong>${leagueboard.userId}</strong>
						</span>
					</p>
					<!-- <span class="post-info-text"> <strong>작성 시간:</strong>
						</span> -->
					<p style="font-size: 14px; color: gray;">
						<span> <fmt:formatDate value="${leagueboard.regdate}"
								pattern="yyyy-MM-dd HH:mm" /> <span class="post-metadata1"
							style="font-size: 16px; float: right; margin-top: -40px; color: #333; text-align: left;">
								<span class="post-info-text"> <strong>승자:</strong> <c:if
										test="${not empty leagueboard.winners}">
								${leagueboard.winners} 
						</c:if> <c:if test="${not empty leagueboard.winner}">
							${leagueboard.winner}
						</c:if>
							</span> <br> <span class="post-info-text"
								style="font-size: 16px; float: right;"> <strong>패자:</strong>
									<c:if test="${not empty leagueboard.losers}">
							${leagueboard.losers}
						</c:if> <c:if test="${not empty leagueboard.loser}">
							${leagueboard.loser}
						</c:if>
							</span>
						</span>
						</span>
					</p>

					<div class="line"></div>
					<div class="post-content" id="post-content">${leagueboard.content}</div>
					<div class="line"></div>
				</div>
					
					<div class="post-buttons">
						<button type="button" class="btn btn-primary whyBtn listBtn"
							id="goList" style="margin: 0px 30px 20px 10px;">목록</button>
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
							<button type="button" id="userblock"
								style="margin: 0px 0px 20px 10px;">게시자차단</button>
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
	    			window.location.href = "/LeagueBoard";
	    		} // success
	    	}) // ajax
	    }) //버튼 클릭
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Shuttle Cock</title>
<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>

<style>
.noticeboard {
	width: 100%;
}

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
</style>
<body>
	<!-- 헤더 -->
	<%@ include file="../include/header.jsp"%>

	<!-- main -->
	<main id="boardmain">


		<section id="contents">
			<!-- aside -->
			<div class="aside">
				<div class="menubar">
					<ul>
						<li><a href="/Freeboard/freeList">자유게시판</a></li>
						<li><a href="#">물품거래소</a></li>
						<li><a href="#">운동장소찾기</a></li>
					</ul>
				</div>
			</div>
			<div class="noticeboard">
				<div class="page-title">
					<div class="vline"></div>
					<div class="container2">
						<h3>자유 게시판</h3>
					</div>
				</div>

				<div class="mb-3" style="width: 70%; margin: 0 auto;">
					<label for="exampleFormControlInput1" class="form-label">제목</label>
					<input type="text" class="form-control"
						id="exampleFormControlInput1" value="${Detail.title}" readonly>
				</div>
				<div class="row g-3" style="width: 70%; margin: 0 auto;">
					<div class="col">
						<label for="exampleFormControlInput1" class="form-label">작성자</label>
						<input type="text" class="form-control"
							id="exampleFormControlInput1" value="${Detail.userId}" readonly>
					</div>
					<div class="col">
						<label for="exampleFormControlInput1" class="form-label">작성
							시간</label> <input type="text" class="form-control"
							id="exampleFormControlInput1" value="${Detail.regdate}" readonly>
					</div>
				</div>
				<div class="row g-3" style="width: 70%; margin: 0 auto;">
					<div class="col">
						<label for="exampleFormControlInput1" class="form-label">조회</label>
						<input type="text" class="form-control"
							id="exampleFormControlInput1" value="${Detail.hit}" readonly>
					</div>
					<div class="col">
						<label for="exampleFormControlInput1" class="form-label">추천</label>
						<input type="text" class="form-control"
							id="exampleFormControlInput1" value="${Detail.like}" readonly>
					</div>
				</div>
				&nbsp;&nbsp;
				<div class="mb-3" style="width: 70%; margin: 0 auto;">
					<label for="exampleFormControlTextarea1" class="form-label"></label>
					<div>${Detail.content}</div>
					<!-- 첨부된 이미지를 표시할 섹션을 추가합니다 -->
					<c:if test="${not empty Detail.uploadPath}">
						<div class="image-gallery">
							<h4>첨부된 이미지</h4>
							<img src="${Detail.uploadPath}" alt="첨부된 이미지">
						</div>
					</c:if>
				</div>


				<button type="button" class="btn btn-primary whyBtn listBtn">목록</button>
				<c:if test="${sessionScope.userId eq Detail.userId}">
					<button type="submit" class="btn btn-primary CancleBtn updateBtn">수정</button>
				</c:if>
				<c:if
					test="${sessionScope.userId eq Detail.userId or sessionScope.isAdmin eq true}">
					<button type="button" class="btn btn-primary CancleBtn delbtn">삭제</button>
				</c:if>
				<button type="button" class="btn btn-primary CancleBtn LikeBtn"
					id="LikeBtn">추천 ${Detail.like}</button>
				<c:if
					test="${sessionScope.userId != Detail.userId and not empty sessionScope.userId}">
					<button type="button" id="userblock" style="margin-top: 30px;">게시자차단</button>
				</c:if>




				&nbsp;&nbsp;
				<!-- 댓글 -->

				<c:if test="${not empty sessionScope.userId}">
					<div class="mb-3" style="width: 50%; margin: 0 auto;">
						<label for="exampleFormControlInput1" class="form-label">댓글
							작성자</label> <input type="text" class="form-control writerId"
							id="exampleFormControlInput1" name="writerId"
							value="${sessionScope.userId}" readonly>
					</div>
					<div class="mb-3" style="width: 50%; margin: 0 auto;">
						<label for="exampleFormControlTextarea1" class="form-label">댓글
							내용</label>
						<textarea class="form-control content"
							id="exampleFormControlTextarea1" rows="2" name="content"></textarea>
					</div>
					<div class="mb-3" style="width: 50%; margin: 0 auto;">
						<input type="checkbox" id="secret" name="secret" value="1">비밀댓글
					</div>
					<button type="button" class="btn btn-primary whyBtn1" id="com_btn">댓글
						등록</button>
				</c:if>

				<!-- 댓글이 들어갈 부분 -->
				<div class="com_box">
					<c:if test="${not empty commentList}">
						<c:forEach items="${commentList}" var="comment">
							<div class="row g-3"
								style="width: 51%; margin: 0 auto; margin-top: -25px">
								<div class="col">
									<label for="exampleFormControlInput1" class="form-label">작성자</label>
									<input type="text" class="form-control"
										id="exampleFormControlInput1" value="${comment.userId}"
										readonly>
								</div>
								<div class="col">
									<label for="exampleFormControlInput1" class="form-label">작성시간</label>
									<input type="text" class="form-control com-date"
										id="exampleFormControlInput2" value="${comment.regdate}"
										readonly>
								</div>
							</div>
							<div class="mb-3" style="width: 50%; margin: 0 auto;">
								<label for="exampleFormControlTextarea1" class="form-label">댓글
									내용</label>
								<c:choose>
									<c:when
										test="${comment.secret eq 0 or sessionScope.userId eq Detail.userId or 
						comment.userId eq sessionScope.userId or sessionScope.isAdmin eq true}">
										<textarea class="form-control content"
											id="exampleFormControlTextarea1" rows="2" name="content"
											readonly>${comment.content}</textarea>
									</c:when>
									<c:when test="${comment.secret eq 1}">
										<textarea class="form-control content"
											id="exampleFormControlTextarea1" rows="2" name="content"
											readonly>비밀댓글입니다.</textarea>
									</c:when>
								</c:choose>
							</div>
							<c:if
								test="${sessionScope.userId eq comment.userId or sessionScope.isAdmin eq true}">
								<button type="button"
									class="btn btn-primary whyBtn1 com_delete_btn"
									id="com_delete_btn" value="${comment.commentsId}">댓글삭제</button>
							</c:if>
							<c:if test="${sessionScope.userId eq comment.userId}">
								<button type="button"
									class="btn btn-primary whyBtn1 com_update_btn"
									id="com_update_btn" data-toggle="modal"
									data-target="#editPostModal_${comment.commentsId}">댓글수정</button>
							</c:if>

							<!-- 댓글 수정 모달 -->
							<div class="modal fade" id="editPostModal_${comment.commentsId}"
								tabindex="-1" role="dialog" aria-labelledby="editPostModalLabel"
								aria-hidden="true" style="display: none;">
								<div class="modal-dialog modal-lg" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="editPostModalLabel">댓글 수정</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<form action="/comments/update" id="editPostForm"
												method="post" enctype="multipart/form-data"
												onsubmit="return validatePostForm()">
												<input type="hidden" class="form-control mb-2" name="userId"
													value="${comment.userId}"> <input type="hidden"
													class="form-control mb-2" name="commentsId"
													value="${comment.commentsId}"> <input type="hidden"
													class="form-control mb-2" name="bno" value="${comment.bno}">
												<input type="hidden" class="form-control mb-2"
													name="comment_type" value="${comment.comment_type}">
												<textarea class="form-control" style="height: 100px"
													name="content">${comment.content}</textarea>
												<div style="display: flex; align-items: center;">
													<div style="margin-right: auto;">
														<input type="radio" id="secret" name="secret" value="1"
															style="margin-left: 10px;">비밀댓글
													</div>
													<button type="submit" class="btn btn-primary mt-2"
														style="margin-left: auto;">저장</button>
												</div>
											</form>
										</div>

									</div>
								</div>
							</div>
						</c:forEach>
					</c:if>
				</div>


			</div>
		</section>



	</main>

	<!-- 푸터 -->
	<%@include file="../include/footer.jsp"%>
</body>

<script>
	//RedirectAttributes 로 던져서 메시지 출력
	const msg = '${msg}';
	if (msg !== '') {
		alert("게시물 수정 완료되었습니다.");
	}
	
	//모달 열기
	function validatePostForm() 
	{
		//var titleField = document.querySelector('#editPostForm input[name="title"]');
		var contentField = document.querySelector('.modal textarea[name="content"]');
		if (contentField.value.trim() === '') {
		    alert('내용을 입력하세요.');
		    return false;
		}
	return true;
	 }
	$(document).ready(function() {
		$('.com_update_btn').click(function() {
		    const modalId = $(this).data('target'); // data-target 속성이 각 버튼에 설정되어 있다고 가정
		    console.log(modalId);
		    $(`${modalId}`).modal('show');
		});
	});

	// regdate 값을 포맷팅하여 input 태그에 적용
	var regdate = "${Detail.regdate}";
	/* var formattedDate = new Date(regdate).toLocaleString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit'}); // 날짜 포맷팅
	document.getElementById("exampleFormControlInput2").value = formattedDate; */

	$(function() { // 스크립트 시작문

		// 글수정
		$('.updateBtn')
				.click(
						function() {
							location.href = "<c:url value='/Freeboard/freeUpdate?freeboardId=${Detail.freeboardId}'/>";
						})
		// 삭제
		$('.delbtn')
				.click(
						function() {
							if (!confirm("해당 게시물을 삭제 하시겠습니까?")) {
								return;
							} else {
								location.href = "<c:url value='/Freeboard/deleteFree?freeboardId=${Detail.freeboardId}'/>";
							}
						})

		// 좋아요 
		$('.LikeBtn').click(function(){
			if(${empty sessionScope.userId}){
				if(confirm("로그인이 필요한 작업입니다. 로그인 페이지로 이동하시겠습니까?")){
					location.href = "/login";
				}
			} else{
				$.ajax({
					type : "POST",
					url : "/likes",
					data : {
						"userId" : "${sessionScope.userId}",
						"bno" : ${Detail.freeboardId},
						"likes_type" : 2
					},
					success : function(data){
						location.reload();
					}
				}) // ajax
			} // 세션 있을떄
		}) // 추천 버튼 클릭

		$('.listBtn').click(function() {
			location.href = '<c:url value="/Freeboard/freeList"/>';
		})
		
		
		document.addEventListener("DOMContentLoaded", function () {
		    // 삭제 버튼 클릭 이벤트를 처리합니다.
		    document.querySelector(".delbtn").addEventListener("click", function (e) {
		    	e.preventDefault();
		    	
		    	// 알림을 통해 사용자에게 삭제 여부를 확인할 수 있습니다.
		        var isConfirmed = confirm("게시글을 삭제하시겠습니까?");

		        if (isConfirmed) {
		            // 액시오스를 사용하여 서버로 DELETE 요청을 보냅니다.
		            axios.delete('/Freeboard/${Detail.freeboardId}')
		            .then(function (response) {
		            	//ResponseEntity.ok 보내주면
		                console.log(response.data);
		                alert("게시글이 삭제되었습니다.");
		                window.location.href = "/Freeboard/freeList";
		            })
		            .catch(function (error) {
		                // 아닐시
		                console.error('Error during board deletion:', error);
		                alert("게시글 삭제 실패");
		            });
		        }
		    });
		});
		
		// 댓글
		$('#com_btn').click(function() {
			const writerId = $('.writerId').val();
			const content = $('.content').val();
			const freeboardId = ${Detail.freeboardId};
			const comment_type = 2; 
			const secret = $('#secret').is(':checked') ? 1 : 0;
			console.log(secret);
			if(writerId == ''){
				alert('아이디를 입력해주세요');
				return;
			}else if(content == ''){
				alert('내용을 입력해주세요');
				return;
			}else{
				$.ajax({
					type : 'post',
					url: '<c:url value="/comments/insert"/>',
					data : {
							"userId" : writerId,
							"content" : content,
							"bno" : freeboardId,
							"comment_type" : comment_type,
							"secret" : secret
						},
					success: function(data) {
						alert("댓글 등록 성공");
						location.reload();
					},	error : function(status, error) {
						console.log('에러발생!!');
						console.log(status, error);
					}
				});//아작스 끝
			} //  else 문 끝
		})// 댓글 등록 끝
		
		// 댓글 수정
		
		
		// 댓글 삭제
		document.addEventListener("DOMContentLoaded", function () {
		    // 삭제 버튼 클릭 이벤트를 처리합니다.
		    const deleteButtons = document.querySelectorAll(".com_delete_btn");
		    deleteButtons.forEach(function(button) {
		        button.addEventListener("click", function (e) {
		            e.preventDefault();
		            
		            // 알림을 통해 사용자에게 삭제 여부를 확인할 수 있습니다.
		            var isConfirmed = confirm("댓글을 삭제하시겠습니까?");
		            const commentsId = $(this).val();
		            const data = {
		            	    "commentsId" : commentsId
		            	};

		            if (isConfirmed) {
		                // 액시오스를 사용하여 서버로 DELETE 요청을 보냅니다.
		                console.log(commentsId);
		                axios.delete('/comments/' + commentsId)
		                .then(function (response) {
		                    //ResponseEntity.ok 보내주면
		                    console.log(response.data);
		                    alert("댓글이 삭제되었습니다.");
		                    location.reload();
		                })
		                .catch(function (error) {
		                    // 아닐시
		                    console.error('Error during board deletion:', error);
		                    alert("댓글 삭제 실패");
		                });
		            }
		        });
		    });
		});
		
		$('#userblock').click(function(){
	    	$.ajax({
	    		type :"POST",
	    		url : "/blockuser",
	    		data : {
	    			"userId" : "${sessionScope.userId}",
	    			"blockedUser" : "${Detail.userId}"
	    		},
	    		success : function(data){
	    			alert(data);
	    			location.reload();
	    		} // success
	    	}) // ajax
	    }) //버튼 클릭
	});

</script>
</html>
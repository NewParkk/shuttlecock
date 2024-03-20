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
<link rel="stylesheet" href="/css/free.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<style>
.contents {
	width: 80%;
}
</style>
</head>

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
						<li><a class="list" href="/Freeboard/freeList">자유게시판</a></li>
						<li><a class="list" href="/Tradeboard">물품거래소</a></li>
					</ul>
				</div>
			</div>
			<div class="noticeboard">
				<div class="title" style="">
					<div class="vline"></div>
					<div class="container2">
						<h3>자유 게시판</h3>
					</div>
				</div>


				<div class="post-info">
					<p class="post-title">
						<strong>${freeboard.title}</strong>
					</p>
					<p class="post-metadata">
						<span class="post-info-text"> <strong>작성자:</strong>
							${freeboard.userId}
						</span> <span class="post-info-text"> <strong>작성 시간:</strong>
							<fmt:formatDate value="${freeboard.regdate}" pattern="yyyy-MM-dd HH:mm"/><%-- ${freeboard.regdate} --%>
						</span> <span class="post-info-text"> <strong>조회:</strong>
							${freeboard.hit} / <strong>추천:</strong> ${freeboard.like}
						</span>
					</p>
				</div>


				<!-- 게시물 내용 표시 -->
				<div class="post-content" id="post-content">${freeboard.content}</div>
				<!-- 첨부파일 표시 -->
				<c:if test="${freeboard.imageName != 'noImage'}">
					<div class="image-container"
						style="width: 200px; height: 200px; object-fit: cover;">
						<img
							src="https://kr.object.ncloudstorage.com/team1bucket/boardFile/2_${freeboard.imageName}.png"><br>
					</div>
				</c:if>

				<!-- 버튼들 -->
				<div class="post-buttons">
					<button type="button" class="btn btn-primary listBtn">목록</button>
					<c:if test="${sessionScope.userId eq freeboard.userId}">
						<button type="submit" class="btn btn-primary goBtn updateBtn">수정</button>
					</c:if>
					<c:if
						test="${sessionScope.userId eq freeboard.userId or sessionScope.isAdmin eq true}">
						<button type="button" class="btn btn-primary goBtn delbtn">삭제</button>
					</c:if>
					<c:if test="${sessionScope.userId ne freeboard.userId}">
						<button type="button" class="btn btn-primary goBtn LikeBtn"
							id="LikeBtn">추천 ${freeboard.like}</button>
					</c:if>
					<c:if
						test="${sessionScope.userId ne freeboard.userId and not empty sessionScope.userId}">
						<button type="button" class="btn btn-primary goBtn" id="userblock">게시자차단</button>
					</c:if>
				</div>



				&nbsp;&nbsp;

				<!-- 댓글 부분 -->
				<div class="comment-section">
					<!-- 댓글 작성 폼 -->
					<c:if test="${not empty sessionScope.userId}">
						<div class="comment-form">
							<h3>댓글</h3>
							<form id="commentForm">
								<div class="form-group">
									<span class="post-info-text com-writer"> <strong>${sessionScope.userId}</strong></span> 
								</div>
								<div class="form-group">
									<textarea class="form-control content"
										id="exampleFormControlTextarea1" rows="2" name="content" placeholder="의견을 남겨주세요"></textarea>
								</div>
								<div class="form-check">
									<input type="checkbox" id="secret" name="secret" value="1">비밀댓글
								</div>
								<button type="submit" class="comment-submit-button com-btn" id="com_btn">댓글
									등록</button>
							</form>
						</div>
					</c:if>


					<!-- 댓글 리스트 -->
                    <div class="comment-box">
                        <c:if test="${not empty commentList}">
                            <c:forEach items="${commentList}" var="comments">
                                <div class="row">
                                    <div class="col">
                                        <span class="post-info-text com-writer"> <strong>${sessionScope.userId}</strong></span> 
                                    </div>
                                    <div class="col">
                                        <span class="post-info-text com-date">${comments.regdate}</span>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div id="com_updateMode_div_${comments.commentsId}">
                                            <c:choose>
                                                <c:when test="${empty sessionScope.userId or sessionScope.userId ne comments.userId}">
                                                    <c:choose>
                                                        <c:when test="${comments.secret == 1}">
                                                            <span class="secret-comment">비밀 댓글입니다</span>
                                                        </c:when>
                                                        <c:otherwise>${comments.content}</c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>${comments.content}</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <textarea class="form-control com_updateMode_textarea" id="exampleFormControlTextarea1_${comments.commentsId}" rows="2" style="display: none;">${comments.content}</textarea>
                                        
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input secret" id="secret_${comments.commentsId}" name="secret" value="1" ${comments.secret == 1 ? 'checked' : ''}>
                                            <label class="form-check-label" for="secret_${comments.commentsId}">비밀댓글</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <c:if test="${sessionScope.userId eq comments.userId}">
                                            <button type="button" class="btn btn-primary com_update_btn" id="com_update_btn_${comments.commentsId}" data-toggle="modal" data-target="#editPostModal_${comments.commentsId}">댓글 수정</button>
                                            <input type="checkbox" id="secretcom" name="secretcom" value="1" style="display: none;"> 
											<label for="secretcom" style="display: none;">비밀댓글</label>
                                            <button type="button" class="btn btn-primary com_save_btn" id="com_save_btn_${comments.commentsId}" style="display: none;">저장</button>
                                        </c:if>
                                        <c:if test="${sessionScope.userId eq comments.userId or sessionScope.isAdmin eq true}">
                                            <button type="button" class="btn btn-primary com_delete_btn" id="com_delete_btn_${comments.commentsId}" value="${comments.commentsId}">댓글 삭제</button>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>
				</div>
			</div>
		</section>



	</main>

	<!-- 푸터 -->
	<footer>
		<div class="container">
			<%@include file="../include/footer.jsp"%>
		</div>
	</footer>


</body>

<script>
$(document).ready(function() {
    // 댓글 수정 버튼 클릭 시 수정 모드로 변경
    $('.com_update_btn').click(function() {
        const commentId = $(this).attr('id').split('_')[3];
        // 해당 댓글의 내용을 textarea에 표시하고 수정 모드로 전환
        $('#com_updateMode_div_' + commentId).hide();
        $('#exampleFormControlTextarea1_' + commentId).show();
        $(this).hide();
        $('#com_save_btn_' + commentId).show();
        // 비밀 댓글 체크박스 표시
        $('#secretcom_' + commentId).show();
    });

    // 저장 버튼 클릭 시 댓글을 업데이트
    $('.com_save_btn').click(function() {
        const commentId = $(this).attr('id').split('_')[3];
        const content = $('#exampleFormControlTextarea1_' + commentId).val().trim();
        const secret = $('#secret_' + commentId).is(':checked') ? 1 : 0;

        // AJAX를 통해 서버로 댓글 업데이트 요청을 전송
        $.ajax({
            type: 'POST',
            url: '/comments/update',
            data: {
                'commentsId': commentId,
                'content': content,
                'secret': secret
            },
            success: function(data) {
                // 성공적으로 업데이트되면 해당 댓글의 내용을 업데이트
                $('#com_updateMode_div_' + commentId).text(content);
                $('#com_updateMode_div_' + commentId).show();

                // textarea와 저장 버튼을 숨깁니다.
                $('#exampleFormControlTextarea1_' + commentId).hide();
                $('#com_save_btn_' + commentId).hide();
                // 댓글 수정 버튼을 다시 표시합니다.
                $('#com_update_btn_' + commentId).show();

                alert("댓글이 수정되었습니다.");
                // 필요한 경우 페이지를 새로 고침할 수 있습니다.
                // location.reload();
            },
            error: function(xhr, status, error) {
                console.error('댓글 업데이트 중 에러 발생:', error);
                alert('댓글 업데이트 실패');
            }
        });
    });
});


	
	
	// regdate 값을 포맷팅하여 input 태그에 적용
	var regdate = "${Detail.regdate}";
	/* var formattedDate = new Date(regdate).toLocaleString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit'}); // 날짜 포맷팅
	document.getElementById("exampleFormControlInput2").value = formattedDate; */


	
		// 글수정
		$('.updateBtn')
				.click(
						function() {
							location.href = "<c:url value='/Freeboard/update/${freeboard.freeboardId}'/>";
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
						"bno" : ${freeboard.freeboardId},
						"likesType" : 2
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
		            axios.delete('/Freeboard/freeDelete/' + ${freeboard.freeboardId})
		            .then(function (response) {
		                console.log(response.data);
		                alert("게시글이 삭제되었습니다.");
		             // 게시글 목록 페이지로 이동합니다.
		                window.location.href = '/Freeboard/freeList';
		            })
		            .catch(function (error) {
		                console.error('Error during board deletion:', error);
		                alert("게시글 삭제 실패");
		            });
		        }
		    });
		});
		
		// 댓글
		$('#com_btn').click(function() {
			const userId = $('.userId').val();
			const content = $('.content').val();
			const freeboardId = ${freeboard.freeboardId};
			const commentType = 2; 
			const secret = $('#secret').is(':checked') ? 1 : 0;
			console.log(secret);
			if(userId == ''){
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
							"userId" : userId,
							"content" : content,
							"bno" : freeboardId,
							"commentType" : commentType,
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
		                axios.delete('/comments/'+commentsId)
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
	    			"blockedUser" : "${freeboard.userId}"
	    		},
	    		success : function(data){
	    			alert(data);
	    			location.href = "/Freeboard/freeList";
	    			//location.reload();
	    		} // success
	    	}) // ajax
	    }) //버튼 클릭

</script>
</html>
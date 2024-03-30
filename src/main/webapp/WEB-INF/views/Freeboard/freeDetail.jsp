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
<!-- aisde-js 파일 -->
<script src="/js/aside-js.js"></script>
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
	<main id="main">
		<div id="slider">
			<div class="imageWrap1"></div>
		</div>

		<!-- section -->
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

			<!-- noticeboard -->
			<div class="noticeboard">
				<div class="title" style="margin: 0px;">
					<div class="vline"></div>
					<div class="container2">
						<h3>자유 게시판 &#10095</h3>
					</div>
				</div>

				<div class="post-info">
					<p class="post-title">
						<strong>${freeboard.title}</strong>
					</p>
					<p class="post-metadata" style="margin-bottom: 3px;">
						<span class="post-info-text"> 작성자: <img
							src="/badge/${badgeName}.jpg" style="height: 15px; width: 15px;">
							<c:choose>
								<c:when
									test="${sessionScope.userId eq freeboard.userId or sessionScope.isAdmin eq true or empty sessionScope.userId}">
									<strong>${freeboard.userId}</strong>
								</c:when>
								<c:otherwise>
									<strong class="UserBtn">${freeboard.userId}</strong>
									<!-- 토글 창 -->
									<span id="block_actions" style="display: none;">
										<button class="userblock" id="userblock_${freeboard.userId}" value="${freeboard.userId}">게시자 차단</button>
									</span>
								</c:otherwise>
							</c:choose>
						</span>
					</p>
					<!-- <span class="post-info-text"> <strong>작성 시간:</strong> -->
					<!-- </span>  -->
					<p style="font-size: 14px; color: gray;">
						<fmt:formatDate value="${freeboard.regdate}"
							pattern="yyyy-MM-dd HH:mm" />
						<span class="post-info-text" style="margin-left: 10px;">조회&nbsp;${freeboard.hit}
							<strong style="font-size: 20px; float: right;">&#128077;${freeboard.like}</strong>
						</span>
					</p>

					<div class="line"></div>

					<!-- 게시물 내용 표시 -->
					<div class="post-content" id="post-content">${freeboard.content}</div>
					<!-- 첨부파일 표시 -->
					<c:choose>
						<c:when test="${freeboard.imageName != 'noImage'}">
							<div class="image-container"
								style="width: 200px; height: 200px; object-fit: cover;">
								<img
									src="https://kr.object.ncloudstorage.com/team1bucket/boardFile/2_${freeboard.imageName}.png"><br>
							</div>
						</c:when>
						<c:otherwise>
							<!-- 이미지가 없을 때는 아무것도 표시하지 않음 -->
							<h1></h1>
						</c:otherwise>
					</c:choose>
					<div class="line"></div>
				</div>


				<!-- 버튼들 -->
				<div class="post-buttons">
					<button type="button" class="btn btn-primary listBtn"
						style="margin-right: 30px;">목록</button>
					<c:if test="${sessionScope.userId eq freeboard.userId}">
						<button type="submit" class="btn btn-primary goBtn updateBtn">수정</button>
					</c:if>
					<c:if
						test="${sessionScope.userId eq freeboard.userId or sessionScope.isAdmin eq true}">
						<button type="button" class="btn btn-primary goBtn delbtn">삭제</button>
					</c:if>

					<c:if test="${sessionScope.userId ne freeboard.userId}">
						<c:choose>
							<c:when test="${isLiked}">
								<button type="button" class="btn btn-primary goBtn LikeBtn"
									id="LikeBtn" style="float: left; margin-left: 30px;">&#128078;
									추천 안 함</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-primary goBtn LikeBtn"
									id="LikeBtn" style="float: left; margin-left: 30px;">&#128077;
									추천</button>
							</c:otherwise>
						</c:choose>

						</button>
					</c:if>


					<%-- <c:if
						test="${sessionScope.userId ne freeboard.userId and not empty sessionScope.userId}">
						<button type="button" class="btn btn-primary goBtn" id="userblock">게시자차단</button>
					</c:if> --%>
				</div>


				&nbsp;&nbsp;

				<!-- 댓글 부분 -->
				<div class="comment-section">
					<div class="comment-box">
						<c:if test="${not empty commentList}">
							<div class="comment-form">
								<h3>댓글</h3>
							</div>
							<c:forEach items="${commentList}" var="comments">
								<div class="row">
									<div class="col" style="margin-bottom: 15px;">
										<span class="post-info-text com-writer"> <img
											src="/badge/${comments.badgeName}.jpg"
											style="height: 15px; width: 15px;"> <c:choose>
												<c:when
													test="${freeboard.userId eq comments.userId}">
													<strong style="color: green;">작성자</strong>
												</c:when>
												<c:when
													test="${sessionScope.userId eq comments.userId or sessionScope.isAdmin eq true }">
													<strong style="color: blue;">${comments.userId}</strong>
												</c:when>												
												<c:otherwise>
													<strong>${comments.userId} </strong>
												</c:otherwise>
											</c:choose>
										</span>
									</div>
									<div id="block_actions_${loop.index}" style="display: none;">
										<button class="blockBtn"
											data-comments-id="${comments.commentsId}">차단하기</button>
									</div>

									<div class="col">
										<div id="com_updateMode_div_${comments.commentsId}">
											<c:choose>
												<c:when
													test="${comments.secret eq 0 or sessionScope.userId eq freeboard.userId or 
												comments.userId eq sessionScope.userId or sessionScope.isAdmin eq true}">
													${comments.content}
												</c:when>
												<c:when test="${comments.secret eq 1}">
													<span class="secret-comment">비밀 댓글입니다</span>
												</c:when>
											</c:choose>
										</div>
										<textarea class="form-control com_updateMode_textarea"
											id="exampleFormControlTextarea1_${comments.commentsId}"
											rows="2" style="display: none;">${comments.content}</textarea>
										<div class="col">
											<span class="post-info-text com-date"
												style="font-size: 12px; color: gray;"> <fmt:formatDate
													value="${comments.regdate}" pattern="yyyy-MM-dd HH:mm" />
											</span> <span class="col" style="float: right;"> <c:if
													test="${sessionScope.userId eq comments.userId}">
													<button type="button"
														class="btn btn-primary com_update_btn"
														id="com_update_btn_${comments.commentsId}"
														data-toggle="modal"
														data-target="#editPostModal_${comments.commentsId}">댓글
														수정</button>
													<button type="button" class="btn btn-primary com_save_btn"
														id="com_save_btn_${comments.commentsId}"
														style="display: none;">저장</button>
												</c:if> <c:if
													test="${sessionScope.userId eq comments.userId or sessionScope.isAdmin eq true}">
													<button type="button"
														class="btn btn-primary com_delete_btn"
														id="com_delete_btn_${comments.commentsId}"
														value="${comments.commentsId}">댓글 삭제</button>
												</c:if> <c:if
												test="${sessionScope.userId ne comments.userId and not empty sessionScope.userId}">
												<button type="button"
														class="btn btn-primary userblock"
														id="userblock_${comments.userId}"
														value="${comments.userId}">유저 차단</button>
												</c:if>
											</span>
										</div>
										<div id="secret-div_${comments.commentsId}" class="form-check"
											style="display: none;">
											<input type="checkbox" class="form-check-input secret"
												id="secret_${comments.commentsId}" name="secret" value="1"
												${comments.secret == 1 ? 'checked' : ''}> <label
												class="form-check-label" for="secret_${comments.commentsId}">비밀댓글</label>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:if>
					</div>


					<!-- 댓글 작성 폼 -->
					<c:if test="${not empty sessionScope.userId}">
						<form id="commentForm">
							<div class="comment-container">
								<div class="form-group">
									<div class="post-info-text com-writer"
										style="margin-left: 7px;">
										<img
											src="https://kr.object.ncloudstorage.com/team1bucket/badge/${sessionScope.badgeId}.png"
											width="15px" height="15px"> <strong>${sessionScope.userId}</strong>
									</div>
									<textarea class="form-control content comment-textarea"
										id="exampleFormControlTextarea1" rows="2" name="content"
										placeholder="댓글을 남겨보세요"></textarea>
									<div class="rowcheck"
										style="display: flex; justify-content: space-between;">
										<div class="form-check"
											style="display: flex; align-items: center; margin-left: 10px;">
											<input type="checkbox" id="secret" name="secret" value="1">비밀댓글
										</div>
										<button type="submit" class="comment-submit-button com-btn"
											id="com_btn">댓글등록</button>
									</div>
								</div>
							</div>
						</form>
					</c:if>
				</div>
			</div>
			<!-- //noticeboard -->

		</section>
		<!-- //section -->
	</main>
	<!-- //main -->

	<!-- footer -->
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
    	const modalId = $(this).data('target'); // data-target 속성이 각 버튼에 설정되어 있다고 가정
	    const chars = modalId.split('_');
        const commentId = chars[1];
        // 해당 댓글의 내용을 textarea에 표시하고 수정 모드로 전환
        $('#com_updateMode_div_' + commentId).hide();
        $('#exampleFormControlTextarea1_' + commentId).show();
        $('#secret-div_' + commentId).show();
        $(this).hide();
        $('#com_save_btn_' + commentId).show();
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
                $('#secret-div_' + commentId).hide();
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
	
	    $('.UserBtn').click(function() {
	        $('#block_actions').toggle();
	    });

		// 글수정
		$('.updateBtn').click(function() {
			location.href = "<c:url value='/Freeboard/update/${freeboard.freeboardId}'/>";
		})
		
		// 추천				
	    $('.LikeBtn').click(function() {
	            // 클릭한 버튼의 텍스트에 따라 추천 상태를 업데이트
	            var isLiked = $(this).text().includes("추천 안 함");

	            
	            if(${empty sessionScope.userId}){
					if(confirm("로그인이 필요한 작업입니다. 로그인 페이지로 이동하시겠습니까?")){
						location.href = "/login";
					}
				} else{
					$.ajax({
		                type: "POST",
		                url: "/likes",
		                data: {
		                    "userId": "${sessionScope.userId}",
		                    "bno": ${freeboard.freeboardId},
		                    "likesType": 2
		                },
		                success: function(data) {
		                    // 버튼의 텍스트 변경
		                    if (isLiked) {
		                        $(this).html("&#128077; 추천");
		                        location.reload();
		                    } else {
		                        $(this).html("&#128078; 추천 안 함");
		                        location.reload();
		                    }
		                }
		            });
				}
	        });
		
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
		
		// 유저 차단 버튼 클릭 시 처리
		$('.userblock').click(function() {
		    // 차단할 사용자의 아이디를 가져옵니다.
		    const blockedUserId = $(this).val();

		    // AJAX를 통해 서버로 차단 요청을 전송합니다.
		    $.ajax({
		        type: 'POST',
		        url: '/blockuser', // 차단 요청을 처리할 서버의 URL
		        data: {
		            'userId': '${sessionScope.userId}', // 현재 사용자의 아이디
		            'blockedUser': blockedUserId // 차단할 사용자의 아이디
		        },
		        success: function(data) {
		            // 차단 요청이 성공하면 알림을 표시하고 페이지를 새로 고침합니다.
		            alert(data);
		            window.location.href = '/Freeboard/freeList';
		            //location.reload();
		        },
		        error: function(xhr, status, error) {
		            // 차단 요청이 실패하면 에러를 콘솔에 표시합니다.
		            console.error('차단 요청 중 에러 발생:', error);
		        }
		    });
		});

	    
	    /* aside가 (/Freeboard/freeList)url이 같은 페이지로 인식되도록 작성함 */
	    var currentPageUrl = "/Freeboard/freeList"; 
	    var menuItems = document.querySelectorAll('.menubar .list');
	    menuItems.forEach(function(item) {
	        if (item.getAttribute('href') === currentPageUrl) {
	            item.classList.add('active');
	        }
	    });
	    
	    /* input입력 시 테두리 색 변경 */
	    document.querySelector('.comment-textarea').addEventListener('input', function() {
	        var container = document.querySelector('.comment-container');
	        if (this.value.trim().length > 0) {
	            container.classList.add('has-text'); 
	        } else {
	            container.classList.remove('has-text'); 
	        }
	    });

</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래게시판</title>
<link rel="stylesheet" href="/css/mainstyle.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>

<style>
.mainTitle {
	text-align: center;
}

.whyBtn {
	margin-left: 60%;
}

.whyBtn1 {
	margin-left: 69%;
}

.del-btn {
	margin-left: 95%
}

h1 {
	padding-top: 30px;
	padding-bottom: 30px
}
</style>
<body>
	<spring:eval
		expression="@environment.getProperty('NCP.STORAGE.APIURL')"
		var="imgUrl" />
	<!-- 헤더 -->
	<%@ include file="../include/header.jsp"%>

	<!-- 붙혀 넣는곳 -->
	<div class="mainTitle">
		<h1>모집게시판</h1>
	</div>
	<form action="/Recruitboard/update/${recruitboardId}" method="GET"
		name="detailForm" id="detailForm">
		<div class="mb-3" style="width: 70%; margin: 0 auto;">
			<label for="exampleFormControlInput1" class="form-label">제목</label> <input
				type="text" class="form-control" id="exampleFormControlInput1"
				value="${recruitboard.title}" readonly>
		</div>
		<div class="row g-3" style="width: 70%; margin: 0 auto;">
			<div class="col">
				<label for="exampleFormControlInput1" class="form-label">작성자</label>
				<input type="text" class="form-control"
					id="exampleFormControlInput1" value="${recruitboard.userId}" readonly>
			</div>
			<div class="col">
				<label for="exampleFormControlInput1" class="form-label">작성시간</label>
				<input type="text" class="form-control"
					id="exampleFormControlInput2" value="${recruitboard.regdate}"
					readonly>
			</div>
		</div>
		<div class="row g-3" style="width: 70%; margin: 0 auto;">
			<div class="col">
				<label for="exampleFormControlInput1" class="form-label">조회수</label>
				<input type="text" class="form-control"
					id="exampleFormControlInput1" value="${recruitboard.hit}" readonly>
			</div>
			<div class="col">
				<label for="exampleFormControlInput1" class="form-label">거래여부</label>
				<c:choose>
					<c:when test="${recruitboard.complete eq 1}">
						<input type="text" class="form-control"
							id="exampleFormControlInput1" value="거래완료" readonly>
					</c:when>
					<c:when test="${recruitboard.complete eq 0}">
						<input type="text" class="form-control"
							id="exampleFormControlInput1" value="판매중" readonly>
					</c:when>
				</c:choose>
			</div>
			<%-- <div class="col">
		   <label for="exampleFormControlInput1" class="form-label">추천</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" value="${getLike}" readonly>
		  </div> --%>
		</div>

		<div class="mb-3" style="width: 70%; margin: 0 auto;">
			<label for="exampleFormControlTextarea1" class="form-label"></label>
			<div>${recruitboard.content}</div>
		</div>
		<c:if test="${recruitboard.imageName != 'noImage'}">
			<div class="image-container"
				style="width: 200px; height: 200px; object-fit: cover;">
				<img src="${imgUrl}/boardFile/4_${recruitboard.imageName}.png"><br>
			</div>
		</c:if>

		<button type="button" class="btn btn-primary whyBtn listBtn"
			id="goList">목록</button>
		<c:if test="${sessionScope.userId eq recruitboard.userId}">
			<button type="submit" class="btn btn-primary CancleBtn updateBtn">수정</button>
		</c:if>
		<c:if
			test="${sessionScope.userId eq recruitboard.userId or sessionScope.isAdmin eq true}">
			<button type="button" class="btn btn-primary CancleBtn delbtn">삭제</button>
		</c:if>
		<button type="button" class="btn btn-primary CancleBtn LikeBtn"
			id="LikeBtn">추천 ${recruitboard.like}</button>
		<c:if
			test="${sessionScope.userId != recruitboard.userId and not empty sessionScope.userId}">
			<button type="button" id="userblock" style="margin-top: 30px;">게시자차단</button>
		</c:if>
	</form>
	<!-- 댓글 -->

	<c:if test="${not empty sessionScope.userId}">
		<div class="mb-3" style="width: 70%; margin: 0 auto;">
			<label for="exampleFormControlInput1" class="form-label">댓글
				작성자</label> <input type="text" class="form-control writerId"
				id="exampleFormControlInput1" name="writerId"
				value="${sessionScope.userId}" readonly>
		</div>
		<div class="mb-3" style="width: 70%; margin: 0 auto;">
			<label for="exampleFormControlTextarea1" class="form-label">댓글
				내용</label>
			<textarea class="form-control content"
				id="exampleFormControlTextarea1" rows="2" name="content"></textarea>
		</div>
		<div class="mb-3" style="width: 70%; margin: 0 auto;">
			<input type="checkbox" id="secret" name="secret" value="1">비밀댓글
		</div>
		<button type="button" class="btn btn-primary whyBtn1" id="com_btn">댓글
			등록</button>
	</c:if>

	<!-- 댓글이 들어갈 부분 -->
	<div class="com_box">
		<c:if test="${not empty commentList}">
			<c:forEach items="${commentList}" var="comment">
				<div class="row g-3" style="width: 70%; margin: 0 auto;">
					<div class="col">
						<label for="exampleFormControlInput1" class="form-label">작성자</label>
						<input type="text" class="form-control"
							id="exampleFormControlInput1" value="${comment.userId}" readonly>
					</div>
					<div class="col">
						<label for="exampleFormControlInput1" class="form-label">작성시간</label>
						<input type="text" class="form-control com-date"
							id="exampleFormControlInput2" value="${comment.regdate}" readonly>
					</div>
				</div>
				<div class="mb-3" style="width: 70%; margin: 0 auto;">
					<label for="exampleFormControlTextarea1" class="form-label">댓글
						내용</label>
					<c:choose>
						<c:when
							test="${comment.secret eq 0 or sessionScope.userId eq recruitboard.userId or 
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
						class="btn btn-primary whyBtn1 com_delete_btn" id="com_delete_btn"
						value="${comment.commentsId}">댓글삭제</button>
				</c:if>
				<c:if test="${sessionScope.userId eq comment.userId}">
					<button type="button"
						class="btn btn-primary whyBtn1 com_update_btn" id="com_update_btn"
						data-toggle="modal"
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
								<form action="/comments/update" id="editPostForm" method="post"
									enctype="multipart/form-data"
									onsubmit="return validatePostForm()">
									<input type="hidden" class="form-control mb-2" name="userId"
										value="${comment.userId}"> <input type="hidden"
										class="form-control mb-2" name="commentsId"
										value="${comment.commentsId}"> <input type="hidden"
										class="form-control mb-2" name="bno" value="${comment.bno}">
									<input type="hidden" class="form-control mb-2"
										name="commentType" value="${comment.commentType}">
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

	<!-- 푸터 -->
	<%@include file="../include/footer.jsp"%>
</body>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
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
var regdate = "${recruitboard.regdate}";
var formattedDate = new Date(regdate).toLocaleString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit'}); // 날짜 포맷팅
document.getElementById("exampleFormControlInput2").value = formattedDate;
		
		//목록
		$('#goList').click(function(){
			location.href = "/Recruitboard";
		})
		
		// 추천
		$('#LikeBtn').click(function(){
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
						"bno" : ${recruitboard.recruitboardId},
						"likesType" : 4
					},
					success : function(data){
						location.reload();
					}
				}) // ajax
			} // 세션 있을떄
		}) // 추천 버튼 클릭
		
		// 삭제
		/* $('.delbtn').click(function() {
			if(!confirm("해당 게시물을 삭제 하시겠습니까?")){
				return;
			}else{
				location.href = "<c:url value='/Tradeboard/deleteFree?freeboardId=${Detail.freeboardId}'/>";
			}
		}) */
		
		/* $('.delbtn').click(function() {
			if(!confirm("해당 게시물을 삭제 하시겠습니까?")){
				return;
			}else{
				$.ajax({
					type : "DELETE",
					url : "/Tradeboard?tradeboardId=" + tradeboardId,
					data : {
						"tradeboardId" : tradeboardId
					},
					success : function(){
						alert("게시글이 삭제되었습니다.");
		                window.location.href = "/Tradeboard";
					} //success
				}) // ajax
			//}
		}); */
		
		document.addEventListener("DOMContentLoaded", function () {
		    // 삭제 버튼 클릭 이벤트를 처리합니다.
		    document.querySelector(".delbtn").addEventListener("click", function (e) {
		    	e.preventDefault();
		    	
		    	// 알림을 통해 사용자에게 삭제 여부를 확인할 수 있습니다.
		        var isConfirmed = confirm("게시글을 삭제하시겠습니까?");

		        if (isConfirmed) {
		            // 액시오스를 사용하여 서버로 DELETE 요청을 보냅니다.
		            axios.delete('/Recruitboard/${recruitboard.recruitboardId}')
		            .then(function (response) {
		            	//ResponseEntity.ok 보내주면
		                console.log(response.data);
		                alert("게시글이 삭제되었습니다.");
		                window.location.href = "/Recruitboard";
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
			const recruitboardId = ${recruitboard.recruitboardId};
			const commentType = 4; 
			const secret = $('#secret').is(':checked') ? 1 : 0;
			console.log(content);
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
							"bno" : recruitboardId,
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
	    			"blockedUser" : "${recruitboard.userId}"
	    		},
	    		success : function(data){
	    			alert(data);
	    			location.reload();
	    		} // success
	    	}) // ajax
	    }) //버튼 클릭
	
</script>
</html>
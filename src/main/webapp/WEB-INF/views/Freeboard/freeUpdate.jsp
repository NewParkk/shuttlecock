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
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script
	src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
<script
	src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
</head>
<style>
#container {
	width: 1000px;
	margin: 20px auto;
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
						<li><a class="list" href="/Freeboard/freeList">자유게시판</a></li>
						<li><a class="list" href="/Tradeboard">물품거래소</a></li>
						<li><a class="list" href="#">운동장소찾기</a></li>
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

				<form action="<c:url value='/Freeboard/update'/>" method="post"
					enctype="multipart/form-data">
					<div class="mb-3" style="width: 70%; margin: 0 auto;">
						<label for="exampleFormControlInput1" class="form-label">제목</label>
						<input type="text" class="form-control" name="title"
							id="exampleFormControlInput1" value="${freeboard.title}">
					</div>
					<div class="row g-3" style="width: 70%; margin: 0 auto;">
						<div class="col">
							<label for="exampleFormControlInput1" class="form-label">작성자</label>
							<input type="text" class="form-control"
								id="exampleFormControlInput1" value="${freeboard.userId}"
								readonly>
						</div>
						<div class="col">
							<label for="exampleFormControlInput1" class="form-label">작성
								날짜</label> <input type="text" class="form-control"
								id="exampleFormControlInput1" value="${freeboard.regdate}"
								readonly>
						</div>
					</div>
					<div class="mb-3" style="width: 70%; margin: 0 auto;">
						<label for="exampleFormControlTextarea1" class="form-label">내용</label>
						<textarea class="form-control " name="content" id="ckeditor"
							rows="6">${freeboard.content}</textarea>
					</div>
					<!-- MultipartFile -->

					<div class="mb-3" style="width: 70%; margin: 0 auto;">
						<label for="formFileMultiple" class="form-label">첨부 파일</label> <input
							class="form-control" type="file" id="formFileMultiple"
							name="file">
						<!-- 이미지 이름이 있는 경우 이미지 이름과 파일 삭제 버튼을 표시합니다. -->
						<c:if test="${freeboard.imageName != 'noImage'}">
							<div class="image-container"
								style="width: 200px; height: 200px; object-fit: cover;">
								<img
									src="https://kr.object.ncloudstorage.com/team1bucket/boardFile/2_${freeboard.imageName}.png"><br>
								<!-- 이미지 이름 표시 -->
								<span>${freeboard.imageName}</span>
								<!-- 파일 삭제 버튼 -->
								<button type="button" class="btn btn-danger" id="deleteFileBtn">파일
									삭제</button>
							</div>
						</c:if>
					</div>

					<input type="hidden" value="${freeboard.freeboardId}"
						name="freeboardId">
					<button type="button" class="btn btn-primary whyBtn">글 수정</button>
					<button type="button" class="btn btn-primary CancleBtn">취
						&nbsp; 소</button>
				</form>
			</div>
		</section>
	</main>

	<!-- 푸터 -->
	<%@include file="../include/footer.jsp"%>
	<script type="text/javascript">
		$(function() {
			$('.whyBtn').click(function() {
				$("form").submit();
			});

			$('.CancleBtn').click(function() {
				location.href = "<c:url value='/Freeboard/freeList'/>";
			})
			
			ClassicEditor.create(document.querySelector('#ckeditor'), {
				toolbar: ['bold', 'italic', '|',  'link','undo','redo'],
				//toolbar: ['bold', 'italic', 'link', 'insertTable','mediaEmbed', 'undo','redo'], 
					// 'imageUpload',
				language:'ko'
			}).then(editor => {
			    window.editor = editor;
			}).catch( error => {
			    console.error( error );
			});
		});
		
		$(function() {
	        // 파일 삭제 버튼 클릭 이벤트 처리
	        $('#deleteFileBtn').click(function() {
	            // AJAX를 사용하여 서버로 파일 삭제 요청을 보냅니다.
	            $.ajax({
	                type: 'POST',
	                url: '/deleteFile', // 파일 삭제를 처리할 서버의 엔드포인트 주소를 지정합니다.
	                data: {
	                    'fileName': '${freeboard.imageName}' // 삭제할 파일의 이름을 서버에 전달합니다.
	                },
	                success: function(data) {
	                    // 성공적으로 파일이 삭제되면 이미지 이름과 파일 삭제 버튼을 숨깁니다.
	                    $('.image-container').hide();
	                    alert('파일이 삭제되었습니다.');
	                },
	                error: function(xhr, status, error) {
	                    // 파일 삭제에 실패하면 에러 메시지를 표시합니다.
	                    console.error('파일 삭제 중 에러 발생:', error);
	                    alert('파일 삭제 실패');
	                }
	            });
	        });
	    });
	</script>
</body>
</html>
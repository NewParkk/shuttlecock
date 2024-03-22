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
							<span class="post-info-text"> <strong>제목 :</strong>
							${freeboard.title}
					</div>
					<div class="row g-3" style="width: 70%; margin: 0 auto;">
						<div class="col">
							<span class="post-info-text"> <strong>작성자 :</strong>
							${freeboard.userId}
						</div>
						<div class="col">
							<span class="post-info-text"> <strong>작성 날짜 :</strong>
							${freeboard.regdate}
						</div>
					</div>
					<div class="mb-3" style="width: 70%; margin: 0 auto;">
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
								<img src="${imgUrl}/boardFile/2_${freeboard.imageName}.png"><br>
								<button id="del_img">이미지 삭제</button>
							</div>
						</c:if>
					</div>
					<div class=button-container>
						<input type="hidden" value="${freeboard.freeboardId}"
							name="freeboardId">
						<input type="hidden" value="${freeboard.title}"
							name="title">
						<input type="hidden" value="${freeboard.userId}"
							name="userId">
						<input type="hidden" value="${freeboard.imageName}"
							name="imageName">
						<button type="button" class="btn btn-primary whyBtn">글 수정</button>
						<button type="button" class="btn btn-primary CancleBtn">취
							&nbsp; 소</button>
					</div>
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
		
		document.getElementById("del_img").addEventListener("click", function() {
			// 이벤트의 기본동작을 막아서 페이지 이동이 바로 이루어지지 않게 했음. 
			event.preventDefault();
		    document.querySelector(".image-container").style.display = "none";
		    document.querySelector("input[name='imageName']").value = "";
		});
	</script>
</body>
</html>
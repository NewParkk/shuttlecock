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
<!-- <script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script> -->
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
<meta charset="UTF-8">
<title>Insert title here</title>
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
			<c:if test="${not empty sessionScope.userId}">
				<div class="noticeboard">
					<div class="title" style="">
						<div class="vline"></div>
						<div class="container2">
							<h3>자유 게시판</h3>
						</div>
					</div>

					<form action="<c:url value ='/Freeboard/insertFreeboard'/>"
						method="post" enctype="multipart/form-data">
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<span class="post-info-text"> <strong>제목 : </strong>
							<input type="text" class="form-control" name="title"
								id="exampleFormControlInput1">
						</div>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<span class="post-info-text"> <strong>작성자 :</strong>
							${sessionScope.userId}
						</div>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<textarea class="form-control " name="content" id="ckeditor"
								rows="6"></textarea>
						</div>
						<!-- MultipartFile -->

						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<label for="formFileMultiple" class="form-label"></label> <input
								class="form-control" type="file" id="formFileMultiple"
								name="file">
						</div>

						<div class=button-container>
							<input type="hidden" value="${sessionScope.userId}"
								name="userId">
							<button type="button" class="btn btn-primary whyBtn">글
								작성</button>
							<button type="button" class="btn btn-primary CancleBtn">취
								&nbsp; 소</button>
						</div>
					</form>
				</div>
			</c:if>
			<c:if test="${empty sessionScope.userId}">
				<script>
						function redirectToLoginPage() {
							window.location.href = "/login";
						}
				</script>
			</c:if>
		</section>
	</main>

	<!-- 푸터 -->
	<%@include file="../include/footer.jsp"%>
</body>

<script>
	$(function() {
		
		$('.whyBtn').click(function() {
			$("form").submit();
		});
		
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
</script>
</html>
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

.noticeboard {
	width: 100%;
}

.ck-editor__editable {
	height: 400px;
}

.ck-content {
	font-size: 12px;
}

.ck-editor__editable p {
	margin: 0
}

.ck-content .image {
	/* Block images */
	max-width: 80%;
	margin: 20px auto;
}

.mainTitle {
	text-align: center;
}

.whyBtn {
	margin-left: 46%;
}

/* h1 {
	padding-top: 30px;
	padding-bottom: 30px
} */
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

				<form action="<c:url value='/Freeboard/updateFree'/>" method="post">
					<div class="mb-3" style="width: 70%; margin: 0 auto;">
						<label for="exampleFormControlInput1" class="form-label">제목</label>
						<input type="text" class="form-control" name="title"
							id="exampleFormControlInput1" value="${Detail.title}">
					</div>
					<div class="row g-3" style="width: 70%; margin: 0 auto;">
						<div class="col">
							<label for="exampleFormControlInput1" class="form-label">작성자</label>
							<input type="text" class="form-control"
								id="exampleFormControlInput1" value="${Detail.userId}" readonly>
						</div>
						<div class="col">
							<label for="exampleFormControlInput1" class="form-label">작성
								날짜</label> <input type="text" class="form-control"
								id="exampleFormControlInput1" value="${Detail.regdate}" readonly>
						</div>
					</div>
					<div class="mb-3" style="width: 70%; margin: 0 auto;">
						<label for="exampleFormControlTextarea1" class="form-label">내용</label>
						<textarea class="form-control " name="content" id="ckeditor"
							rows="6">${Detail.content}</textarea>
					</div>
					<!-- MultipartFile -->

					<div class="mb-3" style="width: 70%; margin: 0 auto;">
						<label for="formFileMultiple" class="form-label"></label> <input
							class="form-control" type="file" id="formFileMultiple"
							name="upload">
					</div>

					<input type="hidden" value="${Detail.freeboardId}"
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
	</script>
</body>
</html>
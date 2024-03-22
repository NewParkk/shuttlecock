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
			<div class="noticeboard">
				<div class="title" style="">
					<div class="vline"></div>
					<div class="container2">
						<h3>공지사항 게시판</h3>
					</div>
				</div>

				<form action="<c:url value='/Announcement/updatepost'/>" method="post"
					enctype="multipart/form-data">
					<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<span class="post-info-text">
								<strong>제목 :</strong>
								<input type="text" id="title" name="title" value="${post.title}">
							</span>
					</div>
					<div class="row g-3" style="width: 70%; margin: 0 auto;">
						<div class="col">
							<span class="post-info-text"> <strong>작성자 :</strong>
							${post.userId}
							</span>
						</div>
						<div class="col">
							<span class="post-info-text"> <strong>작성 날짜 :</strong></span>
							<fmt:formatDate value="${post.regdate}" pattern="yyyy-MM-dd HH:mm" />
						</div>
					</div>
					<div class="mb-3" style="width: 70%; margin: 0 auto;">
						<textarea class="form-control " name="content" id="ckeditor"
							rows="6">${post.content}</textarea>
					</div>
					<div class=button-container>
						<input type="hidden" value="${post.announcementNo}"
							name="announcementNo">
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
				location.href = "<c:url value='/Announcement/'/>";
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
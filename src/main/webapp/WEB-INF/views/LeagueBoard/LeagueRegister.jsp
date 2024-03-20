<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Shuttle Cock</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script
	src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
<script
	src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<link rel="stylesheet" href="/css/free.css">
</head>
<style>
#container {
	width: 1000px;
	margin: 20px auto;
}
</style>
<body>
		<%@ include file="/WEB-INF/views/include/header.jsp"%>
		
		<main id="boardmain">
		<section id="contents">
		<%@ include file="category.jsp"%>

		<div class="noticeboard">
				<div class="title" style="">
						<div class="vline"></div>
						<div class="container2">
							<h3>리그게시판</h3>
						</div>
					</div>
		<!-- main  -->

				<c:if test="${not empty sessionScope.userId}">
					<form action="/LeagueBoard/insert" method="POST"
						enctype="application/x-www-form-urlencoded">
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<span class="post-info-text"> <strong>제목 : </strong></span>
							<input type="text" class="form-control" name="title"
								id="exampleFormControlInput1" placeholder="제목을 입력하세요. ">
						</div>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<span class="post-info-text"> <strong>작성자 :</strong></span>
							${sessionScope.userId}
						</div>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<textarea class="form-control " name="content" id="ckeditor"
								rows="6" placeholder="경기 내용을 입력하세요."></textarea>
						</div>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<span class="post-info-text"> <strong>승자 :</strong></span>
							<input type="text" class="form-control" name="winner"
								id="exampleFormControlInput1" style="width: 380px;"
								placeholder="승자을 입력하세요. 복식이라면 ,로 구분하여 두 명을 적으세요.">
						</div>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<span class="post-info-text"> <strong>패자 :</strong></span>
							<input type="text" class="form-control" name="loser"
								id="exampleFormControlInput1" style="width: 380px;"
								placeholder="패자을 입력하세요. 복식이라면 ,로 구분하여 두 명을 적으세요.">
						</div>
						<div class=button-container>
							<input type="hidden" value="${sessionScope.userId}"
								name="userId">
							<button type="button" class="btn btn-primary CancleBtn"
								onclick="location.href='/LeagueBoard'"
								style="margin-left: 10px;">취&nbsp; 소</button>
							<button type="submit" class="btn btn-primary whyBtn"
								style="margin-left: 10px; margin-top: 0px; height: 100%;">글
								작성</button>
						</div>
					</form>

				</c:if>
				<c:if test="${empty sessionScope.userId}">
					<script>
						function redirectToLoginPage() {
							window.location.href = "/login";
						}
					</script>
				</c:if>
				</div>
			</section>
		</main>

		<%@ include file="/WEB-INF/views/include/footer.jsp"%>

</body>

<script type="text/javascript">
$(function() {
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
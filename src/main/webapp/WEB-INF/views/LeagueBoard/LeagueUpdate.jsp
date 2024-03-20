<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Shuttle Cock</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<link rel="stylesheet" href="/css/free.css">
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
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

				<c:if test="${not empty sessionScope.userId}">
					<form action="/LeagueBoard/update" method="POST"
						enctype="application/x-www-form-urlencoded">
						<input type="hidden" id="leagueboardId" name="leagueboardId"
							value="${leagueboard.leagueboardId}" /> <input type="hidden"
							id="user_userId" name="userId" value="${leagueboard.userId}" />

						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<span class="post-info-text"> <strong>제목 :</strong></span> <input
								type="text" class="form-control" name="title"
								id="exampleFormControlInput1" value="${leagueboard.title}">
						</div>
						<div class="row g-3" style="width: 70%; margin: 0 auto;">
							<div class="col">
								<span class="post-info-text"> <strong>작성자 :</strong></span>
								${leagueboard.userId}
							</div>
							<div class="col">
								<span class="post-info-text"> <strong>작성 날짜 :</strong></span>
								<fmt:formatDate value="${leagueboard.regdate}" pattern="yyyy-MM-dd HH:mm" />
							</div>
						</div>
						<div class="row g-3" style="width: 70%; margin: 0 auto;">
							<div class="col">
								<span class="post-info-text"> <strong>승자 :</strong></span> <input
									type="text" class="form-control" name="winner"
									id="exampleFormControlInput1" value="${leagueboard.winner}">
							</div>
							<div class="col">
								<span class="post-info-text"> <strong>패자 :</strong></span> <input
									type="text" class="form-control" name="loser"
									id="exampleFormControlInput1" value="${leagueboard.loser}">
							</div>
						</div>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<textarea class="form-control " name="content" id="ckeditor"
								rows="6">${leagueboard.content}</textarea>
						</div>
						<div class=button-container>
							<button type="submit" class="btn btn-primary whyBtn">글
								수정</button>
							<button type="button" class="btn btn-primary CancleBtn"
								onclick="location.href='/LeagueBoard'">취&nbsp; 소</button>
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

	<script type="text/javascript">
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
</script>
</body>
</html>
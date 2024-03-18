<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Shuttle Cock</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/css/mainstyle.css">
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script
	src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
<script
	src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
</head>
<style>
.mainTitle {
	text-align: center;
}

.whyBtn {
	margin-left: 46%;
}

h1 {
	padding-top: 30px;
	padding-bottom: 30px
}
#main{
	 width: 70%; /* 메인 섹션의 너비를 조정 */
     margin: 0 auto; /* 좌우 여백을 자동으로 설정하여 중앙에 정렬 */
}
</style>
<body>
	<div id="wrap">
		<%@ include file="/WEB-INF/views/include/header.jsp"%>
		<%@ include file="category.jsp"%>

		<div class="mainTitle">
			<h1>리그게시판</h1>
		</div>

		<!-- main  -->
		<main id="main">
			<section class="notice">
				<div class="page-title">
					<div class="container">
						<h3>리그 결과 수정</h3>
					</div>
				</div>

				<c:if test="${not empty sessionScope.userId}">
					<form action="/LeagueBoard/update" method="POST"
						enctype="application/x-www-form-urlencoded">
						<input type="hidden" id="leagueboardId" name="leagueboardId"
								value="${leagueboard.leagueboardId}" /> <input type="hidden"
								id="user_userId" name="userId"
								value="${leagueboard.userId}" />

						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<label for="exampleFormControlInput1" class="form-label">제목</label>
							<input type="text" class="form-control" name="title"
								id="exampleFormControlInput1" value="${leagueboard.title}">
						</div>
						<div class="row g-3" style="width: 70%; margin: 0 auto;">
							<div class="col">
								<label for="exampleFormControlInput1" class="form-label">작성자</label>
								<input type="text" class="form-control"
									id="exampleFormControlInput1" value="${leagueboard.userId}"
									readonly>
							</div>
							<div class="col">
								<label for="exampleFormControlInput1" class="form-label">작성
										시간</label> <input type="text" class="form-control"
										id="exampleFormControlInput2" readonly>
							</div>
						</div>
						<div class="row g-3"style="width: 70%; margin: 0 auto;">
							<div class="col">
								<label for="exampleFormControlInput1" class="form-label">승자</label>
								<input type="text" class="form-control" name="winner"
									id="exampleFormControlInput1" value="${leagueboard.winner}">
							</div>
							<div class="col">
								<label for="exampleFormControlInput1" class="form-label">패자
								</label> <input type="text" class="form-control" name="loser"
									id="exampleFormControlInput1" value="${leagueboard.loser}">
							</div>
						</div>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<label for="exampleFormControlTextarea1" class="form-label">경기 내용</label>
							<textarea class="form-control " name="content"
								id="ckeditor" rows="6">${leagueboard.content}</textarea>
						</div>

						<button type="submit" class="btn btn-primary whyBtn">글 수정</button>
						<button type="button" class="btn btn-primary CancleBtn"
						onclick="location.href='/LeagueBoard'">취&nbsp; 소</button>
					</form>

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

		<%@ include file="/WEB-INF/views/include/footer.jsp"%>

	</div>
<script type="text/javascript">
//leagueboard.regdate 값을 포맷팅하여 input 태그에 적용
var regdate = "${leagueboard.regdate}"; // 예시로 날짜를 가져옴
var formattedDate = new Date(regdate).toLocaleString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit'}); // 날짜 포맷팅
document.getElementById("exampleFormControlInput2").value = formattedDate;

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
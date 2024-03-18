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

#main {
	width: 70%; /* 메인 섹션의 너비를 조정 */
	margin: 0 auto; /* 좌우 여백을 자동으로 설정하여 중앙에 정렬 */
}
</style>
<body>
	<div id="wrap">
		<%@ include file="/WEB-INF/views/include/header.jsp"%>
		<%@ include file="category.jsp"%>

		<div class="mainTitle">
			<h1>모집게시판</h1>
		</div>
		<!-- main  -->
		<main id="main">
			<section class="notice">

				<c:if test="${not empty sessionScope.userId}">
					<form action="/Recruitboard/insert" method="POST"
						enctype="multipart/form-data">
						<div class="mb-3" style="width: 70%;">
							<label for="exampleFormControlInput1" class="form-label">제목</label>
							<input type="text" class="form-control" name="title"
								id="exampleFormControlInput1" placeholder="제목을 입력하세요. ">
						</div>
						<div class="mb-3" style="width: 70%;">
							<label for="exampleFormControlInput1" class="form-label">작성자</label>
							<input type="text" class="form-control" name="userId"
								value="${sessionScope.userId}" id="exampleFormControlInput1"
								readonly>
						</div>
						<div class="mb-3" style="width: 70%;">
							<label for="exampleFormControlTextarea1" class="form-label">내용</label>
							<textarea class="form-control " name="content" id="ckeditor"
								rows="6" placeholder="내용을 입력하세요. "></textarea>
						</div>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<label for="formFileMultiple" class="form-label"></label> <input
								class="form-control" type="file" id="formFileMultiple"
								name="file">
						</div>
						<label for="exampleFormControlInput1" class="form-label">지역분류</label>
						<div class="mb-3" style="width: 70%;">
							<input type="radio" id="region" name="region" value="0">전체
							<input type="radio" id="region" name="region" value="1">서울
							<input type="radio" id="region" name="region" value="2">경기
							<input type="radio" id="region" name="region" value="3">충청
							<input type="radio" id="region" name="region" value="4">경상
							<input type="radio" id="region" name="region" value="5">전라
							<input type="radio" id="region" name="region" value="6">강원
						</div>
						<label for="exampleFormControlInput1" class="form-label">모집분류</label>
						<div class="mb-3" style="width: 70%;">
							<input type="radio" id="recruitType" name="recruitType" value="0">전체
							<input type="radio" id="recruitType" name="recruitType" value="1">리그 단식
							<input type="radio" id="recruitType" name="recruitType" value="2">리그 복식
							<input type="radio" id="recruitType" name="recruitType" value="3">단식
							<input type="radio" id="recruitType" name="recruitType" value="4">복식
							<input type="radio" id="recruitType" name="recruitType" value="5">심판
						</div>
						<br>
						<div class="container"
							style="height: 50px; display: flex; justify-content: flex-end;">
							<button type="button" class="btn btn-primary CancleBtn"
								onclick="location.href='/Recruitboard'" style="margin-left: 10px;">취&nbsp;소</button>
							<button type="submit" class="btn btn-primary whyBtn"
								style="margin-left: 10px; margin-top: 0px; height: 100%;">글작성</button>
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

			</section>
		</main>

		<%@ include file="/WEB-INF/views/include/footer.jsp"%>

	</div>

</body>

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
</html>
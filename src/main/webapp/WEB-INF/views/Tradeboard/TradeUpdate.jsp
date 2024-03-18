<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>Shuttle Cock</title>
<meta charset="UTF-8">
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script> -->
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
	<spring:eval
		expression="@environment.getProperty('NCP.STORAGE.APIURL')"
		var="imgUrl" />
	<div id="wrap">
		<%@ include file="/WEB-INF/views/include/header.jsp"%>
		<%@ include file="category.jsp"%>

		<div class="mainTitle">
			<h1>거래게시판</h1>
		</div>

		<!-- main  -->
		<main id="main">
			<section class="notice">
				<c:if test="${not empty sessionScope.userId}">
					<form action="/Tradeboard/update" method="POST"
						enctype="multipart/form-data">
						<input type="hidden" id="tradeboardId" name="tradeboardId"
							value="${tradeboard.tradeboardId}" /> <input type="hidden"
							id="userId" name="userId" value="${tradeboard.userId}" />

						<div class="mb-3" style="width: 70%;">
							<label for="exampleFormControlInput1" class="form-label">제목</label>
							<input type="text" class="form-control" name="title"
								id="exampleFormControlInput1" value="${tradeboard.title}">
						</div>
						<div class="row g-3" style="width: 70%;">
							<div class="col">
								<label for="exampleFormControlInput1" class="form-label">작성자</label>
								<input type="text" class="form-control"
									id="exampleFormControlInput1" value="${tradeboard.userId}"
									readonly>
							</div>
							<div class="col">
								<label for="exampleFormControlInput1" class="form-label">작성
									시간</label> <input type="text" class="form-control"
									id="exampleFormControlInput2" readonly>
							</div>
						</div>
						<div class="mb-3" style="width: 70%;">
							<label for="exampleFormControlTextarea1" class="form-label">내용</label>
							<textarea class="form-control " name="content" id="ckeditor"
								rows="6">${tradeboard.content}</textarea>
						</div>
						<c:if test="${tradeboard.imageName != 'noImage'}">
							<div class="image-container"
								style="width: 200px; height: 200px; object-fit: cover;">
								<img src="${imgUrl}/boardFile/3_${tradeboard.imageName}.png"><br>
							</div>
						<button id="del_img">이미지 삭제</button>
						</c:if>
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
						<label for="exampleFormControlInput1" class="form-label">품목분류</label>
						<div class="mb-3" style="width: 70%;">
							<input type="radio" id="itemClass" name="itemClass" value="0">전체
							<input type="radio" id="itemClass" name="itemClass" value="1">의류
							<input type="radio" id="itemClass" name="itemClass" value="2">라켓
							<input type="radio" id="itemClass" name="itemClass" value="3">보호대
							<input type="radio" id="itemClass" name="itemClass" value="4">신발
							<input type="radio" id="itemClass" name="itemClass" value="5">기타
						</div>
						<div class="mb-3" style="width: 70%;">
							<input type="radio" id="complete" name="complete" value="1">판매완료
						</div>
						<input name="imageName" type="hidden"
							value="${tradeboard.imageName}">
						<button type="submit" class="btn btn-primary whyBtn">글 수정</button>
						<button type="button" class="btn btn-primary CancleBtn"
							onclick="location.href='/Tradeboard'">취&nbsp; 소</button>
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
	//leagueboard.regdate 값을 포맷팅하여 input 태그에 적용
	var regdate = "${tradeboard.regdate}"; // 예시로 날짜를 가져옴
	var formattedDate = new Date(regdate).toLocaleString('ko-KR', {
		year : 'numeric',
		month : '2-digit',
		day : '2-digit',
		hour : '2-digit',
		minute : '2-digit'
	}); // 날짜 포맷팅
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
	
	document.getElementById("del_img").addEventListener("click", function() {
		// 이벤트의 기본동작을 막아서 페이지 이동이 바로 이루어지지 않게 했음. 
		event.preventDefault();
	    document.querySelector(".image-container").style.display = "none";
	    document.querySelector("input[name='imageName']").value = "";
	});
</script>
</html>
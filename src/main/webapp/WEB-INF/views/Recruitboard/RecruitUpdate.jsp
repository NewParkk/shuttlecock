<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
	<spring:eval
		expression="@environment.getProperty('NCP.STORAGE.APIURL')"
		var="imgUrl" />
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<main id="boardmain">
		<section id="contents">

			<%@ include file="category.jsp"%>
			<div class="noticeboard">
				<div class="title" style="">
					<div class="vline"></div>
					<div class="container2">
						<h3>모집게시판</h3>
					</div>
				</div>

				<!-- main  -->
				<c:if test="${not empty sessionScope.userId}">
					<form action="/Recruitboard/update" method="POST"
						enctype="multipart/form-data">
						<input type="hidden" id="recruitboardId" name="recruitboardId"
							value="${recruitboard.recruitboardId}" /> <input type="hidden"
							id="userId" name="userId" value="${recruitboard.userId}" />

						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<span class="post-info-text"> <strong>제목 :</strong></span> <input
								type="text" class="form-control" name="title"
								id="exampleFormControlInput1" value="${recruitboard.title}">
						</div>
						<div class="row g-3" style="width: 70%; margin: 0 auto;">
							<div class="col">
								<span class="post-info-text"> <strong>작성자 :</strong></span>
								${recruitboard.userId}
							</div>
							<div class="col">
								<span class="post-info-text"> <strong>작성 날짜 :</strong></span>
								<fmt:formatDate value="${recruitboard.regdate}" pattern="yyyy-MM-dd HH:mm" />
							</div>
						</div>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<textarea class="form-control " name="content" id="ckeditor"
								rows="6">${recruitboard.content}</textarea>
						<c:if test="${recruitboard.imageName != 'noImage'}">
							<div class="image-container"
								style="width: 200px; height: 200px; object-fit: cover;">
								<img src="${imgUrl}/boardFile/4_${recruitboard.imageName}.png"><br>
							</div>
							<button id="del_img">이미지 삭제</button>
						</c:if>
						</div>
						<br>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<label for="formFileMultiple" class="form-label"></label> <input
								class="form-control" type="file" id="formFileMultiple"
								name="file">
						</div>
						<br>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<input type="radio" id="region0" name="region" value="0">전체
							<input type="radio" id="region1" name="region" value="1">서울
							<input type="radio" id="region2" name="region" value="2">경기
							<input type="radio" id="region3" name="region" value="3">충청
							<input type="radio" id="region4" name="region" value="4">경상
							<input type="radio" id="region5" name="region" value="5">전라
							<input type="radio" id="region6" name="region" value="6">강원
						</div>
						<br>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<input type="radio" id="recruitType0" name="recruitType" value="0">전체
							<input type="radio" id="recruitType1" name="recruitType" value="1">리그
							단식 <input type="radio" id="recruitType2" name="recruitType"
								value="2">리그 복식 <input type="radio" id="recruitType3"
								name="recruitType" value="3">단식 <input type="radio"
								id="recruitType4" name="recruitType" value="4">복식 <input
								type="radio" id="recruitType5" name="recruitType" value="5">심판
						</div>
						<br>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<input type="checkbox" id="complete" name="complete" value="1">모집완료
						</div>
						<input name="imageName" type="hidden"
							value="${recruitboard.imageName}">
						<div class=button-container>
							<button type="submit" class="btn btn-primary whyBtn">글
								수정</button>
							<button type="button" class="btn btn-primary CancleBtn"
								onclick="location.href='/Recruitboard'">취&nbsp; 소</button>
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
	//leagueboard.regdate 값을 포맷팅하여 input 태그에 적용
	/* var regdate = "${recruitboard.regdate}"; // 예시로 날짜를 가져옴
	var formattedDate = new Date(regdate).toLocaleString('ko-KR', {
		year : 'numeric',
		month : '2-digit',
		day : '2-digit',
		hour : '2-digit',
		minute : '2-digit'
	}); // 날짜 포맷팅 */
	//document.getElementById("exampleFormControlInput2").value = formattedDate;
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
	
	window.onload = function(){
		var regionList = [];
		for (var i = 0; i <= 6; i++) {
		    var region = document.getElementById('region' + i);
		    regionList.push(region);
		}
		regionList.forEach(function(region, index){
			if('${recruitboard.region}' === region.value){
				region.checked = true;
			}
		});
		
		var typeList = [];
		for(var i = 0; i <= 5; i++){
			var type = document.getElementById('recruitType' + i);
			typeList.push(type);
		}
		typeList.forEach(function(type){
			if('${recruitboard.recruitType}' === type.value){
				type.checked = true;
			}
		});
		
		var complete = document.getElementById('complete');
		if('${recruitboard.complete}' == 1){
			complete.checked = true;
		}
	}
	
	document.getElementById("del_img").addEventListener("click", function() {
		// 이벤트의 기본동작을 막아서 페이지 이동이 바로 이루어지지 않게 했음. 
		event.preventDefault();
	    document.querySelector(".image-container").style.display = "none";
	    document.querySelector("input[name='imageName']").value = "";
	});
	
</script>
</html>
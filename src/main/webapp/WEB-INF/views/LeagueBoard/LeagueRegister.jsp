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
#submitBtn:disabled {
    background-color: #d2d2d2; 
    color: white; 
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
							<span class="post-info-text"> <strong>제목 : </strong></span> <input
								type="text" class="form-control" name="title"
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
							<c:if test="${recruitType == 1}">
								<select name="winner" style="width: 100px; margin-left: 10px;"
									class="form-control" id="search-select">
									<c:forEach items="${userList}" var="user">
										<option value="${user}">${user}</option>
									</c:forEach>
								</select>
							</c:if>
							<c:if test="${recruitType == 2}">
								<select name="winnerList" style="width: 100px; margin-left: 10px;"
									class="form-control" id="search-select winner1">
									<c:forEach items="${userList}" var="user">
										<option value="${user}">${user}</option>
									</c:forEach>
								</select>
								<select name="winnerList" style="width: 100px; margin-left: 10px;"
									class="form-control" id="search-select winner2">
									<c:forEach items="${userList}" var="user">
										<option value="${user}">${user}</option>
									</c:forEach>
								</select>
							</c:if>
						</div>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<span class="post-info-text"> <strong>패자 :</strong></span>
							<c:if test="${recruitType == 1}">
								<select name="loser" style="width: 100px; margin-left: 10px;"
									class="form-control" id="search-select">
									<c:forEach items="${userList}" var="user">
										<option value="${user}">${user}</option>
									</c:forEach>
								</select>
							</c:if>
							<c:if test="${recruitType == 2}">
								<select name="loserList" style="width: 100px; margin-left: 10px;"
									class="form-control" id="search-select loser1">
									<c:forEach items="${userList}" var="user">
										<option value="${user}">${user}</option>
									</c:forEach>
								</select>
								<select name="loserList" style="width: 100px; margin-left: 10px;"
									class="form-control" id="search-select loser2">
									<c:forEach items="${userList}" var="user">
										<option value="${user}">${user}</option>
									</c:forEach>
								</select>
							</c:if>
						</div>
						<div class=button-container>
							<input type="hidden" value="${sessionScope.userId}" name="userId">
							<input type="hidden" value="${recruitboardId}" name="recruitboardId">
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

$(document).ready(function() {
    // 드롭다운 선택 요소 가져오기
    var dropdowns = $('select');

    // 버튼 선택 요소 가져오기
    var submitButton = $('.whyBtn');

    // 드롭다운 값 변경 시 호출될 함수
    function checkDropdowns() {
        var values = []; // 드롭다운에서 선택된 값 저장할 배열

        // 각 드롭다운에서 선택된 값 가져와서 배열에 저장
        dropdowns.each(function() {
            var value = $(this).val();
            values.push(value);
        });

        // 중복된 값이 있는지 확인
        var hasDuplicate = values.some(function(value, index) {
            return values.indexOf(value) !== index;
        });

        // 중복된 값이 있으면 버튼 비활성화, 없으면 활성화
        if (hasDuplicate) {
            submitButton.prop('disabled', true);
        } else {
            submitButton.prop('disabled', false);
        }
    }

    // 드롭다운 값 변경 시 호출될 함수 등록
    dropdowns.change(checkDropdowns);

    // 초기 체크
    checkDropdowns();
});

</script>
</html>
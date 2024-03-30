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
label {
    display: inline-block;
    margin-right: 15px;
    font-size: 15px; 
    font-weight: normal; 
    cursor: pointer; 
}
input[type="radio"]:checked + label {
    font-weight: bold; 
}
</style>
<body>
	<%@ include file="../include/header.jsp"%>

	<!-- main -->
	<main id= "main">
        <div id="slider">
          <div class="imageWrap1"></div>
        </div>
	
		<!-- section -->
		<section id="contents">
			<%@ include file="category.jsp"%>

			<div class="noticeboard">
				<div class="title" style="margin:0px;">
					<div class="vline"></div>
					<div class="container2">
						<h3>모집게시판 &#10095</h3>
					</div>
				</div>
				<div class="title1" style="margin-left: 60px;">
	              <div class="vline"></div>
	              <h2>모집게시판 글 작성</h2>
	            </div>

				<c:if test="${not empty sessionScope.userId}">
					<form action="/Recruitboard/insert" method="POST"
						enctype="multipart/form-data" style="margin: 30px 60px 30px 60px;">
						<%-- <div class="mb-3" style="width: 70%; margin: 0 auto;">
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
								rows="6" placeholder="내용을 입력하세요. "></textarea>
						</div>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<label for="formFileMultiple" class="form-label"></label> <input
								class="form-control" type="file" id="formFileMultiple"
								name="file">
						</div>
						<br>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<input type="radio" id="region" name="region" value="0">전체
							<input type="radio" id="region" name="region" value="1">서울
							<input type="radio" id="region" name="region" value="2">경기
							<input type="radio" id="region" name="region" value="3">충청
							<input type="radio" id="region" name="region" value="4">경상
							<input type="radio" id="region" name="region" value="5">전라
							<input type="radio" id="region" name="region" value="6">강원
						</div>
						<br>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<input type="radio" id="recruitType" name="recruitType" value="0">전체
							<input type="radio" id="recruitType" name="recruitType" value="1">리그
							단식 <input type="radio" id="recruitType" name="recruitType"
								value="2">리그 복식 <input type="radio" id="recruitType"
								name="recruitType" value="3">단식 <input type="radio"
								id="recruitType" name="recruitType" value="4">복식 <input
								type="radio" id="recruitType" name="recruitType" value="5">심판
						</div>
						<br> --%>

						<table class="board-table"> 
				            <colgroup>
				                <col width="15%">
					            <col width="*">
				            </colgroup>
				            <tbody> 
				                <tr>
				                    <th scope="row" bgcolor="#F9F9F9">제목</th>
				                    <td colspan="4" style="text-align: left; padding-left:10px;">
					                    <input type="text" class="form-control1" name="title"
										id="exampleFormControlInput1" placeholder="제목을 입력하세요. ">
				                    </td>
				                </tr>
				                <tr>
				                    <th scope="row" bgcolor="#F9F9F9">작성자</th>
				                    <td colspan="4" style="text-align: left; padding-left:10px; font-weight: bold;">
								        ${sessionScope.userId}
								    </td>
				                </tr>
				                <tr>
				                    <th scope="row" bgcolor="#F9F9F9">지역</th>
				                    <td colspan="4">
								        <label><input type="radio" name="region" value="0">전체</label>
								        <label><input type="radio" name="region" value="1">서울</label>
								        <label><input type="radio" name="region" value="2">경기</label>
								        <label><input type="radio" name="region" value="3">충청</label>
								        <label><input type="radio" name="region" value="4">경상</label>
								        <label><input type="radio" name="region" value="5">전라</label>
								        <label><input type="radio" name="region" value="6">강원</label>
								    </td>
				                </tr>
				                <tr>
				                    <th scope="row" bgcolor="#F9F9F9">경기</th>
				                    <td colspan="4">
								        <label><input type="radio" name="recruitType" value="0">전체</label>
								        <label><input type="radio" name="recruitType" value="1">리그 단식</label>
								        <label><input type="radio" name="recruitType" value="2">리그 복식</label>
								        <label><input type="radio" name="recruitType" value="3">단식</label>
								        <label><input type="radio" name="recruitType" value="4">복식</label>
								        <label><input type="radio" name="recruitType" value="5">심판</label>
								    </td>
				                </tr>
				                <tr>
				                    <th scope="row" bgcolor="#F9F9F9">첨부파일</th>
				                    <td colspan="4">
			                        	<input class="form-control" type="file" id="formFileMultiple" name="file" style="margin-left:30px;">
				                    </td>
				                </tr>
				                <tr>
				                    <th scope="row" bgcolor="#F9F9F9">내용</th>
				                    <td colspan="4" style="padding: 10px;">
				                        <textarea class="form-control " name="content" id="ckeditor" rows="6" placeholder="내용을 입력하세요. "></textarea>
				                    </td>
				                </tr>
				            </tbody>
			        	</table>
						<div class=button-container>
							<input type="hidden" value="${sessionScope.userId}"
								name="userId">
							<button type="button" class="btn btn-primary CancleBtn"
								onclick="location.href='/Recruitboard'">취&nbsp;소</button>
							<button type="submit" class="btn btn-primary whyBtn" style="margin-right:10px;">글작성</button>
						</div>
					</form>

				</c:if>
			</div>
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
</body>

<script type="text/javascript">
ClassicEditor.create(document.querySelector('#ckeditor'), {
	toolbar: ['bold', 'italic', '|',  'link','undo','redo'],
	//toolbar: ['bold', 'italic', 'link', 'insertTable','mediaEmbed', 'undo','redo'], 
		// 'imageUpload',
	language:'ko'
}).then(editor => {
    window.editor = editor;
    $('.whyBtn').click(function() {
        // 제목과 내용을 가져옵니다.
        var title = $('#exampleFormControlInput1').val();
        var content = editor.getData(); // 에디터의 내용을 가져옵니다.
        // 제목이나 내용이 비어 있는지 확인합니다.
        if (title.trim() === '') {
            alert('제목을 입력하세요.');
            return false;
        } if(content.trim() === ''){
            alert('내용을 입력하세요.');
            return false;
        } else {
            $("form").submit(); // 유효한 경우 폼을 제출합니다.
        }
    });
}).catch( error => {
    console.error( error );
});
</script>
</html>
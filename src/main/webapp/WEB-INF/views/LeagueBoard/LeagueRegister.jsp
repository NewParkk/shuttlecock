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
<!-- aisde-js 파일 -->
<script src="/js/aside-js.js"></script>
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
						<h3>리그게시판 &#10095</h3>
					</div>
				</div>
				<div class="title1" style="margin-left: 60px;">
	              <div class="vline"></div>
	              <h2>리그게시판 글 작성</h2>
	            </div>
		

				<c:if test="${not empty sessionScope.userId}">
					<form action="/LeagueBoard/insert" method="POST"
						enctype="application/x-www-form-urlencoded" style="margin: 30px 60px 30px 60px;">
					<!-- 승자 패자 table 변경부분 -->
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
				               	<!-- <tr>
				                    <th scope="row" bgcolor="#F9F9F9">승자</th>
				                    <td colspan="4" style="text-align: left; padding-left:10px;">
					                    <input type="text" class="form-control2" name="winner"
										id="exampleFormControlInput1" placeholder="승자을 입력하세요. 복식이라면 ,로 구분하여 두 명을 적으세요.">
				                    </td>
				                </tr>
				                <tr>
				                    <th scope="row" bgcolor="#F9F9F9">패자</th>
				                    <td colspan="4" style="text-align: left; padding-left:10px;">
					                    <input type="text" class="form-control2" name="loser"
										id="exampleFormControlInput1" placeholder="패자을 입력하세요. 복식이라면 ,로 구분하여 두 명을 적으세요.">
				                    </td>
				                </tr> -->	
				                <tr>
				                    <th scope="row" bgcolor="#F9F9F9">내용</th>
				                    <td colspan="4" style="padding: 10px;">
				                        <textarea class="form-control " name="content" id="ckeditor" rows="6" placeholder="내용을 입력하세요. "></textarea>
				                    </td>
				                </tr>
				            </tbody>
			        	</table>
			        	
			        	<!-- 승자 패자 table 변경부분 //////////////////////-->
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
							<div id="message"></div>
						</div>
			        	
						<div class=button-container>
							<input type="hidden" value="${sessionScope.userId}"
								name="userId">
								<input type="hidden" value="${recruitboardId}" name="recruitboardId">
							<button type="button" class="btn btn-primary CancleBtn" onclick="location.href='/LeagueBoard'" style="margin-left: 10px;">취&nbsp; 소</button>
							<button type="submit" class="btn btn-primary whyBtn" style="margin-right:10px;">글작성</button>
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
            $('#message').css('color', 'red');
            $('#message').html("중복된 사용자가 선택되었습니다.");
        } else {
            submitButton.prop('disabled', false);
            $('#message').css('color', 'green');
            $('#message').html("글 등록이 가능합니다.");
        }
    }

    // 드롭다운 값 변경 시 호출될 함수 등록
    dropdowns.change(checkDropdowns);

    // 초기 체크
    checkDropdowns();
});

</script>
</html>
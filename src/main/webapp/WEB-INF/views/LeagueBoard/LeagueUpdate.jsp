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
<!-- aisde-js 파일 -->
<script src="/js/aside-js.js"></script>
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
#whyBtn:disabled {
	background-color: #d2d2d2 !important;
	color: white !important;
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
	              <h2>리그게시판 글 수정</h2>
	            </div>

				<c:if test="${not empty sessionScope.userId}">
					<form action="/LeagueBoard/update" method="POST"
						enctype="application/x-www-form-urlencoded" style="margin: 30px 60px 30px 60px;">
						<input type="hidden" id="leagueboardId" name="leagueboardId"
							value="${leagueboard.leagueboardId}" /> 
						<input type="hidden" id="user_userId" name="userId" value="${leagueboard.userId}" />
							
						<table class="board-table"> 
			            <colgroup>
			                <col width="15%">
				            <col width="35%">
				            <col width="15%">
				            <col width="35%">
			            </colgroup>
			            <tbody> 
			                <tr>
			                    <th scope="row" bgcolor="#F9F9F9">제목</th>
			                    <td style="text-align: left; padding-left:10px;">
			                    	<input type="text" class="form-control1" name="title"
									id="exampleFormControlInput1" value="${leagueboard.title}">
			                    </td>
			                    <th scope="row" bgcolor="#F9F9F9">작성일</th>
			                    <td scope="row" style="text-align: left; padding-left:10px;">
							        <fmt:formatDate value="${leagueboard.regdate}" pattern="yyyy-MM-dd HH:mm"/>
							    </td>
			                </tr>
			                <tr>
			                    <th scope="row" bgcolor="#F9F9F9">작성자</th>
			                    <td colspan="4" style="text-align: left; padding-left:10px; font-weight: bold;">
							        ${leagueboard.userId}
							    </td>
			                </tr>
		                	<%-- <tr>
			                    <th scope="row" bgcolor="#F9F9F9">승자</th>
			                    <td colspan="4" style="text-align: left; padding-left:10px;">
				                    <input type="text" class="form-control1" name="winner"
									id="exampleFormControlInput1" value="${leagueboard.winner}" style="font-size:15px; color:gray;">
			                    </td>
			                </tr>
			                <tr>
			                    <th scope="row" bgcolor="#F9F9F9">패자</th>
			                    <td colspan="4" style="text-align: left; padding-left:10px;">
				                    <input type="text" class="form-control1" name="loser"
									id="exampleFormControlInput1" value="${leagueboard.loser}" style="font-size:15px; color:gray;">
			                    </td>
			                </tr> --%>	
			                <tr>
			                    <th scope="row" bgcolor="#F9F9F9">내용</th>
			                    <td colspan="4" style="padding: 10px;">
			                        <textarea class="form-control " name="content" id="ckeditor" rows="6">${leagueboard.content}</textarea>
			                    </td>
			                </tr>
			            </tbody>
			        </table>
			        <div class="row g-3" style="width: 70%; margin: 0 auto;">
							<div class="col">
								<span class="post-info-text"> <strong>승자 :</strong></span>
								<c:if test="${not empty leagueboard.winner}">
									<select name="winner" style="width: 100px; margin-left: 10px;"
										class="form-control" id="search-select">
										<c:forEach items="${userList}" var="user">
											<option value="${user}">${user}</option>
										</c:forEach>
									</select>
								</c:if>
								<c:if test="${not empty leagueboard.winners}">
									<select name="winnerList"
										style="width: 100px; margin-left: 10px;" class="form-control"
										id="search-select winner1">
										<c:forEach items="${userList}" var="user">
											<option value="${user}">${user}</option>
										</c:forEach>
									</select>
									<select name="winnerList"
										style="width: 100px; margin-left: 10px;" class="form-control"
										id="search-select winner2">
										<c:forEach items="${userList}" var="user">
											<option value="${user}">${user}</option>
										</c:forEach>
									</select>
								</c:if>
							</div>
							<div class="col">
								<span class="post-info-text"> <strong>패자 :</strong></span>
								<c:if test="${not empty leagueboard.loser}">
									<select name="loser" style="width: 100px; margin-left: 10px;"
										class="form-control" id="search-select">
										<c:forEach items="${userList}" var="user">
											<option value="${user}">${user}</option>
										</c:forEach>
									</select>
								</c:if>
								<c:if test="${not empty leagueboard.losers}">
									<select name="loserList"
										style="width: 100px; margin-left: 10px;" class="form-control"
										id="search-select loser1">
										<c:forEach items="${userList}" var="user">
											<option value="${user}">${user}</option>
										</c:forEach>
									</select>
									<select name="loserList"
										style="width: 100px; margin-left: 10px;" class="form-control"
										id="search-select loser2">
										<c:forEach items="${userList}" var="user">
											<option value="${user}">${user}</option>
										</c:forEach>
									</select>
								</c:if>
							</div>
							<div id="message"></div>
						</div>
						<div class=button-container>
							<button type="submit" class="btn btn-primary whyBtn">글
								수정</button>
							<button type="button" class="btn btn-primary CancleBtn"
								onclick="removeGlobal();">취&nbsp; 소</button>
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

function removeGlobal(){
	$.ajax({
		url : "/removeGlobal",
		success : function(){
			window.location.href = '/LeagueBoard';
		}
	})
}

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
            $('#message').html("글 수정이 가능합니다.");
        }
    }

    // 드롭다운 값 변경 시 호출될 함수 등록
    dropdowns.change(checkDropdowns);

    // 초기 체크
    checkDropdowns();
});

</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Shuttle Cock</title>
<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<!-- aisde-js 파일 -->
<script src="/js/aside-js.js"></script>
<link rel="stylesheet" href="/css/free.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<!-- <script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script> -->
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

.imageWrap1 {
	width: 100%;
	height: 140px;
	background: url("/img/badminton-bg.jpg") repeat;
	background-size: contain;
}

.title1 {
	display: flex;
	margin: 35px 25px 25px 25px;
}

.title1 h2 {
	font-size: 20px;
	font-weight: 400;
	text-align: left;
	margin-left: 10px;
}

.form-control1 {
	width: 300px;
	border: none;
	border-bottom: 2px solid #ccc;
	padding: 5px;
	font-size: 12px;
	outline: none;
}

.form-control1:focus {
	border-color: #607d67;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<body>
	<!-- 헤더 -->
	<%@ include file="../include/header.jsp"%>
	
	<!-- main -->
	<main id= "main">
        <div id="slider">
          <div class="imageWrap1"></div>
        </div>
	
		<!-- section -->
		<section id="contents">
			<!-- aside -->
			<div class="aside">
				<div class="menubar">
					<ul>
						<li><a class="list" href="/Freeboard/freeList">자유게시판</a></li>
						<li><a class="list" href="/Tradeboard">물품거래소</a></li>
					</ul>
				</div>
			</div>

			<c:if test="${not empty sessionScope.userId}">
			<!-- noticeboard -->
				<div class="noticeboard" >
		            <div class="title" style="margin:0px;">
						<div class="vline"></div>
						<div class="container2">
							<h3>자유 게시판 &#10095</h3>
						</div>
					</div>
					<div class="title1" style="margin-left: 60px;">
		              <div class="vline"></div>
		              <h2>자유게시판 글 작성</h2>
		            </div>
					
				<%-- <form action="<c:url value ='/Freeboard/insertFreeboard'/>" method="post" enctype="multipart/form-data" style="margin: 30px 60px 30px 60px;">
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
						<button type="button" class="btn btn-primary CancleBtn" onclick="location.href='/Freeboard/freeList'">취&nbsp; 소</button>
						<button type="button" class="btn btn-primary whyBtn" style="margin-right:10px;">글작성</button>
					</div>
				</form> --%>

					<form action="/Freeboard/insertFreeboard" method="POST"
						enctype="multipart/form-data" style="margin: 30px 60px 30px 60px;">
						<table class="board-table">
							<colgroup>
								<col width="15%">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row" bgcolor="#F9F9F9">제목</th>
									<td colspan="4" style="text-align: left; padding-left: 10px;">
										<input type="text" class="form-control1" name="title"
										id="exampleFormControlInput1" placeholder="제목을 입력하세요. ">
									</td>
								</tr>
								<tr>
									<th scope="row" bgcolor="#F9F9F9">작성자</th>
									<td colspan="4">${sessionScope.userId}</td>
								</tr>
								<tr>
									<th scope="row" bgcolor="#F9F9F9">첨부파일</th>
									<td colspan="4"><input class="form-control" type="file"
										id="formFileMultiple" name="file" style="margin-left: 30px;">
									</td>
								</tr>
								<tr>
									<th scope="row" bgcolor="#F9F9F9">내용</th>
									<td colspan="4" style="padding: 10px;"><textarea
											class="form-control " name="content" id="ckeditor" rows="6"
											placeholder="내용을 입력하세요. "></textarea></td>
								</tr>
							</tbody>
						</table>

						<div class=button-container>
							<input type="hidden" value="${sessionScope.userId}" name="userId">
							<button type="button" class="btn btn-primary CancleBtn" onclick="location.href='/Freeboard/freeList'">취&nbsp; 소</button>
							<button type="submit" class="btn btn-primary whyBtn">글작성</button>
						</div>
					</form>
				</div>
				<!-- //noticeboard -->
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

	<!-- 푸터 -->
	<%@include file="../include/footer.jsp"%>
</body>

<script>
$(function() {
    ClassicEditor
        .create(document.querySelector('#ckeditor'), {
            toolbar: ['bold', 'italic', '|', 'link', 'undo', 'redo'],
            language: 'ko'
        })
        .then(editor => {
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
        })
        .catch(error => {
            console.error(error);
        });
});
	

 	/* aside가 (/Freeboard/freeList)url이 같은 페이지로 인식되도록 작성함 */
    var currentPageUrl = "/Freeboard/freeList"; 
    var menuItems = document.querySelectorAll('.menubar .list');
    menuItems.forEach(function(item) {
        if (item.getAttribute('href') === currentPageUrl) {
            item.classList.add('active');
        }
    });

</script>
</html>
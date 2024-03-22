<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PostDashBoard</title>
<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<!-- aisde-js 파일 -->
<script src="/js/aside-js.js"></script>
<link rel="stylesheet" href="/css/free.css">

<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
</head>
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
			      <li><a class="list" href="/main">HOME</a></li>
			      <li><a class="list" href="/Announcement/">공지사항</a></li>
			      <li><a class="list" href="/getNews">배드민턴 정보</a></li>
			      <li><a class="list" href="/getGame">정규대회 일정</a></li>
			    </ul>
			  </div>
			</div>
		
			<div class="noticeboard">
				<div class="title">
					<div class="vline"></div>
					<div class="container2">
						<h3>공지사항 게시판 &#10095</h3>
					</div>
				</div>
				<div class="title1" style="margin-left: 60px;">
		              <div class="vline"></div>
		              <h2>공지사항 글 작성</h2>
	            </div>
	            
				<form action="/Announcement/insertpost" method="post" style="margin: 30px 60px 30px 60px;">             
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
								id="title" placeholder="제목을 입력하세요. " required>
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
		        
		        <span class="button-container" style="float: right;">
				    <button type="button" class="btn btn-primary CancleBtn">취 소</button>
				    <input type="submit" class="btn btn-primary whyBtn" style="margin-right:10px;" value="글 작성">
				</span>
			</form>
		</div>
		
		</section>
		<!-- //section -->
	</main>
	<!-- //main -->
	
	<!-- footer -->
	<%@include file="../include/footer.jsp"%>
					        
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script> -->
	
	<script type="text/javascript">
		$(function() {
			$('.whyBtn').click(function() {
				$("form").submit();
			});

			$('.CancleBtn').click(function() {
				location.href = "<c:url value='/Announcement/'/>";
			})
			
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
		
		/* aside가 (/Announcement/)url이 같은 페이지로 인식되도록 작성함 */
		var currentPageUrl = "/Announcement/"; 
		var menuItems = document.querySelectorAll('.menubar .list');
		menuItems.forEach(function(item) {
		    if (item.getAttribute('href') === currentPageUrl) {
		        item.classList.add('active');
		    }
		});
	</script>
</body>
</html>
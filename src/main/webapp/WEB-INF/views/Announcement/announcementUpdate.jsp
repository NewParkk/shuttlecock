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
<link rel="stylesheet" href="/css/free.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

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
	              <h2>공지사항 글 수정</h2>
	            </div>

				<form action="<c:url value='/Announcement/updatepost'/>" method="post"
					enctype="multipart/form-data" style="margin: 30px 60px 30px 60px;">
					
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
			                    <td colspan="4" style="text-align: left; padding-left:10px;">
			                    	<input type="text" class="form-control1" name="title" id="title" value="${post.title}">
			                    </td>
			                </tr>
			                <tr>
			                    <th scope="row" bgcolor="#F9F9F9">작성자</th>
			                    <td scope="row" style="text-align: left; padding-left:10px;">
							        ${post.userId}
							    </td>
							    <th scope="row" bgcolor="#F9F9F9">작성일</th>
			                    <td scope="row" style="text-align: left; padding-left:10px;">
							        <fmt:formatDate value="${post.regdate}" pattern="yyyy-MM-dd HH:mm"/>
							    </td>
			                </tr>
			                <tr>
			                    <th scope="row" bgcolor="#F9F9F9">내용</th>
			                    <td colspan="4" style="padding: 10px;">
			                        <textarea class="form-control " name="content" id="ckeditor" rows="6">${post.content}</textarea>
			                    </td>
			                </tr>
			            </tbody>
			        </table>
					
					<div class=button-container>
						<input type="hidden" value="${post.announcementNo}"
							name="announcementNo">
						<button type="button" class="btn btn-primary CancleBtn">취&nbsp; 소</button>
						<button type="button" class="btn btn-primary whyBtn">글 수정</button>
					</div>
				</form>
			</div>
		</section>
	</main>

	<!-- 푸터 -->
	<%@include file="../include/footer.jsp"%>
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
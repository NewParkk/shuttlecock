<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>
<title>Post Details</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<style>
.post-detail-container, .comments-section {
	background-color: #f8f8f8;
	padding: 15px;
	border-radius: 5px;
	margin-bottom: 20px;
}

.comment {
	border-bottom: 1px solid #ddd;
	padding: 10px;
}
</style>
</head>
<body>
	<div class="container mt-3">
		<div class="post-detail-container">
			<h3>${post.title}</h3>
			<p>${post.content}</p>
			<small>작성자: ${post.userId}</small><br/>
			<small>작성일: ${post.regdate}</small>
		</div>
		<div style="text-align: right">
				<a href="/Announcement/main"
					class="btn btn-primary btn-sm">목록</a>
			<c:if test="${sessionScope.isAdmin}">
				<button class="btn btn-primary btn-sm" data-toggle="modal"
					data-target="#editPostModal">수정</button>
				<a href="/Announcement/deletepost/${post.announcementNo}"
					class="btn btn-danger btn-sm">삭제</a>
			</c:if>
		</div>
	</div>
	
	<!-- 게시글 수정 모달 -->
	<div class="modal fade" id="editPostModal" tabindex="-1" role="dialog"
		aria-labelledby="editPostModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="editPostModalLabel">게시글 수정</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="/Announcement/updatepost/${post.announcementNo}"
						id="editPostForm" method="post" enctype="multipart/form-data"
						onsubmit="return validatePostForm()">
						<input type="text" class="form-control mb-2" name="title"
							value="${post.title}">
						<textarea class="form-control" style="height: 500px" name="content">${post.content}</textarea>
						<button type="submit" class="btn btn-primary mt-2">저장</button>
					</form>
				</div>
			</div>
		</div>
	</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
function validatePostForm() 
{
	var titleField = document.querySelector('#editPostForm input[name="title"]');
	var contentField = document.querySelector('#editPostForm textarea[name="content"]');
	if (titleField.value.trim() === '' || contentField.value.trim() === '') {
	    alert('제목과 내용을 입력하세요.');
	    return false;
	}
return true;
 }
</script>
</body>
</html>

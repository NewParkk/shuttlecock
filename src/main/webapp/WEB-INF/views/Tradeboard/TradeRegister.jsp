<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>거래게시판</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
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
</style>
<body>
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
					<form action="/Tradeboard/insert" method="POST"
						enctype="application/x-www-form-urlencoded">
						<div class="mb-3" style="width: 50%; margin: 0 auto;">
							<label for="exampleFormControlInput1" class="form-label">제목</label>
							<input type="text" class="form-control" name="title"
								id="exampleFormControlInput1" placeholder="제목을 입력하세요. ">
						</div>
						<div class="mb-3" style="width: 50%; margin: 0 auto;">
							<label for="exampleFormControlInput1" class="form-label">작성자</label>
							<input type="text" class="form-control" name="userId"
								value="${sessionScope.userId}" id="exampleFormControlInput1"
								readonly>
						</div>
						<div class="mb-3" style="width: 50%; margin: 0 auto;">
							<label for="exampleFormControlTextarea1" class="form-label">내용</label>
							<textarea class="form-control " name="content" id="ckeditor"
								rows="6" placeholder="내용을 입력하세요. "></textarea>
						</div>
						<div class="mb-3" style="width: 50%; margin: 0 auto;">
							<input type="radio" id="region" name="region" value="0">전체
							<input type="radio" id="region" name="region" value="1">서울
							<input type="radio" id="region" name="region" value="2">경기
							<input type="radio" id="region" name="region" value="3">충청
							<input type="radio" id="region" name="region" value="4">경상
							<input type="radio" id="region" name="region" value="5">전라
							<input type="radio" id="region" name="region" value="6">강원
						</div>
						<br>
						<div class="container"
							style="height: 50px; display: flex; justify-content: flex-end;">
							<button type="button" class="btn btn-primary CancleBtn"
								onclick="location.href='/Tradeboard'" style="margin-left: 10px;">취&nbsp;소</button>
							<button type="submit" class="btn btn-primary whyBtn"
								style="margin-left: 10px; margin-top: 0px; height: 100%;">글작성</button>
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

			</section>
		</main>

		<%@ include file="/WEB-INF/views/include/footer.jsp"%>

	</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>거래게시판</title>
<meta charset="UTF-8">
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script> -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/resources/css/layout1.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/layout2.css" rel="stylesheet" type="text/css" />
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
					<form action="/Tradeboard/update" method="POST"
						enctype="application/x-www-form-urlencoded">
						<input type="hidden" id="tradeboardId" name="tradeboardId"
							value="${tradeboard.tradeboardId}" /> <input type="hidden"
							id="userId" name="userId" value="${tradeboard.userId}" />

						<div class="mb-3" style="width: 50%; margin: 0 auto;">
							<label for="exampleFormControlInput1" class="form-label">제목</label>
							<input type="text" class="form-control" name="title"
								id="exampleFormControlInput1" value="${tradeboard.title}">
						</div>
						<div class="row g-3"
							style="width: 51%; margin: 0 auto; margin-top: -25px">
							<div class="col">
								<label for="exampleFormControlInput1" class="form-label">작성자</label>
								<input type="text" class="form-control"
									id="exampleFormControlInput1" value="${tradeboard.userId}"
									readonly>
							</div>
							<div class="col">
								<label for="exampleFormControlInput1" class="form-label">작성
									시간</label> <input type="text" class="form-control"
									id="exampleFormControlInput2" readonly>
							</div>
						</div>
						<div class="mb-3" style="width: 50%; margin: 0 auto;">
							<label for="exampleFormControlTextarea1" class="form-label">내용</label>
							<textarea class="form-control " name="content" id="ckeditor"
								rows="6">${tradeboard.content}</textarea>
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
						<div class="mb-3" style="width: 50%; margin: 0 auto;">
							<input type="radio" id="complete" name="complete" value="1">판매완료
						</div>
						<button type="submit" class="btn btn-primary whyBtn">글 수정</button>
						<button type="button" class="btn btn-primary CancleBtn"
							onclick="location.href='/Tradeboard'">취&nbsp; 소</button>
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
	<script type="text/javascript">
		//leagueboard.regdate 값을 포맷팅하여 input 태그에 적용
		var regdate = "${leagueboard.regdate}"; // 예시로 날짜를 가져옴
		var formattedDate = new Date(regdate).toLocaleString('ko-KR', {
			year : 'numeric',
			month : '2-digit',
			day : '2-digit',
			hour : '2-digit',
			minute : '2-digit'
		}); // 날짜 포맷팅
		document.getElementById("exampleFormControlInput2").value = formattedDate;

		/* $('.updateBtn').click(function() {
			if (!confirm("해당 게시물을 수정 하시겠습니까?")) {
				return;
			} else {
				$.ajax({
					url : "/Tradeboard/update",
					method : "POST",
					data : {
						"tradeboardId" : tradeboardId
					},
					success : function() {
						alert("수정 완료");
					}
				})
			}
		}) */
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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

input[type="radio"]:checked+label {
	font-weight: bold;
}
</style>
<body>
	<spring:eval
		expression="@environment.getProperty('NCP.STORAGE.APIURL')"
		var="imgUrl" />
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<!-- main -->
	<main id="main">
		<div id="slider">
			<div class="imageWrap1"></div>
		</div>

		<!-- section -->
		<section id="contents">
			<%@ include file="category.jsp"%>

			<div class="noticeboard">
				<div class="title" style="margin: 0px;">
					<div class="vline"></div>
					<div class="container2">
						<h3>물품거래소 &#10095</h3>
					</div>
				</div>
				<div class="title1" style="margin-left: 60px;">
					<div class="vline"></div>
					<h2>물품거래소 글 수정</h2>
				</div>

				<!-- main  -->
				<c:if test="${not empty sessionScope.userId}">
					<form action="/Tradeboard/update" method="POST"
						enctype="multipart/form-data" style="margin: 30px 60px 30px 60px;">
						<%-- <input type="hidden" id="tradeboardId" name="tradeboardId"
							value="${tradeboard.tradeboardId}" /> <input type="hidden"
							id="userId" name="userId" value="${tradeboard.userId}" />

						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<span class="post-info-text"> <strong>제목 :</strong></span> <input
								type="text" class="form-control" name="title"
								id="exampleFormControlInput1" value="${tradeboard.title}">
						</div>
						<div class="row g-3" style="width: 70%; margin: 0 auto;">
							<div class="col">
								<span class="post-info-text"> <strong>작성자 :</strong></span>
								${tradeboard.userId}
							</div>
							<div class="col">
								<span class="post-info-text"> <strong>작성 날짜 :</strong></span>
								<fmt:formatDate value="${tradeboard.regdate}" pattern="yyyy-MM-dd HH:mm" />
							</div>
						</div>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<textarea class="form-control " name="content" id="ckeditor"
								rows="6">${tradeboard.content}</textarea>
						<c:if test="${tradeboard.imageName != 'noImage'}">
							<div class="image-container"
								style="width: 200px; height: 200px; object-fit: cover;">
								<img src="${imgUrl}/boardFile/3_${tradeboard.imageName}.png"><br>
							</div>
							<button id="del_img">이미지 삭제</button>
						</c:if>
						</div>
						<br>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<label for="formFileMultiple" class="form-label"></label> <input
								class="form-control" type="file" id="formFileMultiple"
								name="file">
						</div>
						<br>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<input type="radio" id="region0" name="region" value="0">전체
							<input type="radio" id="region1" name="region" value="1">서울
							<input type="radio" id="region2" name="region" value="2">경기
							<input type="radio" id="region3" name="region" value="3">충청
							<input type="radio" id="region4" name="region" value="4">경상
							<input type="radio" id="region5" name="region" value="5">전라
							<input type="radio" id="region6" name="region" value="6">강원
						</div>
						<br>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<input type="radio" id="itemClass0" name="itemClass" value="0">전체
							<input type="radio" id="itemClass1" name="itemClass" value="1">의류
							<input type="radio" id="itemClass2" name="itemClass" value="2">라켓
							<input type="radio" id="itemClass3" name="itemClass" value="3">보호대
							<input type="radio" id="itemClass4" name="itemClass" value="4">신발
							<input type="radio" id="itemClass5" name="itemClass" value="5">기타
						</div>
						<br>
						<div class="mb-3" style="width: 70%; margin: 0 auto;">
							<input type="checkbox" id="complete" name="complete" value="1">판매완료
						</div>
						<input name="imageName" type="hidden"
							value="${tradeboard.imageName}">
						<div class=button-container>
							<button type="submit" class="btn btn-primary whyBtn">글
								수정</button>
							<button type="button" class="btn btn-primary CancleBtn"
								onclick="location.href='/Tradeboard'">취&nbsp; 소</button>
						</div> --%>

						<input type="hidden" id="tradeboardId" name="tradeboardId"
							value="${tradeboard.tradeboardId}" /> <input type="hidden"
							id="userId" name="userId" value="${tradeboard.userId}" /> <input
							name="imageName" type="hidden" value="${tradeboard.imageName}">

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
									<td style="text-align: left; padding-left: 10px;"><input
										type="text" class="form-control1" name="title"
										id="exampleFormControlInput1" value="${tradeboard.title}">
									</td>
									<th scope="row" bgcolor="#F9F9F9">작성일</th>
									<td scope="row" style="text-align: left; padding-left: 10px;">
										<fmt:formatDate value="${tradeboard.regdate}"
											pattern="yyyy-MM-dd HH:mm" />
									</td>
								</tr>
								<tr>
									<th scope="row" bgcolor="#F9F9F9">작성자</th>
									<td scope="row"
										style="text-align: left; padding-left: 10px; font-weight: bold;">
										${tradeboard.userId}</td>
									<th scope="row" bgcolor="#F9F9F9">판매여부</th>
									<td style="text-align: left; padding-left: 10px;"><input
										type="checkbox" id="complete" name="complete" value="1">판매완료
									</td>
								</tr>
								<tr>
									<th scope="row" bgcolor="#F9F9F9">지역</th>
									<td colspan="4"><label><input type="checkbox"
											id="region0" name="regions" value="0">전체</label> <label><input
											type="checkbox" id="region1" name="regions" value="1">서울</label>
										<label><input type="checkbox" id="region2"
											name="regions" value="2">경기</label> <label><input
											type="checkbox" id="region3" name="regions" value="3">충청</label>
										<label><input type="checkbox" id="region4"
											name="regions" value="4">경상</label> <label><input
											type="checkbox" id="region5" name="regions" value="5">전라</label>
										<label><input type="checkbox" id="region6"
											name="regions" value="6">강원</label></td>
								</tr>
								<tr>
									<th scope="row" bgcolor="#F9F9F9">물품</th>
									<td colspan="4"><label><input type="radio"
											id="itemClass0" name="itemClass" value="0">전체</label> <label><input
											type="radio" id="itemClass1" name="itemClass" value="1">의류</label>
										<label><input type="radio" id="itemClass2"
											name="itemClass" value="2">라켓</label> <label><input
											type="radio" id="itemClass3" name="itemClass" value="3">보호대</label>
										<label><input type="radio" id="itemClass4"
											name="itemClass" value="4">신발</label> <label><input
											type="radio" id="itemClass5" name="itemClass" value="5">기타</label>
									</td>
								</tr>
								<tr>
									<th scope="row" bgcolor="#F9F9F9">첨부파일</th>
									<td colspan="4" style="text-align: center;"><input
										class="form-con" type="file" id="formFileMultiple" name="file">
										<c:if test="${tradeboard.imageName != 'noImage'}">
											<div class="image-container"
												style="display: flex; flex-direction: column;">
												<img src="${imgUrl}/boardFile/3_${tradeboard.imageName}.png"
													style="width: 100%; height: 150px;">
												<div style="margin: 10px 10px 5px 10px;">
													<!-- 파일 삭제 버튼 -->
													<button id="del_img">이미지 삭제</button>
												</div>
											</div>
										</c:if> <c:if test="${tradeboard.imageName eq 'noImage'}">
											<button id="del_img" style="display: none">이미지 삭제</button>
										</c:if></td>
								</tr>
								<tr>
									<th scope="row" bgcolor="#F9F9F9">내용</th>
									<td colspan="4" style="padding: 10px;"><textarea
											class="form-control " name="content" id="ckeditor" rows="6">${tradeboard.content}</textarea>
									</td>
								</tr>
							</tbody>
						</table>
						<div class=button-container>
							<button type="button" class="btn btn-primary CancleBtn"
								onclick="location.href='/Tradeboard'">취&nbsp; 소</button>
							<button type="submit" class="btn btn-primary whyBtn">글
								수정</button>
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
	
	window.onload = function(){
		var regionList = [];
		for (var i = 0; i <= 6; i++) {
		    var region = document.getElementById('region' + i);
		    regionList.push(region);
		}
		regionList.forEach(function(region, index){
			console.log(region.value);
			${regionList}.forEach(function(region1){
				if(region1 == region.value){
					region.checked = true;
				}
			})
		});
		
		var itemList = [];
		for(var i = 0; i <= 5; i++){
			var item = document.getElementById('itemClass' + i);
			itemList.push(item);
		}
		itemList.forEach(function(item){
			if('${tradeboard.itemClass}' === item.value){
				item.checked = true;
			}
		});
		
		var complete = document.getElementById('complete');
		if('${tradeboard.complete}' == 1){
			complete.checked = true;
		}
	}
	
	var allRegionCheckbox = document.getElementById("region0");
	// 다른 지역 체크박스 요소들을 가져옵니다.
	var regionCheckboxes = document.querySelectorAll("input[name='regions']:not([value='0'])");

	// 전체 지역 체크박스의 변경 이벤트에 대한 이벤트 리스너를 추가합니다.
	allRegionCheckbox.addEventListener("change", function() {
	    // 전체 지역 체크박스가 체크되었는지 확인합니다.
	    if (allRegionCheckbox.checked) {
	        // 만약 체크되었다면 나머지 지역 체크박스들의 체크를 지웁니다.
	        regionCheckboxes.forEach(function(checkbox) {
	            checkbox.checked = false;
	        });
	    }
	});
	
	regionCheckboxes.forEach(function(checkbox) {
	    checkbox.addEventListener("change", function() {
	        if (allRegionCheckbox.checked) {
	            allRegionCheckbox.checked = false;
	        }
	    });
	});
	
	document.getElementById("del_img").addEventListener("click", function() {
	// 이벤트의 기본동작을 막아서 페이지 이동이 바로 이루어지지 않게 했음. 
	event.preventDefault();
    document.querySelector(".image-container").style.display = "none";
    document.querySelector("input[name='imageName']").value = "";
});

</script>
</html>
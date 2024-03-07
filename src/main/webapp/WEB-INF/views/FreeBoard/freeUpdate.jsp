<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="../resources/ckeditor/build/ckeditor.js"></script>
<!-- <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script> -->
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
    .mainTitle{
        text-align: center;
    }

    .whyBtn{
        margin-left: 46%;
    }
    h1{
        padding-top: 30px;
        padding-bottom: 30px
    }
</style>
<body>
<!-- 헤더 -->
<%@ include file="../include/header.jsp"%>

<!-- 붙혀 넣는곳! -->

    <div class="mainTitle">
        <h1>Free Board</h1>
    </div>
    <form action="<c:url value='/Freeboard/updateFree'/>" method="post">
    <div class="mb-3" style="width: 50%; margin: 0 auto;">
            <label for="exampleFormControlInput1" class="form-label">제목</label>
            <input type="text" class="form-control" name="freeboard_title" id="exampleFormControlInput1" value="${Detail.title}" >
          </div>
          <div class="row g-3" style="width: 51%; margin: 0 auto; margin-top: -25px" >
		  <div class="col">
		   <label for="exampleFormControlInput1" class="form-label">작성자</label>
		    <input type="text" class="form-control" id="exampleFormControlInput1" value="${Detail.user_userId}" readonly>
		  </div>
		  <div class="col">
		   <label for="exampleFormControlInput1" class="form-label">작성 날짜</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" value="${Detail.regdate}" readonly>
		  </div>
		</div>
         <div class="mb-3" style="width: 50%; margin: 0 auto;">
            <label for="exampleFormControlTextarea1" class="form-label">내용</label>
            <textarea class="form-control " name="freeboard_content" id="ckeditor" rows="6">${Detail.content}</textarea>
          </div>
          
          <input type="hidden" value="${Detail.freeboardId}" name ="freeboard_no">
          <button type="button" class="btn btn-primary whyBtn">글 수정</button>
          <button type="button" class="btn btn-primary CancleBtn">취 &nbsp; 소</button>
    </form>


<!-- 푸터 -->
<%@include file="../include/footer.jsp"%>
<script type="text/javascript">
$(function() {
	$('.whyBtn').click(function() {
		$("form").submit();
	});
	
	$('.CancleBtn').click(function() {
		location.href = "<c:url value='/Freeboard/freeList'/>";
	})
	 CKEDITOR.replace( 'ckeditor', {//해당 이름으로 된 textarea에 에디터를 적용
         width:'100%',
         height:'400px',
         filebrowserUploadUrl:  "fileupload.do"
     }); 

});
</script>
</body>
</html>
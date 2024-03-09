<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
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
    .whyBtn1{
        margin-left: 69%;
    }
    .del-btn{
        margin-left: 95%
    }
    h1{
        padding-top: 30px;
        padding-bottom: 30px
    }
</style>
<body>
<!-- 헤더 -->
<%@ include file="../include/header.jsp"%>


<!-- 붙혀 넣는곳 -->
    <div class="mainTitle">
        <h1>거래게시판</h1>
    </div>
  
        <div class="mb-3" style="width: 50%; margin: 0 auto;">
            <label for="exampleFormControlInput1" class="form-label">제목</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" value="${tradeboard.title}" readonly>
          </div>
          <div class="row g-3" style="width: 51%; margin: 0 auto; margin-top: -25px" >
		  <div class="col">
		   <label for="exampleFormControlInput1" class="form-label">작성자</label>
		    <input type="text" class="form-control" id="exampleFormControlInput1" value="${tradeboard.user_userId}" readonly>
		  </div>
		  <div class="col">
            <label for="exampleFormControlInput1" class="form-label">작성시간</label> 
			<input type="text" class="form-control"id="exampleFormControlInput2" value="${tradeboard.regdate}" readonly>
		  </div>
		</div>
		<div class="row g-3" style="width: 51%; margin: 0 auto; margin-top: -10px" >
		 <div class="col">
		   <label for="exampleFormControlInput1" class="form-label">조회수</label>
		    <input type="text" class="form-control" id="exampleFormControlInput1" value="${tradeboard.hit}" readonly>
		  </div>
		  <div class="col">
		   <label for="exampleFormControlInput1" class="form-label">거래여부</label>
		   <c:choose>
		   	<c:when test="${tradeboard.complete eq 1}">
		   		<input type="text" class="form-control" id="exampleFormControlInput1" value="거래완료" readonly>
		   	</c:when>
		   	<c:when test="${tradeboard.complete eq 0}">
		   		<input type="text" class="form-control" id="exampleFormControlInput1" value="판매중" readonly>
		   	</c:when>
		   </c:choose>
		  </div>
		  <%-- <div class="col">
		   <label for="exampleFormControlInput1" class="form-label">추천</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" value="${getLike}" readonly>
		  </div> --%>
		</div>
		
          <div class="mb-3" style="width: 50%; margin: 0 auto;">
            <label for="exampleFormControlTextarea1" class="form-label"></label>
            <div>
         		${tradeboard.content}
            </div>
          </div>

          <button type="button" class="btn btn-primary whyBtn updateBtn">수정</button>
          <button type="button" class="btn btn-primary CancleBtn listBtn">목록</button>
		  <button type="button" class="btn btn-primary CancleBtn delbtn">삭제</button>
		  <button type="button" class="btn btn-primary CancleBtn LikeBtn">추천</button>
          <!-- 댓글 -->

        
        <div class="mb-3" style="width: 50%; margin: 0 auto;">
            <label for="exampleFormControlInput1" class="form-label">댓글 작성자</label>
            <input type="text" class="form-control writerId" id="exampleFormControlInput1" name="writerId" value="${login.userId}">
          </div>
          <div class="mb-3" style="width: 50%; margin: 0 auto;">
            <label for="exampleFormControlTextarea1" class="form-label">댓글 내용</label>
            <textarea class="form-control content" id="exampleFormControlTextarea1" rows="2" name="content"></textarea>
          </div>
       <button type="button" class="btn btn-primary whyBtn1" id="com_btn">댓글 등록</button>

        
        <!-- 댓글이 들어갈 부분 -->
        <div class="com_box">

        </div>


<!-- 푸터 -->
<%@include file="../include/footer.jsp"%>
</body>

<script>
	
//leagueboard.regdate 값을 포맷팅하여 input 태그에 적용
var regdate = "${tradeboard.regdate}";
var formattedDate = new Date(regdate).toLocaleString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit'}); // 날짜 포맷팅
document.getElementById("exampleFormControlInput2").value = formattedDate;
	
	//RedirectAttributes 로 던져서 메시지 출력
	const msg = '${msg}';
	if(msg !== '') {
		alert("게시물 수정 완료되었습니다.");
	}
	
	
	$(function() { // 스크립트 시작문
		
		
		
		// 글수정
		$('.updateBtn').click(function() {
			location.href = "/Tradeboard/update?tradeboardId=${tradeboard.tradeboardId}";
		})
		// 삭제
		/* $('.delbtn').click(function() {
			if(!confirm("해당 게시물을 삭제 하시겠습니까?")){
				return;
			}else{
				location.href = "<c:url value='/Tradeboard/deleteFree?freeboardId=${Detail.freeboardId}'/>";
			}
		}) */
		
		$('.delbtn').click(function() {
			if(!confirm("해당 게시물을 삭제 하시겠습니까?")){
				return;
			}else{
				$.ajax({
					type : "DELETE",
					url : "/Tradeboard?tradeboardId=${tradeboard.tradeboardId}",
					success : function(){
						alert : "sdf";
					} //success
				}) // ajax
			}
		})
		
		
		// 좋아요 
		var likeval = ${likes};
		
		let freeboardId = ${Detail.freeboardId};
		let userId = '${login.userId}';
		let likeType = 1;
		
		if(likeval > 0){
			console.log(likeval + "추천 누름");
			$('.LikeBtn').html("추천 취소");
			$('.LikeBtn').click(function() {
				$.ajax({
					type :'post',
					url : '<c:url value ="/Freeboard/likeDown"/>',
					contentType: 'application/json',
					data : JSON.stringify(
							{
								"freeboardId" : freeboardId,
								"userId" : userId,
								"likeType" : likeType
							}		
						),
					success : function(data) {
						alert('취소 성공');
					}
				})// 아작스 끝
			})

		}else{
			console.log(likeval + "추천 안누름")
			console.log(userId);
			$('.LikeBtn').click(function() {
				$.ajax({
					type :'post',
					url : '<c:url value ="/Freeboard/likeUp"/>',
					contentType: 'application/json',
					data : JSON.stringify(
							{
								"freeboardId" : freeboardId,
								"userId" : userId,
								"likeType" : likeType
							}		
						),
					success : function(data) {
						alert('성공');
					}
				})// 아작스 끝
			})
		
			
		}
			
		
		
		$('.listBtn').click(function() {
			location.href = '<c:url value="/Freeboard/freeList"/>';
		})
		
		
		// 댓글
		$('#com_btn').click(function() {
			const writerId = $('.writerId').val();
			const content = $('.content').val();
			const bno = ${Detail.freeboardId};
			const comment_type = 0; 
			
			if(writerId == ''){
				alert('아이디를 입력해주세요');
				return;
			}else if(content == ''){
				alert('내용을 입력해주세요');
				return;
			}else{
				$.ajax({
					type : 'post',
					url: '<c:url value="/com/insertCom"/>',
					data : JSON.stringify(
						{
							"writerId" : writerId,
							"content" : content,
							"bno" : bno,
							"comment_type" : comment_type 
						}		
					),
					contentType: 'application/json',
					success: function(data) {
						console.log('통신성공' + data);
						if(data == 'ok'){
							alert("댓글 등록 성공");
							getList();
						}
					},	error : function(status, error) {
						console.log('에러발생!!');
						console.log(status, error);
					}
				});//아작스 끝
			} //  else 문 끝
		})// 댓글 등록 끝
		getList(); 
	
	
		
		// 목록
		function getList() {
			const bno = ${Detail.freeboardId};
			const comment_type = 0; 
			const writerId = $('.writerId').val();
			const content = $('.content').val();
			
			$.getJSON(
				"<c:url value = '/com/getList/'/>" + bno + "/"+ comment_type,
				function(data) {
					console.log(data.total);
					if(data.total > 0){
						var list = data.getList;
						let str = "";
						for(i = 0; i<list.length; i++){
							let writerId = list[i].writerId;
							let content = list[i].content;
							let commentsId = list[i].commentsId;
							console.log(commentsId);
							console.log(content);
							str += "<div>";
							str += "<div class='' style='width: 50%; margin: 0 auto;'>"
							str += "<label for 'exampleFormControlInput1' class='form-label'>Comment Writer :"+writerId+"</label>"
							str += "&nbsp;&nbsp;&nbsp;<span id='asdfg' style='cursor:pointer' data-id = '"+commentsId+"'>삭제</span>&nbsp;&nbsp;</span>"
							str += "<textarea class='form-control' id='exampleFormControlTextarea1' rows='3' readonly>"+content+"</textarea>"
							str += " </div>"
						}
						
						$('.com_box').html(str);
						
					}else{
						str = "<div>";
						str = "<div class='' style='width: 50%; margin: 0 auto;'>"
						str = "&nbsp;&nbsp;&nbsp;<a href='#' >삭제</a></span>"
						str = "<textarea class='form-control' id='exampleFormControlTextarea1' rows='3' readonly>등록된 댓글이 없습니다</textarea>"
						str = " </div>"
						$('.com_box').html(str);
					}
				}
			)
			
		}
		
		
		$(document).on('click','#asdfg', function() {
			const commentsId = $(this).data('id');
			console.log(commentsId)
			
			$.ajax({
				url : '<c:url value = "/com/comDelete" />',
				type : 'post',
				data:JSON.stringify(
		                  {
		                	  /* "com_bno":com_bno, */
		                     "commentsId":commentsId
		                  }),
		                  headers : {
		  					'Content-type' : 'application/json'
		  				},
				success : function(data) {
					alert('삭제완료')
					getList();
				}
				
			})// 삭제 아작스 끝
			
		})
		
		
		
		
	})// 스크립트 종료문
</script>
</html>
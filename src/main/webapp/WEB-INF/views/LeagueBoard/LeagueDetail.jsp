<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Muti 게시판</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<link href="/resources/css/layout1.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/layout2.css" rel="stylesheet" type="text/css" />
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>
<div id = "wrap">
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<%@ include file="category.jsp"%>
    
    <!-- main  -->
	<main id="main">
		<section class="notice">
			<div class="page-title">
				<div class="container">
				</div>
			</div>
			
			<form action="/LeagueBoard/update/${leagueboardId}" method="GET" name="detailForm" id="detailForm">
			    <div id="board-list">
		        	<div class="container">
					    <table class="board-table"> 
				            <tbody>
				                <tr>
				                    <th scope="row" bgcolor="#F9F9F9">번호</th>
				                    <td>${leagueboard.leagueboardId}</td>
				                </tr>
				                <tr>
				                    <th scope="row" bgcolor="#F9F9F9">작성자</th>
				                    <td>${leagueboard.user_userId}</td>
				                    <th scope="row" bgcolor="#F9F9F9">등록일</th>
				                    <td><fmt:formatDate value="${leagueboard.regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
				                </tr>
				                <tr>
				                    <th scope="row" bgcolor="#F9F9F9">제목</th>
				                    <td colspan="4">
				                       ${leagueboard.title}
				                    </td>
				                </tr>
				                <tr>
				                    <th scope="row" bgcolor="#F9F9F9">내용</th>
				                    <td colspan="4">
				                        ${leagueboard.content}
				                    </td>
				                </tr>
				                <tr>
				                    <th scope="row" bgcolor="#F9F9F9">승자</th>
				                    <td colspan="4">
				                        ${leagueboard.winner}
				                    </td>
				                </tr>
				                <tr>
				                    <th scope="row" bgcolor="#F9F9F9">패자</th>
				                    <td colspan="4">
				                        ${leagueboard.loser}
				                    </td>
				                </tr>
				            </tbody>
				        </table>
				        <%-- <c:if test="${sessionScope.userId eq board.userId or sessionScope.admin === 1}"> --%>
							<input type="submit" value="수정" class="Btn">
						<%-- </c:if> --%>
		        	 </div>
		    	</div>
	   		</form>
			<div class="container" style="height:50px;">
				<span style="font-size:12pt; float: left; margin-right:7px;"><input type="button" value="글 목록" class="Btn" onclick="location.href='/LeagueBoard'"></span>
				<%-- <c:if test="${sessionScope.userId eq board.userId or sessionScope.admin === 1}"> --%>
					<button type="button" class="delete_btn btn btn-danger">삭제</button>
				<%-- </c:if> --%>
			</div>
			
		 </section> 	
   	</main>
   	
   	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
   	
</div>	
	<script type="text/javascript">
		
		document.addEventListener("DOMContentLoaded", function () {
		    // 삭제 버튼 클릭 이벤트를 처리합니다.
		    document.querySelector(".delete_btn").addEventListener("click", function (e) {
		    	e.preventDefault();
		    	
		    	// 알림을 통해 사용자에게 삭제 여부를 확인할 수 있습니다.
		        var isConfirmed = confirm("게시글을 삭제하시겠습니까?");

		        if (isConfirmed) {
		            // 액시오스를 사용하여 서버로 DELETE 요청을 보냅니다.
		            axios.delete('/LeagueBoard/${leagueboard.leagueboardId}')
		            .then(function (response) {
		            	//ResponseEntity.ok 보내주면
		                console.log(response.data);
		                alert("게시글이 삭제되었습니다.");
		                window.location.href = "/LeagueBoard";
		            })
		            .catch(function (error) {
		                // 아닐시
		                console.error('Error during board deletion:', error);
		                alert("게시글 삭제 실패");
		            });
		        }
		    });
		});
		
	</script>
</body>
</html>
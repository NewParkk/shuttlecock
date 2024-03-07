<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Muti 게시판</title>
<meta charset="UTF-8">
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script> -->
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
	            <h3>리그 결과 수정</h3>
	        </div>
		  </div>
		  
		    <%-- <c:if test="${not empty sessionScope.userId}"> 110번째줄 --%>
			<form action="/LeagueBoard/update" method="POST" enctype="application/x-www-form-urlencoded">
			    <div id="board-list">
			    <input type="hidden" id="leagueboardId" name="leagueboardId" value="${leagueboard.leagueboardId}"/>
		        	<div class="container">
					    <table class="board-table"> 
				            <tbody>
				                <tr>
				                    <th scope="row" bgcolor="#F9F9F9">제목</th>
				                    <td colspan="4">
				                       <input type="text" id="title" name="title" value="${leagueboard.title}"/>
				                    </td>
				                </tr>
				                <tr>
				                    <th scope="row" bgcolor="#F9F9F9">경기 내용</th>
				                    <td colspan="4">
				                        <input type="text" id="content" name="content" value="${leagueboard.content}"/>
				                    </td>
				                </tr>
				                <tr>
				                    <th scope="row" bgcolor="#F9F9F9">승자</th>
				                    <td colspan="4">
				                       <input type="text" id="winner" name="winner" value="${leagueboard.winner}"/>
				                    </td>
				                </tr>
				                <tr>
				                    <th scope="row" bgcolor="#F9F9F9">패자</th>
				                    <td colspan="4">
				                        <input type="text" id="loser" name="loser" value="${leagueboard.loser}"/>
				                    </td>
				                </tr>
				            </tbody>
				        </table>
				        
						<span style="font-size:12pt; float: right;">
							<input type="reset" value="다시작성" class="Btn">
							<input type="submit" value="등록" class="Btn">
						</span>
		        	 </div>
		    	</div>
	   		</form>

			<div class="container">
				<span style="font-size:12pt; float: left; margin-right:7px;"><input type="button" value="글 목록" class="Btn" onclick="location.href='/LeagueBoard'"></span>
			</div>
			
		  <%-- </c:if> --%>
	 	
	 	<%-- <c:if test="${empty sessionScope.userId}">
					<script>
						function redirectToLoginPage() {
							window.location.href = "/login";
						}
					</script>
				</c:if> --%>
		
		</section>
   </main>
   
   <%@ include file="/WEB-INF/views/include/footer.jsp" %>
   
</div>	

</body>
</html>
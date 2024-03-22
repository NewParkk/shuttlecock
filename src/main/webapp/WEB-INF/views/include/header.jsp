<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="/css/mainstyle.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<!-- header -->
<header id="header">
  <div class="inner1">
    <div class="container">
    <c:if test="${empty sessionScope.userId}">
      <input type="button" class="Btn" value="Login" onclick="location.href='/login'" />
      <div class="v-line"></div>
      <input type="button" class="Btn" value="Join" onclick="location.href='/join'" />
    </c:if>
    <c:if test="${not empty sessionScope.userId}">
    	<c:if test="${kakaoYN eq true}">
    		<strong class="Btn">
    		<img src="https://kr.object.ncloudstorage.com/team1bucket/badge/${sessionScope.badgeId}.png"
			width="30px" height="25px" style="margin-right:10px;">${sessionScope.username} 님</strong>
			
			<!-- 토글 창 -->
			<div id="user_actions" style="display: none;">
				<div>
			        <c:if test="${user.userImageName eq null}">
						<img src="https://kr.object.ncloudstorage.com/team1bucket/profile/noprofile.png">
					</c:if>
					<c:if test="${user.userImageName != null}">
						<img src="https://kr.object.ncloudstorage.com/team1bucket/profile/${user.userImageName}">
					</c:if>
			        <a href="/mypage" style="color:#333;">${sessionScope.username} 님</a>
				</div>
				
		        <div class="line"></div>
		        
		        <!-- 관리자이면 -->
		        <c:if test="${isAdmin eq true}">
				    <button id="profile" onClick="location.href='/admin'" style="margin-bottom:10px;">관리자 페이지</button>
				</c:if>
				<c:if test="${isAdmin eq false}">
				     <button id="profile" onclick="location.href='/updateUser'">내 프로필</button>
				</c:if>
				
		        <button id="logout" onClick="location.href='/logout'">로그아웃</button>
		    </div> 
			
    	</c:if>
				 
		<c:if test="${kakaoYN eq false}">
      		<strong class="Btn">
      		<img src="https://kr.object.ncloudstorage.com/team1bucket/badge/${sessionScope.badgeId}.png"
		width="30px" height="25px" style="margin-right:10px;">${sessionScope.userId} 님</strong>  
			
			<!-- 토글창 -->
			<div id="user_actions" style="display: none;">
				<div>
			        <c:if test="${user.userImageName eq null}">
						<img src="https://kr.object.ncloudstorage.com/team1bucket/profile/noprofile.png">
					</c:if>
					<c:if test="${user.userImageName != null}">
						<img src="https://kr.object.ncloudstorage.com/team1bucket/profile/${user.userImageName}">
					</c:if>
			        <a href="/mypage" style="color:#333;">${sessionScope.userId} 님</a>
				</div>
				
		        <div class="line"></div>
		        
		        <!-- 관리자이면 -->
		        <c:if test="${isAdmin eq true}">
				    <button id="profile" onClick="location.href='/admin'" style="margin-bottom:10px;">관리자 페이지</button>
				</c:if>
				<c:if test="${isAdmin eq false}">
				     <button id="profile" onclick="location.href='/updateUser'">내 프로필</button>
				</c:if>
				
		        <button id="logout" onClick="location.href='/logout'">로그아웃</button>
		    </div>  	
   		</c:if>       
    </c:if>   
    </div>
    <hr />
  </div>

  <div class="inner2">
    <div class="logo">
      <img src="/img/shuttle-logo.jpg" alt="Logo" onclick="location.href='/main'" />
    </div>
    <nav class="nav">
      <ul>
        <li>
          <h3><a href="/Announcement/">About 배드민턴</a></h3>
          <ul class="submenu">
            <li><a href="/Announcement/">공지사항</a></li>
            <li><a href="/getNews">정보게시판</a></li>
            <li><a href="/getGame">정규대회 일정</a></li>
          </ul>
        </li>
        <li>
          <h3><a href="/Freeboard/freeList">Community</a></h3>
          <ul class="submenu">
            <li><a href="/Freeboard/freeList">자유게시판</a></li>
            <li><a href="/Tradeboard">물품거래소</a></li>
          </ul>
        </li>
        <li>
          <h3><a href="/Recruitboard">Meeting</a></h3>
          <ul class="submenu">
            <li><a href="/Recruitboard?recruitType=1">League</a></li>
            <li><a href="/Recruitboard?recruitType=3">단식</a></li>
            <li><a href="/Recruitboard?recruitType=4">복식</a></li>
          </ul>
        </li>
        <li>
          <h3><a href="/LeagueBoard">League</a></h3>
          <!-- 수정: h2를 h3로 변경 -->
          <ul class="submenu">
            <li><a href="/LeagueBoard">리그게시판</a></li>
            <li><a href="/LeagueBoardRanking">리그 순위</a></li>
          </ul>
        </li>
      </ul>
    </nav>
  </div>
</header>


<script>

//nav관련 script
$(function () {
    $(".nav > ul > li").mouseover(function () {
      $(".nav > ul > li > ul").stop().slideDown(400);
      $("#header").addClass("on");
    });

    $(".nav > ul > li").mouseout(function () {
      $(".nav > ul > li > ul").stop().slideUp(100);
      $("#header").removeClass("on");
    });
  });
  
$(document).ready(function() {
    $('.Btn').click(function() {
        $('#user_actions').toggle();
    });
});
</script>
<style>
.Btn {
    position: relative;
    display: flex;
    justify-content: center;
    align-items: center;
}

#user_actions {
    position: absolute;
    top: 50px;
    right: 0;
    background: #fff;
    border: 2px solid #ddd;
    border-radius: 5px;
    padding: 10px;
    text-align: center; 
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    width: 200px;
}

#user_actions img {
    display: block;
    margin: 0 auto 10px; 
    width: 100px;
    height: 80px;
    border-radius:50%;
}

#user_actions .user_buttons {
    display: flex; 
    justify-content: center; 
}
#user_actions .line {
    border-top: 1px solid #ccc; 
    margin: 10px auto; 
    width: 100%;
}
#user_actions button {
    padding: 7px 9px;
    background-color: #405448;
    color: white;
    border: none;
    cursor: pointer;
    transition: background-color 0.3s;
    margin: 0 6px; 
    border-radius:10px;
}
#profile{
	margin-right:30px;
}

#user_actions button:hover {
    background-color: #7DA487;
}
</style>

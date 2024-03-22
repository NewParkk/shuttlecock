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
    		<a href="/mypage">
    		<img src="https://kr.object.ncloudstorage.com/team1bucket/badge/1.png"
			width="30px" height="25px">${username} 님</a></strong>
    	</c:if>
    	<c:if test="${kakaoYN eq false}">
       		<strong class="Btn"><a href="/mypage">
       		<img src="https://kr.object.ncloudstorage.com/team1bucket/badge/1.png"
			width="30px" height="25px">${userId} 님</a></strong>    		
    	</c:if>
    	<div class="v-line"></div>
        <button type="button" class="Btn" onClick="location.href='/logout'">Logout</button>
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
          <h3><a href="#">About 배드민턴</a></h3>
          <ul class="submenu">
            <li><a href="/Announcement/">공지사항</a></li>
            <li><a href="/getNews">정보게시판</a></li>
            <li><a href="/getGame">정규대회 일정</a></li>
          </ul>
        </li>
        <li>
          <h3><a href="#">Community</a></h3>
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
</script>

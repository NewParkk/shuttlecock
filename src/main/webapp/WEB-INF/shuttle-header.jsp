<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
       	<strong class="Btn">${userId} 님</strong>
       	<div class="v-line"></div>
        <button type="button" class="Btn" onClick="location.href='/logout'">Logout</button>
    </c:if>   
    </div>
    <hr />
  </div>

  <div class="inner2">
    <h1 class="logo">
      <img src="/img/shuttle-logo.jpg" alt="Logo" onclick="location.href='/main'" />
    </h1>
    <nav class="nav">
      <ul>
        <li>
          <h3><a href="#">About 배드민턴</a></h3>
          <ul class="submenu">
            <li><a href="#">배드민턴이란?</a></li>
            <li><a href="#">배드민턴 News</a></li>
            <li><a href="#">배드민턴 Video</a></li>
          </ul>
        </li>
        <li>
          <h3><a href="#">Community</a></h3>
          <ul class="submenu">
            <li><a href="#">자유게시판</a></li>
            <li><a href="#">물품거래소</a></li>
            <li><a href="#">운동장소찾기</a></li>
          </ul>
        </li>
        <li>
          <h3><a href="#">Meeting</a></h3>
          <ul class="submenu">
            <li><a href="#">단식</a></li>
            <li><a href="#">복식</a></li>
            <li><a href="#">league</a></li>
          </ul>
        </li>
        <li>
          <h3><a href="#">League</a></h3>
          <!-- 수정: h2를 h3로 변경 -->
          <ul class="submenu">
            <li><a href="#">리그승률</a></li>
            <li><a href="#">리그순위</a></li>
          </ul>
        </li>
      </ul>
    </nav>
  </div>
</header>

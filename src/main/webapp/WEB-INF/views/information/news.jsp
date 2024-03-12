<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shuttle Cock</title>
    <link rel="stylesheet" href="/css/mainstyle.css">
    <link rel="stylesheet" href="/css/aside.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
 
    <!-- header -->
    <%@ include file="/WEB-INF/views/include/header.jsp"%>

	<!-- main -->
	<main id="main">
        <section id="section">
        
          <!-- aside -->
          <div class="aside">
            <div class="menubar">
              <ul>
                <li><a href="#">HOME</a></li>
                <li><a href="#">배드민턴이란?</a></li>
                <li><a href="/getNews">배드민턴 정보</a></li>
                <li><a href="#">정규대회 일정</a></li>
              </ul>
            </div>
          </div>

		  <!-- contents -->
          <div class="contents">
            <div class="title">
              <div class="vline"></div>
              <h2>정보게시판</h2>
            </div>
            
            <!-- 새로고침 -->
            <img id="restartBtn" src="/img/restart.jpg" alt="새로 고침" width="25" height="25" style="float:right; margin-right:27px; margin-bottom: 10px; cursor: pointer;">
            
			<!-- 기사 -->
            <div class="article">
            	<c:if test="${not empty newsList}">
			        <c:forEach items="${newsList}" var="news">
			            <div class="newslist">
			                <a href="${news.url}"><img src="${news.image}" alt="뉴스 이미지" width="175" height="126"></a>
			                <div class="con">
			                	<p style="text-align:right;"><fmt:formatDate value="${news.updateDate}" pattern="yyyy-MM-dd"/></p>
				                <h4><a href="${news.url}">${news.title}</a></h4>
				                <p style="height: 40px;">${news.content}</p>
			                </div>
			            </div>
			        </c:forEach>
			    </c:if>
            </div>
            
            <!-- 영상 -->
            <div class="info">
              <iframe
                width="350"
                height="228"
                src="https://www.youtube.com/embed/Bu5I-NiglAw?si=h3TKilOaytJLILgS"
                title="YouTube video player"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                allowfullscreen
              ></iframe>
              <iframe
                width="350"
                height="228"
                src="https://www.youtube.com/embed/S-2RNGv8m2Q?si=PjCkK_1pFUqUFrVd"
                title="YouTube video player"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                allowfullscreen
              ></iframe>
              <iframe
                width="350"
                height="228"
                src="https://www.youtube.com/embed/23Ekg9Cp26U?si=1XUt_kJPbNzb55En"
                title="YouTube video player"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                allowfullscreen
              ></iframe>

              <iframe width="350" height="230" src="https://www.youtube.com/embed/MuDHVnDUnxk?si=PPN6l-qd_Ghv6cBX" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
              <iframe
                width="350"
                height="228"
                src="https://www.youtube.com/embed/7SxFQ59_VlU?si=RGW89CrEnKPd_-Um"
                title="YouTube video player"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                allowfullscreen
              ></iframe>
              <iframe
                width="350"
                height="228"
                src="https://www.youtube.com/embed/RXrr4slfaxE?si=nGXdfZNp-tLtygVx"
                title="YouTube video player"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                allowfullscreen
              ></iframe>
              <!-- <a class= "prev">&#10094</a>
              <a class= "prev">&#10095</a> -->
            </div>
            
          </div>
        </section>
      </main>

	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</div>
<script>
/* 새로고침 버튼 */
document.getElementById("restartBtn").addEventListener("click", function() {
    fetch("/insertNews", {
        method: "GET" 
    }).then(function(response) {
        return fetch("/getNews"); 
    }).then(function(response) {
    }).catch(function(error) {
        console.error('Error:', error);
    });
});
</script>
</body>
</html>
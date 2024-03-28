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
    <script src="/js/aside-js.js"></script>
<style>
.imageWrap1 {
  width: 100%;
  height: 140px;
  background: url("/img/badminton-bg.jpg") repeat;
  background-size: contain;
}
</style>
</head>
<body>
<!-- wrap -->
<div id="wrap">
 
    <!-- header -->
    <%@ include file="/WEB-INF/views/include/header.jsp"%>

	<!-- main -->
	<main id="main">
		<div id="slider">
          <div class="imageWrap1"></div>
        </div>
        
        <!-- section -->
        <section id="section">
        
          <!-- aside -->
          <div class="aside">
            <div class="menubar">
              <ul>
                <li><a class="list" href="/Announcement/">공지사항</a></li>
                <li><a class="list" href="/getNews">배드민턴 정보</a></li>
                <li><a class="list" href="/getGame">정규대회 일정</a></li>
              </ul>
            </div>
          </div>

		  <!-- contents -->
          <div class="contents">
            <div class="title2">
              <div class="vline"></div>
              <h2>정보게시판</h2>
            </div>
            
            <!-- 영상 -->
            <div class="info">
	          <div class="infotitle" style="display: flex; margin: 30px 25px 0px 25px; margin-left: 15px;">
	             <div class="vline" style="height: 25px;"></div>
	             <h4 style="font-weight: 400; text-align: left; margin-left: 10px;">배트민턴 관련 영상</h4>
	          </div>
              <span class= "prev">&#10094</span>
              <div class="inslide">
                <ul class="information">
                  <li><iframe width="350" height="228" src="https://www.youtube.com/embed/23Ekg9Cp26U?si=1XUt_kJPbNzb55En" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe></li>
                  <li><iframe width="350" height="228" src="https://www.youtube.com/embed/S-2RNGv8m2Q?si=PjCkK_1pFUqUFrVd" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe></li>
                  <li><iframe width="350" height="228" src="https://www.youtube.com/embed/Bu5I-NiglAw?si=h3TKilOaytJLILgS" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe></li>
                  <li><iframe width="350" height="228" src="https://www.youtube.com/embed/1lP7DfAS9Ws?si=sBDjqN6zRhD8QM22" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe></li>
				  <li><iframe width="350" height="228" src="https://www.youtube.com/embed/MuDHVnDUnxk?si=PPN6l-qd_Ghv6cBX" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe></li>
                  <li><iframe width="350" height="228" src="https://www.youtube.com/embed/RXrr4slfaxE?si=nGXdfZNp-tLtygVx" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe></li>
                </ul>
              </div>
              <span class= "next">&#10095</span>
            </div>
            
            
			<!-- 기사 -->
			<!-- 이전(prev1)/다음(next1) -->
			<div class="artpage">
				<div class="infotitle" style="display: flex; float:left;  margin-left: 10px;">
		             <div class="vline" style="height: 25px;"></div>
		             <h4 style="font-weight: 400; text-align: left; margin-left: 10px;">배트민턴 관련 기사</h4>
		          </div>
			    <c:if test="${currentPage > 1}">
			        <a href="/getNews?page=${currentPage - 1}&totalPage=${totalPage}" class="prev1">&#10094</a>
			    </c:if>
			    
			    <c:if test="${currentPage < totalPage}">
			        <a href="/getNews?page=${currentPage + 1}&totalPage=${totalPage}" class="next1">&#10095</a>
			    </c:if>
			</div>
			
			<!-- 기사 list -->
            <div class="article">
            	<c:if test="${not empty newsList}">
			        <c:forEach items="${newsList}" var="news">
			            <div class="newslist">
			                <a href="${news.url}" target="_blank"><img src="${news.image}" alt="뉴스 이미지" width="175" height="115"></a>
			                <div class="con">
			                	<p style="text-align:right; color:gray;"><fmt:formatDate value="${news.updateDate}" pattern="yyyy-MM-dd"/></p>
				                <h4><a href="${news.url}" target="_blank">${news.title}</a></h4>
				                <p style="height: 40px;">${news.content}</p>
			                </div>
			            </div>
			        </c:forEach>
			    </c:if>
            </div>
            
            
                 
          </div>
          <!-- //contents -->
        </section>
      </main>
      <!-- //main -->

	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</div>

<script>
	var inf = document.querySelector('.information'),
	inslide = document.querySelectorAll('.information li'),
	currentIdx = 0, 
	slideCount = inslide.length,
	prevBtn = document.querySelector('.prev'),
	infWidth = 350,
	infMargin = 35,
	nextBtn = document.querySelector('.next');
	
	inf.style.width = (infWidth + infMargin)*slideCount - infMargin + 'px';
	function moveSlide(num){
	  inf.style.left = - num * 385 + 'px';
	  currentIdx = num;
	}
	nextBtn.addEventListener('click', function(){
	  if(currentIdx < slideCount - 3){
	    moveSlide(currentIdx + 1);
	    console.log(currentIdx);
	  }else{
	    moveSlide(0);
	  }
	});
	
	prevBtn.addEventListener('click', function(){
	  if(currentIdx > 0){
	    moveSlide(currentIdx - 1);
	    console.log(currentIdx);
	  }else{
	    moveSlide(slideCount - 3);
	  }
	});
	
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shuttle Cock</title>
    <link rel="stylesheet" href="/css/mainstyle.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
    
<style>
.cal{
  border: 1px solid #eaeaea;
  width: 100%;
  display: flex;
  flex-wrap: wrap;
  display: flex;
  justify-content: center;
}
#calendar{
	width: 96%;
	height: 288px;
	margin: 10px auto;
	font-family: 'Arial', sans-serif; 
    font-size: 10px; 
    font-weight: bold;
    color: #333; 
}
#calendar .fc-col-header-cell {
    background-color: rgba(103, 141, 115, 0.1);
    color: #fff;
    padding: 0 5px;
}
</style>
</head>
<body>

<!-- wrap -->
 <div id="wrap">
 
 	  <!-- header -->
 	  <%@ include file="../views/include/header.jsp"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	  <!-- main -->
      <main id="main">
        <div id="slider">
          <div class="imageWrap"></div>
        </div>

        <section id="contents1">
          <div class="notice">
            <div class="container2">
	            <div class="page-title">
	              	<div class="vline"></div>
	                <h3>커뮤니티 게시판</h3>
	              	<a href="/Freeboard/freeList" class="more1">+</a>
              	</div>
            </div>

            <div id="board-list">
              <div class="container3">
                <table class="board-table">
                  <thead>
                    <tr>
                      <th scope="col" class="th-num">번호</th>
                      <th scope="col" class="th-title">제목</th>
                      <th scope="col" class="th-date">등록일</th>
                    </tr>
                  </thead>
                  <c:choose>
					<c:when test="${not empty freePosts}">
						<c:forEach items="${freePosts}" var="post" varStatus="s">
		                  <tbody>
		                    <tr>
		                      <td style="font-size:11px;">${fn:length(freePosts) - s.count + 1}</td>
		                      <th>
		                        <a href="/Freeboard/freeDetail/${post.freeboardId}"
		                          >${post.title}</a
		                        >
		                        <p>테스트</p>
		                      </th>
		                      <td style="color:gray;"><fmt:formatDate value="${post.regdate}" pattern="yyyy.MM.dd"/></td>
		                    </tr>
		                   </tbody>
		                 </c:forEach>
                      </c:when>
                    </c:choose>
                </table>
              </div>
            </div>
          </div>
          
          <div class="league">
            <div class="page-title">
              <div class="vline"></div>
              <div class="container2">
                <h3>리그 게시판</h3>
                <a href="/LeagueBoard" class="more2">+</a>
              </div>
            </div>

            <div id="board-list">
              <div class="container3">
                <table class="board-table">
                  <thead>
                    <tr>
                      <th scope="col" class="th-num">번호</th>
                      <th scope="col" class="th-title">제목</th>
                      <th scope="col" class="th-date">등록일</th>
                    </tr>
                  </thead>
                  <c:choose>
					<c:when test="${not empty leaguePosts}">
						<c:forEach items="${leaguePosts}" var="post" varStatus="s">
		                  <tbody>
		                    <tr>
		                      <td style="font-size:11px;">${fn:length(leaguePosts) - s.count + 1}</td>
		                      <th>
		                        <a href="/LeagueBoard/${post.leagueboardId}"
		                          >${post.title}</a
		                        >
		                        <p>테스트</p>
		                      </th>
		                      <td style="color:gray;"><fmt:formatDate value="${post.regdate}" pattern="yyyy.MM.dd"/></td>
		                    </tr>
		                   </tbody>
		                 </c:forEach>
                      </c:when>
                    </c:choose>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          
         <div class="calendar1">
            <div class="page-title" style="margin-bottom:0px;">
              <div class="vline"></div>
              <div class="container2">
                <h3>정규대회 일정</h3>
              </div>
            </div>
            
    			<div id='calendar'></div>
    			<%-- <input type="hidden" id="eventsData" th:value="${calendarEvent}" /> --%>
    		
          </div>
        </section>

        <section id="contents2">
          <div class="video">
              <div class="page-title">
                <div class="vline"></div>
                <div class="container2">
                  <h3>배드민턴 정보 게시판</h3>
                  <a href="/getNews" class="more">+</a>
                </div>
              </div>

              <div class="container">
                  <div class="div2">
                    <iframe width="423" height="240" src="https://www.youtube.com/embed/iqxuxEubedU?si=RzD9Lcefg0esEvUF" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
                  </div>

                  <div class="div2">
                    <iframe width="423" height="240" src="https://www.youtube.com/embed/CQlWDl-OTE4?si=6Zc6HbTsrV3Ta9ei" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
                  </div>
              </div>
            </div>
            
          <div class="place">
            <div class="page-title">
                <div class="vline"></div>
                <div class="container2">
                  <h3>배드민턴 운동장소 추천</h3>
                </div>
            	<a onclick="mapView()" class="more3">+</a>
            </div>
			
			<div class="map" id="map"></div>
      	</div> 
      	
      	
      	
      </section>
    </main>

	<!-- footer -->
	<%@ include file="../views/include/footer.jsp"%>

    </div>


<!-- script -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${apiKey}"></script>
<script src="/js/main-map-js.js"></script>
<script src="/js/main-calendar-js.js"></script>
<script>

function mapView(){
	window.open('mapView', '_blank', 'width=1800,height=1000');
}

//캘린더
document.addEventListener('DOMContentLoaded', function() 
{
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, 
    	{
	      initialView: 'dayGridMonth',
	      locale: 'ko',
	      dayCellContent: function(arg) {
	          return arg.dayNumberText.replace("일", "");
      	},
      	headerToolbar: {
          left: 'prev',
          center: 'title',
          right: 'next'
      	},
      	fixedWeekCount: false,
      	events: [
             <c:forEach items="${events}" var="event">
             	{
               	  title: '${event.region}',
                     start: '${event.start}',
                     end: '${event.end}',
                     backgroundColor: '${event.backgroundColor}',
                     textColor: '#333',
                     borderColor: 'transparent',
                     url: '/getGame'
                 },
             </c:forEach>
         ]
	});
  	calendar.render();
});

</script>
</body>
</html>
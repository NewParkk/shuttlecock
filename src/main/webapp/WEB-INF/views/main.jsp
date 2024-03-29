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
#calendar .fc-prev-button{
	background-color: #405448;
    border-color: #fff;
    color: #fff;
}
#calendar .fc-next-button{
	background-color: #405448;
    border-color: #fff;
    color: #fff;
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
	            <div class="page-title" style="margin-bottom:45px;">
	              	<div class="vline"></div>
	                <h3>커뮤니티 게시판</h3>
	              	<a href="/Freeboard/freeList" class="more1">+</a>
              	</div>
            </div>

            <div id="board-list">
              <div class="container3">
                <table class="board-table">
                  <thead>
                    <tr style="background-color: rgba(103, 141, 115, 0.1);">
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
            <div class="page-title" style="margin-bottom:45px;">
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
                    <tr style="background-color: rgba(103, 141, 115, 0.1);">
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
<script>
//페이지 로딩 시와 모달 열릴 때 실행되는 지도 초기화 함수
//지도 초기화 함수
var mapContainer = document.getElementById('map'); 
var mapOption = { 
 center: new kakao.maps.LatLng(33.450701, 126.570667), 
 level: 6
}; 

var map = new kakao.maps.Map(mapContainer, mapOption); 

if (navigator.geolocation) {
 getCurrentLocationAndAddMarker(map);
}else{
	console.log("navigator.geolocation 못불러옴")
}

//현재 위치 가져와서 마커 추가하는 함수
function getCurrentLocationAndAddMarker(map) {
 navigator.geolocation.getCurrentPosition(function(position) {
     var lat = position.coords.latitude;
     var lon = position.coords.longitude;
     
     var locPosition = new kakao.maps.LatLng(lat, lon);
     var message = '<div style="padding:5px;">현재 위치</div>'; 
		console.log("locPosition");
		console.log(locPosition);
     var data = {"lat": lat, "lon": lon};
     $.ajax({
         type : "POST",
         url : "/location",
         data : JSON.stringify(data),
         dataType : "JSON",
         contentType : "application/json; charset=UTF-8",
         async : false,
         success : function(result) {
             addMarkersToMap(map, result.closestList);
             crrentMarker(map, locPosition, message);
         },
         error: function(xhr, status, error) {
             console.error("Failed to fetch map data:", error);
         }
     });
 });
}

//지도에 마커 추가하는 함수
function addMarkersToMap(map, markerDataList) {
 var imageSrc = "img/map-icon.png"; 

 for (var i = 0; i < markerDataList.length; i++) {
     var markerData = markerDataList[i];
     var position = new kakao.maps.LatLng(markerData.lon, markerData.lat);
     var markerImage = new kakao.maps.MarkerImage(imageSrc, new kakao.maps.Size(35, 35)); 
     var marker = new kakao.maps.Marker({
         map: map,
         position: position,
         title: markerData.name,
         image: markerImage
     });

     var latlngString = position.getLat() + ',' + position.getLng();
     var iwContent = '<div style="padding:6px; width:230px;">' + markerData.name +
         			'<br><a href="https://map.kakao.com/link/map/' + markerData.name + 
         			',' + latlngString + 
         			'" style="color:blue" target="_blank">지도보기</a> <a href="https://map.kakao.com/link/to/' + markerData.name + 
         			',' + latlngString + '" style="color:blue" target="_blank">길찾기</a></div>';
     addClickListener(marker, iwContent);
 }
}

//마커 클릭 시 인포윈도우를 연결하는 함수
function addClickListener(marker, iwContent) {
 var infowindow = new kakao.maps.InfoWindow({
     position: marker.getPosition(),
     content: iwContent,
     removable: true
 });

 function clickHandler() {
     infowindow.setPosition(marker.getPosition());
     infowindow.open(map, marker);
 }

 kakao.maps.event.addListener(marker, 'click', clickHandler);
}

//현재 위치에 마커 추가하는 함수
function crrentMarker(map, locPosition, message) {
 var marker = new kakao.maps.Marker({  
     map: map, 
     position: locPosition
 }); 

 var infowindow = new kakao.maps.InfoWindow({
     content: message,
     removable: true
 });
 
 infowindow.open(map, marker);
 map.setCenter(locPosition);
}




function mapView(){
	window.open('mapView', '_blank', 'width=1800,height=1000');
}

//캘린더
document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
	    var calendar = new FullCalendar.Calendar(calendarEl, {
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
		      events: eventsToShow 
    });
	calendar.render();
}); 
	
var eventsByDate = {}; //날짜별로 데이터를 가져오기 위해 빈객체 생성
<c:forEach items="${events}" var="event">
    var date = '${event.start}'; 
    if (!eventsByDate[date]) {
        eventsByDate[date] = []; //해당날짜의 데이터가 없으면 빈값으로 넣음
    }
    eventsByDate[date].push({
        title: '${event.region}',
        start: '${event.start}',
        end: '${event.end}',
        backgroundColor: '${event.backgroundColor}',
        textColor: '#333',
        borderColor: 'transparent',
        url: '/getGame'
    });
</c:forEach>

//각 날짜당 최대 2개의 데이터만 보이게 함
var eventsToShow = []; //최종적으로 표시될 객체
for (var date in eventsByDate) { //각 날짜에 대해 반복
    if (eventsByDate.hasOwnProperty(date)) { //eventsByDate가 해당 date를 가지고 있는지 확인(true/false)
        var eventsDate = eventsByDate[date];
        
        //남은 데이터 수를 저장
        var remainCount = eventsDate.length - Math.min(eventsDate.length, 2); //eventsDate.length와 2 중 더 작은 값을 선택함

        //최대 2개의 데이터 추가
        for (var i = 0; i < Math.min(eventsDate.length, 2); i++) {
            eventsToShow.push(eventsDate[i]);
        }

        //남은 데이터 수에 more 이벤트를 추가
        if (remainCount > 0) {
            var more = {
                title: '+' + remainCount + ' more',
                start: eventsDate[0].start, //날짜는 첫 번째 데이터의 날짜로 기준을 잡음
                textColor: 'rgba(0, 0, 0, 0.4)',
                borderColor: 'transparent',
                url: '/getGame',
                moreEventsCount: remainCount,
                backgroundColor: 'transparent'
            };
            eventsToShow.push(more);
        }
    }
} 

</script>
</body>
</html>
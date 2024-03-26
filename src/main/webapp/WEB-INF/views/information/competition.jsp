<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
<!-- aisde-js 파일 -->
<script src="/js/aside-js.js"></script>
<title>Shuttle Cock</title>
<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<style>
.cal{
  width: 1220px;
  display: flex;
  margin: 15px;
  flex-wrap: wrap;
  /* justify-content: center; */
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}
.cal h3{
	margin-bottom: 35px;
}
.cal-in {
    flex: 1;
    overflow-y: auto;
    max-height: calc(100vh - 100px);
    margin: 70px 10px 20px 10px;
}
#calendar{
	/* width: 90%;
	height: 900px; */
	width: 60%;
	height: 700px;
	/* margin: 10px auto; */
	margin: 20px 10px;
	font-family: 'Arial', sans-serif;
    font-size: 14px; 
    font-weight: bold;
    color: #333; 
}
#calendar .fc-button {
    background-color: #405448;
    border-color: #fff;
    color: #fff;
}
#calendar .fc-prev-button{
	background-color: #405448;
    border-color: #fff;
    color: #fff;
}
#calendar .fc-prev-button:hover{
	border-color: #405448;
	color: #405448;
	background-color: #fff;
}
#calendar .fc-next-button{
	background-color: #405448;
    border-color: #fff;
    color: #fff;
}
#calendar .fc-next-button:hover{
	border-color: #405448;
	color: #405448;
	background-color: #fff;
}

#calendar .fc-regionButton-button{
    background-color: rgba(46, 139, 87, 0.2);
    border-color: rgba(46, 139, 87, 0.2);
    color: #405448;
}

#calendar .fc-countryButton-button {
    background-color: rgba(255, 204, 0, 0.3);
    border-color: rgba(255, 204, 0, 0.3);
    color: #405448;
}
	
#calendar .fc-col-header-cell {
    background-color: rgba(103, 141, 115, 0.1);
    color: #fff;
    padding: 0 5px;
}
#calendar .fc-day-header {
    color: #fff; 
}
#calendar .fc-toolbar-title {
    font-size: 20px; 
  }
#calendar .fc-toolbar-chunk{
	display: flex;
}
#calendar .fc-event {
    overflow: hidden;
    white-space: nowrap; 
    text-overflow: ellipsis;
    height: 15px; 
    line-height: 12px;
    cursor: pointer;
}
#calendar .fc-daygrid-event-harness{
     overflow: hidden;
}
/* #calendar .fc-event:hover{
	transition: margin-left 2s;
	margin-left: -100%;
} */
.line1 {
  width: 2px;
  height: 700px;
  margin: 0 20px;
  background: linear-gradient(to bottom, transparent, #eaeaea, transparent);
}
#calendar .fc-day:hover{
	background-color: #f6f6f6;
}
.imageWrap1 {
  width: 100%;
  height: 140px;
  background: url("/img/badminton-bg.jpg") repeat;
  background-size: contain;
}
</style>
</head>
<body>
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
                <li><a class="list" href="/main">HOME</a></li>
                <li><a class="list" href="/Announcement/">공지사항</a></li>
                <li><a class="list" href="/getNews">배드민턴 정보</a></li>
                <li><a class="list" href="/getGame">정규대회 일정</a></li>
              </ul>
            </div>
          </div>

		  <!-- contents -->
          <div class="contents">
            <div class="title2" style="margin">
              <div class="vline"></div>
              <h2>정규대회 일정</h2>
            </div>
            
            <div class="cal">
    			<div id='calendar'></div>
    			<div class="line1"></div>
	    		<div class="cal-in">
	    		
	    		</div>
    		</div>
    
     		</div>
          <!-- //contents -->
        </section>
      </main>
      <!-- //main -->

	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</div>
</body>
<script type="text/javascript">

      document.addEventListener('DOMContentLoaded', function() {
    	  
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth',
          locale: 'ko',
          dayCellContent: function(arg) {
              return arg.dayNumberText.replace("일", "");
          },
          headerToolbar: {
        	  left: 'allRegionButton countryButton regionButton',
              right: 'prev title next'
          },
          customButtons: {
        	    regionButton: {
        	        text: '지역',
        	        click: function() {
        	             window.location.href = '/getGame?region=지역';
        	            }
        	        },
        	    countryButton: {
        	        text: '전국',
        	        click: function() {
        	        	window.location.href = '/getGame?region=전국'
        	        }
        	    },
        	    allRegionButton: {
        	        text: '전체',
        	        click: function() {
        	        	window.location.href = '/getGame?region='
        	        }
        	    }
        	},
          fixedWeekCount: false,
         /*  eventClick: function(info) {
              if (info.event.extendedProps.url) {
                  window.open(info.event.extendedProps.url);
              }
          }, */
          eventClick: function(info) {
              var eventTitle = info.event.title;

              var eventUrl = info.event.extendedProps.url;
              if (eventUrl) {
                  window.open(eventUrl, '_blank');
              }
              
              var calInContent = '<h3>' + eventTitle + '</h3>';
              document.querySelector('.cal-in').innerHTML = calInContent;
              
          },
          dateClick: function(info) {
              var clickedDate = info.date;
              var eventsOnDate = calendar.getEvents().filter(function(event) {
                  return event.start.toDateString() === clickedDate.toDateString();
              });

              var eventTitles = eventsOnDate.map(function(event) {
            	    return '<p><a href="' + event.extendedProps.url + '" target="_blank">' + event.title + '</a></p>';
            	});

              var calInContent = '<h3>' + clickedDate.toLocaleDateString('ko-KR') + '</h3>' +
                  eventTitles.join('');
              document.querySelector('.cal-in').innerHTML = calInContent;
          },
          
          events: [
              <c:forEach items="${events}" var="event">
                  {
                	  //title: '${event.region}',
                      title: '${event.title}',
                      start: '${event.start}',
                      end: '${event.end}',
                      backgroundColor: '${event.backgroundColor}',
                      textColor: '#405448',
                      borderColor: 'transparent',
                      /*  extendedProps는 캘린더에서 사용되는 속성 중 하나 */
                      extendedProps: { 
                          url: '${event.url}'
                      }
                  },
              </c:forEach>
          ]
          
        });
        calendar.render();
       
        document.querySelectorAll('.fc-event').forEach(function(event) {
            event.addEventListener('mouseenter', function() {
                event.classList.add('hovered');
            });
            event.addEventListener('mouseleave', function() {
                event.classList.remove('hovered');
            });
        });
	});
    
    </script>
</html>
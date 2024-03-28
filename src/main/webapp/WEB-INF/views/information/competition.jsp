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
<link rel="stylesheet" href="/css/com-calendar.css">

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
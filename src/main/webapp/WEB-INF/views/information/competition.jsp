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
  display: flex;
  justify-content: center;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}
#calendar{
	width: 90%;
	height: 900px;
	margin: 10px auto;
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
</style>
</head>
<body>
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
                <li><a class="list" href="/main">HOME</a></li>
                <li><a class="list" href="/Announcement/">공지사항</a></li>
                <li><a class="list" href="/getNews">배드민턴 정보</a></li>
                <li><a class="list" href="/getGame">정규대회 일정</a></li>
              </ul>
            </div>
          </div>

		  <!-- contents -->
          <div class="contents">
            <div class="title" style="margin">
              <div class="vline"></div>
              <h2>정규대회 일정</h2>
            </div>
            
            <div class="cal">
    			<div id='calendar'></div>
    		</div>
    		<div class="cal-in">
    		
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
        	  left: 'prev title next',
              right: 'regionButton countryButton'
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
        	    }
        	},
          fixedWeekCount: false,
          eventClick: function(info) {
              if (info.event.extendedProps.url) {
                  window.open(info.event.extendedProps.url);
              }
          },
          events: [
              <c:forEach items="${events}" var="event">
                  {
                	  //title: '${event.region}',
                      title: '${event.title}',
                      start: '${event.start}',
                      end: '${event.end}',
                      backgroundColor: '${event.backgroundColor}',
                      textColor: '#333',
                      borderColor: 'transparent',
                      url: '${event.url}'
                  },
              </c:forEach>
          ]
          
        });
        calendar.render();
      });
    
    </script>
</html>
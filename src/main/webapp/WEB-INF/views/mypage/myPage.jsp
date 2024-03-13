<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.List"%>
<%@page import="com.fp.shuttlecock.mypage.CalendarDTO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="/css/mainstyle.css">
<meta name='viewport' content='width=device-width, initial-scale=1'>
<!-- fullcalendar -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/mainstyle.css">

<!-- bootstrap 4 -->
<!-- <link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>

<!-- fullcalendar 언어 설정관련 script -->
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>

</head>
<body>
	<a href="/updateUser">회원수정</a>

	<a href="/record">나의활동내역</a>
	<div id="calendarBox">
		<div id="calendar"></div>
	</div>
	<!-- modal 추가 -->
	<div id="calendarModal" class="modal">
		<div class="modal-content">
			<span class="close">&times;</span>
			<h2>일정 추가</h2>
			<form action="/mypage" method="POST" enctype="multipart/form-data">
				<input type="text" id="title" name="title" placeholder="일정 제목">
				<input type="date" id="date" name="date" placeholder="이"> 
				<input type="submit" value="추가">
			</form>
		</div>
	</div>
	<!-- modal 추가 -->
<div id="calendarModalDelete" class="modal">
  <div class="modal-content">
	    <span class="close">&times;</span>
	    <form action="/delete.do" enctype="multipart/form-data">
	    <input type="hidden" id="myInput" name="calendarId" value="myInput" placeholder="일정 제목">
	    <p>정말로 삭제하시겠습니까?</p>
	    <input type="submit" value="삭제">
	    <button id="cancelButton">취소</button>
	</form>  
  </div>
</div>
</body>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, {
		initialView : 'dayGridMonth',
		locale : 'ko', // 한국어 설정
		headerToolbar : {
        	 start : "prev next today", 
             center : "title",
             end : 'addEventButton'
            },
            customButtons: {
                addEventButton: { // 추가한 버튼 설정
                    text : "일정 추가",  // 버튼 내용
                    click : function(){ // 버튼 클릭 시 이벤트 추가
                    	// modal 나타내기
                    	document.getElementById("calendarModal").style.display = "block"
                   		
                    }
                }
            }, 
     
	selectable : true,
	droppable : true,
	editable : true,
	events : [ 
    	    <%List<CalendarDTO> calendarList = (List<CalendarDTO>) request.getAttribute("calendarList");%>
            <%if (calendarList != null) {%>
            <%for (CalendarDTO vo : calendarList) {%>
            {
            	id : '<%=vo.getCalendarId()%>',
            	title : '<%=vo.getTitle()%>',
                start : '<%=vo.getDate()%>',
                color : '#' + Math.round(Math.random() * 0xffffff).toString(16)
             },
			<%}
			}%>
			],
			eventClick: function(info) {
			   	  // modal 나타내기
			      document.getElementById("calendarModalDelete").style.display = "block"
			      // 여기에서는 예제로 간단히 이벤트를 배열에서 찾아 제거합니다.
			      // 클릭한 이벤트 ID 가져오기
			      var eventid = info.event.id
			      console.log(eventid);
			   	  
			      document.getElementById("myInput").value = eventid;
			      // FullCalendar에서 일정을 삭제한 후 UI를 다시 렌더링합니다.
			      calendar.render();
			    }	
				
			});
			calendar.render();
		});
</script>
<style>
#calendarBox {
	width: 70%;
	padding-left: 15%;
}
</style>
</html>

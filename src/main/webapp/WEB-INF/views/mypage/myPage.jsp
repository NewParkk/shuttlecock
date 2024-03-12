<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.List"%>
<%@page import="com.fp.shuttlecock.mypage.CalendarDTO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv='X-UA-Compatible' content='IE=edge'>
<title>Insert title here</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<!-- fullcalendar -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/mainstyle.css">

<!-- bootstrap 4 -->
<!-- <link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>

<!-- fullcalendar 언어 설정관련 script -->
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>

</head>
<body>
	<%-- 	${user.userId} ${calendarList}
	<c:forEach items="${calendarList}" var="calendar">
			${calendar.title}
	</c:forEach>
	<a href="/updateUser">회원수정</a>

	<a href="/record">나의활동내역</a> --%>
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
				<input type="date" id="date" name="date" placeholder="이"> <input
					type="submit" value="추가">
			</form>
		</div>
	</div>
	<!-- modal 추가 -->
	<div id="calendarModalDelete" class="modal">
		<div class="modal-content">
			<span class="close">&times;</span>
			<h2>일정 추가</h2>
			<form action="/mypage" method="POST" enctype="multipart/form-data">
				<input type="text" id="title" name="title" placeholder="일정 제목">
				<input type="date" id="date" name="date" placeholder="이"> <input
					type="submit" value="추가">
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
            	title : '<%=vo.getTitle()%>',
                date : '<%=vo.getDate()%>',
                color : '#' + Math.round(Math.random() * 0xffffff).toString(16)
             },
			<%}
			}%>
			],
			eventClick: function(info) {
			      // 클릭한 이벤트 ID 가져오기
			      var eventdate = info.event.date;
				  
			      // 여기에서는 예제로 간단히 이벤트를 배열에서 찾아 제거합니다.
			      // 실제로는 데이터베이스나 다른 저장소에서 이벤트를 삭제해야 합니다.
			      calendar.getEventById(eventId).remove();

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

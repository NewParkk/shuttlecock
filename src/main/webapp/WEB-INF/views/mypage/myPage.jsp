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

<!-- <link rel="stylesheet" href="/css/mainstyle.css"> -->
<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<!-- aisde-js 파일 -->
<script src="/js/aside-js.js"></script>
<link rel="stylesheet" href="/css/free.css">
<link rel="stylesheet" href="/css/mypage.css">

<!-- fullcalendar css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">

<!-- fullcalendar 언어 설정관련 script -->
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>

</head>


<body>

	<!-- wrap -->
	<div id="wrap">

		<!-- header -->
		<%@ include file="../include/header.jsp"%>
		<!-- main -->
		<main id= "main">
	        <div id="slider">
	          <div class="imageWrap1"></div>
	        </div>
	
			<!-- section -->
			<section id="contents">

				<!-- aside -->
				<div class="aside">
					<div class="menubar">
						<ul>
							<li><a class="list" href="/mypage">마이페이지</a></li>
							<li><a class="list" href="/updateUser">내 프로필</a></li>
							<li><a class="list" href="/record">나의활동내역</a></li>
							<li><a class="list" href="/manageBlockedUser">차단유저관리</a></li>
						</ul>
					</div>
				</div>
				<div class="noticeboard">
					<div class="title" style="margin:0px;">
						<div class="vline"></div>
						<div class="container2">
							<h3>마이 페이지</h3>
						</div>
					</div>

				<div id="board-list">
					<div id="calendarBox">
						<div id="calendar"></div>
					</div>
					<!-- modal 추가 -->
					<div id="my_modal">
						<div class="modal-content">
								<span class="close">&times;</span>
								<h2>일정 추가</h2>
							<form action="/mypage" method="POST"
								enctype="multipart/form-data">
								<input type="text" id="title" name="title" placeholder="일정 제목">
								<input type="date" id="date" name="date" placeholder="이">
								<input type="submit" class="btn btn-primary whyBtn" value="추가">
							</form>
						</div>
					</div>
					<!-- modal 추가 -->
					<div id="my_modal_delete" class="modal">
						<div class="modal-content">
							<span class="close1">&times;</span>
							<form action="/delete.do" enctype="multipart/form-data">
								<input type="hidden" id="myInput" name="calendarId"
									value="myInput" placeholder="일정 제목">
								<p>정말로 삭제하시겠습니까?</p>
								<input type="submit" value="삭제">
							</form>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
	<%@ include file="../include/footer.jsp"%>
	</div>

</body>

<script type="text/javascript">
// 캘린더 
document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, {
		initialView : 'dayGridMonth',
		locale : 'ko', // 한국어 설정
		dayCellContent: function(arg) {
            return arg.dayNumberText.replace("일", "");
        },
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
                    	document.getElementById("my_modal").style.display = "inline"
                   		
						
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
			      document.getElementById("my_modal_delete").style.display = "block"
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

<script type="text/javascript">
// 모달 닫기 (일정추가) 
var modal = document.getElementById('my_modal');

var closeBtn = document.getElementsByClassName("close")[0];

function closeModal() {
	  modal.style.display = "none"; // 모달 숨기기
	}
	
closeBtn.addEventListener('click', closeModal);

window.addEventListener('click', function(event) {
	  if (event.target == modal) {
	    closeModal();
	  }
	});

//모달 닫기 (삭제) 
var modal_delte = document.getElementById('my_modal_delete');

var closeBtn1 = document.getElementsByClassName("close1")[0];

function closeModal_delete() {
	modal_delte.style.display = "none"; // 모달 숨기기
	}
	
closeBtn1.addEventListener('click', closeModal_delete);

window.addEventListener('click', function(event) {
	  if (event.target == modal_delte) {
		  closeModal_delete();
	  }
	});

//
$('.whyBtn').click(function() {
                // 제목과 내용을 가져옵니다.
                var title = $('#title').val();
                var date = $('#date').val(); // 에디터의 내용을 가져옵니다.
                // 제목이나 내용이 비어 있는지 확인합니다.
                if (title.trim() === '') {
                    alert('제목을 입력하세요.');
                    return false;
                } if(date.trim() === ''){
                    alert('날짜를 입력하세요.');
                    return false;
                } else {
                    $("form").submit(); // 유효한 경우 폼을 제출합니다.
                }
            });
</script>

</html>

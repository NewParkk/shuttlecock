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
<link rel="stylesheet" href="/css/loginstyle.css">
<link rel="stylesheet" href="/css/aside.css">

<!-- fullcalendar css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">

<!-- fullcalendar 언어 설정관련 script -->
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>

<!-- 카카오 일정 보내기 -->
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.0/kakao.min.js"
	integrity="sha384-l+xbElFSnPZ2rOaPrU//2FF5B4LB8FiX5q4fXYTlfcG4PGpMkE1vcL7kNXI6Cci0"
	crossorigin="anonymous"></script>
<script>
  Kakao.init('9642c668efb62c980d8b2f016f784e27'); // 사용하려는 앱의 JavaScript 키 입력
</script>
</head>


<body>

	<!-- wrap -->
	<div id="wrap">

		<!-- header -->
		<%@ include file="../include/header.jsp"%>
		<main id="main">

			<section id="contents">

				<!-- aside -->
				<div class="aside">
					<div class="menubar">
						<ul>
							<li><a class="list" href="/mypage">마이페이지</a></li>
							<li><a class="list" href="/updateUser">회원수정</a></li>
							<li><a class="list" href="/record">나의활동내역</a></li>
						</ul>
					</div>
				</div>
 				<div class="noticeboard">
					<div class="page-title">
						<div class="vline"></div>
						<div class="container2">
							<h3>마이 페이지</h3>
						</div>
					</div> 


					<div id="calendarBox">
						<div id="calendar"></div>
					</div>
					<a id="kakao-login-btn" href="javascript:loginWithKakao()"> <img
						src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg"
						width="222" alt="카카오 로그인 버튼" />
					</a>
					<p id="token-result"></p>
					<button class="api-btn" onclick="sendToMe()"
						style="visibility: hidden">나에게 메시지 보내기</button>
					<!-- modal 추가 -->
					<div id="my_modal">
						<div class="modal-content">
							<span class="close">&times;</span>
							<h2>일정 추가</h2>
							<form action="/mypage" method="POST"
								enctype="multipart/form-data">
								<input type="text" id="title" name="title" placeholder="일정 제목">
								<input type="date" id="date" name="date" placeholder="이">
								<input type="submit" value="추가">
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
// 카카오톡
function loginWithKakao() {
    Kakao.Auth.authorize({
      redirectUri: 'http://localhost:8099/mypage',
      state: 'sendme_custom',
      scope: 'talk_message', // 앱 동의 항목 설정 및 사용자 동의 필요
    });
  }

function sendToMe() {
    Kakao.API.request({
      url: '/v2/api/talk/memo/send',
      data: {
        template_id: ${1046994},
        template_args: {
          title: '라이언이 즐겨먹던 바로 그 틴케이스 치즈볼',
          description: '바라만 봐도 즐거워지는 힐링 패키지에는 시크릿 스토리가 숨어있어요.',
        },
      },
    })
      .then(function(res) {
        alert('success: ' + JSON.stringify(res));
      })
      .catch(function(err) {
        alert('error: ' + JSON.stringify(err));
      });
  }

  
// 아래는 데모를 위한 UI 코드입니다.
displayToken()
function displayToken() {
  var token = getCookie('authorize-access-token');

  if(token) {
    Kakao.Auth.setAccessToken(token);
    document.querySelector('#token-result').innerText = 'login success, ready to send a message';
    document.querySelector('button.api-btn').style.visibility = 'visible';
  }
}

function getCookie(name) {
  var parts = document.cookie.split(name + '=');
  if (parts.length === 2) { return parts[1].split(';')[0]; }
}
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

</script>
<style>
#calendarBox {
	width: 70%;
	padding-left: 10px;
}

a {
	font-size: 1.17rem;
	!
	important;
}

#my_modal {
	display: none;
	width: 350px;
	padding: 20px 60px;
	background-color: #fefefe;
	border: 1px solid #888;
	border-radius: 3px;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	z-index: 1000;
}

#my_modal_delete {
	display: none;
	width: 350px;
	padding: 20px 60px;
	background-color: #fefefe;
	border: 1px solid #888;
	border-radius: 3px;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	z-index: 1000;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.close1 {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close1:hover, .close1:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.noticeboard {
	width: 100%;
}
</style>
</html>

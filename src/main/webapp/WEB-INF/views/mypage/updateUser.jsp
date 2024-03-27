<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Shuttle Cock</title>
<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<!-- aisde-js 파일 -->
<script src="/js/aside-js.js"></script>
<link rel="stylesheet" href="/css/free.css">
<link rel="stylesheet" href="/css/mypage1.css">

</head>
<body>
	<% if (request.getAttribute("errorMsg") != null) { %>
        <script>
            alert("<%= request.getAttribute("errorMsg") %>");
            window.location = '/updateUser';
        </script>
    <% } %>

	<!-- wrap -->
	<div id="wrap">

		<!-- header -->
		<%@ include file="../include/header.jsp"%>
		<!-- main -->
		<main id="main">
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
					<div class="title" style="margin: 0px;">
						<div class="vline"></div>
						<div class="container2">
							<h3>내 프로필 &#10095</h3>
						</div>
					</div>


					<div id="board-list">
						<div class="container2">

							<form action="/updateUser" method="POST" enctype="multipart/form-data" id="next_form">
							  
							  <table class="board-table"> 
						            <colgroup>
						                <col width="15%">
							            <col width="35%">
							            <col width="15%">
							            <col width="35%">
						            </colgroup>
						            <tbody> 
						                <tr>
						                    <th scope="row" bgcolor="#F9F9F9">프로필 사진</th>
						                    <td colspan="4" class="profile-picture" style="display: flex; flex-direction: column;">			         
								              <c:if test="${user.userImageName eq null}">
								                  <img src="https://kr.object.ncloudstorage.com/team1bucket/profile/noprofile.png" alt="프로필 이미지">
								              </c:if>
								              <c:if test="${user.userImageName != null}">
								                  <img src="https://kr.object.ncloudstorage.com/team1bucket/profile/${user.userImageName}" alt="프로필 이미지">
								              </c:if>
								              <input type="file" id="fileInput" name="file" class="custom-file-upload">
									        </td>
						                </tr>
						                <tr>
						                    <th scope="row" bgcolor="#F9F9F9">아이디</th>
						                    <td colspan="4" style="text-align: left; padding-left:10px; font-weight: bold;">
										        <div style="display: flex; align-items: center;">
										        <img src="https://kr.object.ncloudstorage.com/team1bucket/badge/${user.badgeId}.png"
													width="30px" height="25px" style="margin-right:5px;">${user.userId}
												</div>
										    </td>
										</tr>
										<tr>
										    <th scope="row" bgcolor="#F9F9F9">이름</th>
						                    <td colspan="4" style="text-align: left; padding-left:10px;">
										        <input type="text" name="username" class="form-control1" value="${user.username}">
										    </td>
						                </tr>
										<tr>
										    <th scope="row" bgcolor="#F9F9F9">이메일</th>
						                    <td colspan="4" style="text-align: left; padding-left:10px;">
										        <input type="email" name="userEmail" id="userEmail" class="form-control1" value="${user.userEmail}">
										        <span id="emailMsg"></span>
										    </td>
										</tr>
						            </tbody>
					            </table>
					            
								<div class=button-container style="text-align :center">
									<input class="update" type="submit" id="update" value="수정">
								    <input type="button" class="delete-btn" id="btnDelete" value="회원탈퇴">
								</div>
							</form>
							
							
						</div>
					</div>
				</div>
			</section>
		</main>
		
		<!-- footer -->
		<%@ include file="../include/footer.jsp"%>
	</div>
	<!-- //wrap -->
	
	<!-- modal 추가 -->
	<%-- <c:if test="${user.kakaoYN eq false}"> --%>
		<div id="my_modal_delete" class="modal">
			<div class="modal-content">
				<span class="close1">&times;</span>
				<form action="/deleteUser" enctype="multipart/form-data" method="POST">
					<input type="password" name="pw" placeholder="비밀번호"
						class="custom-input">
					<p>정말로 삭제하시겠습니까?</p>
					<input type="submit" value="삭제" class="delete-btn" style="margin: 20px 0px 0px 80px;">
				</form>
			</div>
		</div>
	<%-- </c:if> --%>
</body>

<script type="text/javascript">
	// input 상자의 값을 가져오는 함수
	function getInputValue() {
		return document.getElementById("fileInput").value;
	}

	// 입력 상자가 null인지 확인하고 처리하는 함수
	function handleInput() {
		var inputValue = getInputValue();

		// 입력 상자의 값이 null이 아닌 경우에만 실행
		if (inputValue !== null && inputValue !== "") {
			// 여기에 실행하고자 하는 코드를 작성
			console.log("Input is not null");
		}
	}

	// 모달 열기 버튼 클릭 시 이벤트 처리
	document.getElementById('btnDelete').addEventListener('click', function() {
		document.getElementById('my_modal_delete').style.display = 'block'; // 모달 보이기
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
	
	//프로필 수정 전 이메일 중복체크 및 유효성 검사
	const userEmailInput = document.getElementById('userEmail');
	const emailMsg = document.getElementById('emailMsg');
	const updateBtn = document.getElementById('update');

	userEmailInput.addEventListener('input', function () {
	    const email = userEmailInput.value;
	    const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;

	 	// userEmail 입력란이 빈칸일 경우(공백제거)
	    if (email.trim() === '') {
	        emailMsg.textContent = ''; // 이메일 메시지 초기화
	        updateBtn.disabled = true; //수정 버튼 비활성화
	        return;
	    }

	 	// userEmail 유효하지 않은 이메일 주소일 경우
	    if (!emailPattern.test(email)) {
	        emailMsg.textContent = '유효하지 않은 이메일 주소입니다.';
	        emailMsg.style.color = 'red';
	        updateBtn.disabled = true; //수정 버튼 비활성화
	        return;
	    }

	 	//이메일 중복체크
	    $.ajax({
	        url: '/checkEmail',
	        method: 'GET',
	        data: { userEmail: email },
	        success: function (data) {
	        	emailMsg.textContent = data.emessage;
	            emailMsg.style.color = data.emessage.includes("사용가능한") ? "green" : "red";
	            updateBtn.disabled = !data.emessage.includes("사용가능한"); //수정 버튼 비활성화
	        }
	    });
	});
	
</script>

<style>
table {
	width: 100%;
	border-collapse: collapse;
}
</style>
</html>

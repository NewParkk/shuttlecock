<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<link rel="stylesheet" href="/css/free.css">



</head>
<body>
	<!-- wrap -->
	<div id="wrap">

		<!-- header -->
		<%@ include file="../include/header.jsp"%>
		<main id="boardmain">

			<section id="contents">

				<!-- aside -->
				<div class="aside">
					<div class="menubar">
						<ul>
							<li><a class="list" href="/mypage">마이페이지</a></li>
							<li><a class="list" href="/updateUser">회원수정</a></li>
							<li><a class="list" href="/record">나의활동내역</a></li>
							<li><a class="list" href="/manageBlockedUser">차단유저관리</a></li>
						</ul>
					</div>
				</div>

				<div class="noticeboard">
					<div class="title">
						<div class="vline"></div>
						<div class="container2">
							<h3>회원 수정</h3>
						</div>
					</div>
				

				<div id="board-list">
					<div class="container2">
					
						<form action="/updateUser" method="POST"
							enctype="multipart/form-data" id="next_form">
							<div class="member-info">
								<div class="profile-picture">
									<img
										src="https://kr.object.ncloudstorage.com/team1bucket/profile/${user.userImageName}"><br>
									<input type="file" id="fileInput" name="file"
										class="custom-file-upload"><br>
								</div>
								<div class="details">
									<h2>
										ID : <input type="text" value="${user.userId}"
											class="custom-input" readonly disabled>
									</h2>
									<br>
									<h2>
										name : <input type="text" name="username" class="custom-input"
											value="${user.username}">
									</h2>
									<br>
									<h2>
										email : <input type="text" name="userEmail"
											class="custom-input" value="${user.userEmail}">
									</h2>
									<br> <input class="update" type="submit" id="update"
										value="수정" style="margin-left:30px;">
									
									<input type="button" class="delete-btn" id="btnDelete" value="회원탈퇴"
									style="margin-left:50px;">
								</div>
							</div>
						</form>
						</div>
					</div>
				</div>
			</section>
		</main>
		<%@ include file="../include/footer.jsp"%>
	</div>
	<!-- modal 추가 -->
	<div id="my_modal_delete" class="modal">
		<div class="modal-content">
			<span class="close1">&times;</span>
			<form action="/deleteUser" enctype="multipart/form-data">
				<input type="password" name="pw" placeholder="비밀번호"
					class="custom-input">
				<p>정말로 삭제하시겠습니까?</p>
				<input type="submit" value="삭제" class="delete-btn">
			</form>
		</div>
	</div>
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
</script>

<style>

.member-info {
	background-color: #f0f0f0; /* 배경색 지정 */
	display: flex;
	align-items: center;
	margin: 50px;
	padding: 20px; /* 내부 여백 지정 */
	border-radius: 10px; /* 테두리 모서리 둥글게 만듦 */
}

.profile-picture img {
	width: 150px; /* 프로필 사진의 크기 조절 */
	height: 150px; /* 프로필 사진의 크기 조절 */
	border-radius: 50%; /* 프로필 사진을 원형으로 만듭니다. */
}

.details {
	margin-left: 20px; /* 회원 정보와 프로필 사진 사이의 간격 조절 */
}

.details h2 {
	font-size: 20px; /* 사용자 이름의 글꼴 크기 조절 */
	margin-bottom: 5px; /* 사용자 이름과 이메일 주소 사이의 간격 조절 */
}

.details p {
	font-size: 16px; /* 이메일 주소의 글꼴 크기 조절 */
	color: #666; /* 이메일 주소의 색상 변경 */
}

#wrap {
	width: 100%;
	top-margin: 30px;
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

.close1 {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close1:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.update {
	background-color: #4CAF50; /* 버튼 배경색 */
	color: white; /* 버튼 글자색 */
	padding: 12px 20px; /* 내부 여백 */
	border: none; /* 테두리 없음 */
	border-radius: 4px; /* 버튼 모서리 둥글게 */
	cursor: pointer; /* 마우스 커서를 포인터로 변경 */
}

.delete-btn {
	background-color: #f44336; /* 삭제 버튼 배경색 */
	color: white; /* 삭제 버튼 글자색 */
	padding: 10px 20px; /* 내부 여백 */
	border: none; /* 테두리 없음 */
	border-radius: 4px; /* 버튼 모서리 둥글게 */
	cursor: pointer; /* 마우스 커서를 포인터로 변경 */
}

/* 버튼에 마우스를 올렸을 때의 스타일 */
.delete-btn:hover {
	background-color: #d32f2f;
}

.custom-input {
	width: 200px; /* 입력 상자의 너비 */
	padding: 10px; /* 내부 여백 */
	border: 1px solid #ccc; /* 테두리 스타일 및 색상 */
	border-radius: 4px; /* 입력 상자 모서리 둥글게 */
	font-size: 16px; /* 글꼴 크기 */
	outline: none; /* 포커스 시 테두리 제거 */
}

/* 입력 상자에 포커스를 받았을 때의 스타일 */
.custom-input:focus {
	border-color: #007bff; /* 포커스 시 테두리 색상 변경 */
}

.custom-file-upload {
	display: inline-block;
	padding: 10px 20px;
	cursor: pointer;
	color: black;
	border: none;
	border-radius: 4px;
	font-size: 16px;
}

/* 파일 업로드 버튼에 마우스를 올렸을 때의 스타일 */
.custom-file-upload:hover {
	background-color: #0056b3;
}

/* 파일 업로드 버튼에 포커스를 받았을 때의 스타일 */
.custom-file-upload:focus {
	outline: none;
}
</style>
</html>
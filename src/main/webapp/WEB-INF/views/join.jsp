<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Join</title>
	<link rel="stylesheet" href="/css/loginstyle.css">
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>
	<!-- wrap -->
    <div id="wrap">
      <!-- main -->
      <main id="main">
        <div id="slider">
          <div class="imageWrap">
            <div class="image i1">
            </div>
          </div>
        </div>

		<!-- section -->
        <section id="contents">
          <div class="join-box">
            <div class="join-title"><img src="/img/shuttle-logo.jpg" alt="Logo" onclick="location.href='/main'" /></div>
            <div class="joinform">
              <form action="/join" method="post">
                <div class="form-group">
                  <label class="label" for="userId">아이디</label>
                </div>
                <div class="form-group">
                  <input
                    type="text"
                    id="userId"
                    name="userId"
                    placeholder="아이디를 입력하세요"
                    required
                  />
                  <button
                    type="button"
                    class="check-button"
                    onclick="checkId()"
                    id="check-button"
                  >
                    ID 중복확인
                  </button>
                  <span id="check-result"></span>
                </div>
                <div class="form-group">
                  <label class="label" for="password">비밀번호</label>
                </div>
                <div class="form-group">
                  <input
                    type="password"
                    id="pw"
                    name="pw"
                    placeholder="비밀번호를 입력하세요"
                    required
                  />
                </div>
                <div class="form-group">
                  <label class="label" for="confirm_password"
                    >비밀번호 확인</label
                  >
                </div>
                <div class="form-group">
                  <input
                    type="password"
                    id="confirm_password"
                    name="confirm_password"
                    placeholder="비밀번호를 다시 입력하세요"
                    required
                  />
                </div>
                <div class="message" id="message"></div>
                <div class="form-group">
                  <label class="label" for="email">Email</label>
                </div>
                <div class="form-group">
                  <input
                    type="email"
                    id="userEmail"
                    name="userEmail"
                    placeholder="abc@example.com"
                    required
                  />
                  <button
                    type="button"
                    class="verify-button"
                    onclick="sendEmail()"
                    id="verify-button"
                  >
                    email 중복확인
                  </button>
                </div>
                <div class="form-group">
                  <label class="label" for="username">이름</label>
                </div>
                <div class="form-group">
                  <input
                    type="text"
                    id="username"
                    name="username"
                    placeholder="이름을 입력하세요"
                    required
                  />
                </div>
                <div class="form-group gender-group">
                  <label class="gender-label" for="gender">성별</label>
                  <div class="gender-option">
                    <input
                      type="radio"
                      id="gender"
                      name="gender"
                      value="1"
                      required
                    />
                    <label for="male">남성</label>
                  </div>
                  <div class="gender-option">
                    <input
                      type="radio"
                      id="gender"
                      name="gender"
                      value="2"
                      required
                    />
                    <label for="female">여성</label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="label" for="phone">전화번호</label>
                </div>
                <div class="form-group">
                  <input
                    type="tel"
                    id="userPhone"
                    name="userPhone"
                    placeholder="010-xxxx-xxxx"
                    required
                  />
                </div>
                <div class="form-group">
                    <button type="reset" class="join-button" style="width: calc(50% - 50px);">다시쓰기</button>
                    <button type="submit" class="join-button" id="join-button">가입하기</button>
                </div>
              </form>
              <div class="you-ser">
                <a href="/login">이미 회원이신가요? 로그인 하기</a>
              </div>
            </div>
          </div>
        </section>
      </main>
		
	  <!-- footer -->
      <footer id="footer">
        <div class="footer1"><a href="#">Team Github</a></div>
        <p>© 2024 Made by oneTeam</p>
      </footer>
    </div>
    
    <!-- script -->
    <script type="text/javascript">
    //체크 표시 지우기
    function removeSign() {
       var checkResult = document.getElementById('check-result');
       checkResult.innerHTML = '';
    }
    
  	//아이디 중복체크
    function checkId() {
        var userId = document.getElementById('userId').value;
        var checkButton = document.getElementById('check-button');//중복확인 버튼
        var joinBtn = document.getElementById('join-button');//가입하기 버튼
        
        // userid 입력란이 빈칸일 경우(공백제거)
        if (userId.trim() === '') {
        	alert('아이디를 입력해주세요');
        	joinBtn.disabled = true;//가입하기 버튼 비활성화
        } else {
        	var newWindow = window.open('/checkId?userId=' + userId, 'checkId', 'width=400,height=250, top=150, left=800');
	        joinBtn.disabled = false;//가입하기 버튼 활성화
	        
	        removeSign();//체크 지우기
        }
    }

  	//아이디 중복체크 후 다시 userid를 변경할 경우
    document.getElementById('userId').addEventListener('input', function() {
        var joinBtn = document.getElementById('join-button');
        joinBtn.disabled = true; //가입하기 버튼 비활성화
        
        removeSign();//체크 지우기
    });

    //비밀번호 일치/불일치
    const confirmPw = document.getElementById('confirm_password');
    const pwMessage = document.getElementById('message');
    const joinBtn = document.getElementById('join-button');
    
    confirmPw.addEventListener('input', function () {
        const firstPw = document.getElementById('pw');  
        const pw = firstPw.value;
        const confirmPwd = confirmPw.value;

        if (confirmPwd === '') {
            pwMessage.innerText = ''; 
            pwMessage.style.color = ''; 
        } else if (pw !== confirmPwd) {
            pwMessage.innerText = '비밀번호가 일치하지 않습니다';
            pwMessage.style.color = 'red';
            joinBtn.disabled = true;//가입하기 버튼 비활성화
        } else {
            pwMessage.innerText = '비밀번호가 일치합니다';
            pwMessage.style.color = '';
            joinBtn.disabled = false;//가입하기 버튼 활성화
        }
    });

    
    //다시쓰기 버튼을 눌렀을 때 
    document.querySelector('.join-button[type="reset"]').addEventListener('click', function() {
    	removeSign();//체크표시 지우기
    });
    

    </script>
  </body>
</html>
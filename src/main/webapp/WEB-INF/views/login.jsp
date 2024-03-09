<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shuttle Cock</title>
    <link rel="stylesheet" href="/css/loginstyle.css">
</head>
<body>
	<!-- wrap -->
    <div id="wrap">
    
    	<!-- main -->
        <main id="main">
        	<!-- slider -->
            <div id="slider">
                <div class="imageWrap">
                    <div class="image i1">
                    </div>
                </div>
            </div>
			
			<!-- section -->
            <section id="contents">
                <div class="login-box">
                    <div class="login-title"><img src="/img/shuttle-logo.jpg" alt="Logo" onclick="location.href='/main'" /></div>

                    <div class="loginform">
                    	<!-- form -->
                        <form action="/login" method="post">
                            <div class="form-group">
                                <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요" required>
                            </div>
                            <div class="form-group">
                                <input type="password" id="pw" name="pw" placeholder="비밀번호를 입력하세요" required>
                            </div>
                            <label for="remember-check">
                                <input type="checkbox" id="remember-check" />
                                <span class="remember-text">로그인 상태 유지</span>
                            </label>
                            <div class="item1">
                                <span onclick="openPopup('/findsearch')">아이디 찾기</span>
                            	<span onclick="openPopup('/findsearch')">비밀번호 찾기</span>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="login-button">로그인</button>
                            </div>
                        </form>
                        <!-- // form -->
                        
                        <!-- 회원가입(링크) -->
                        <div class="you-join">
                            <div class="item"><a href="/join">회원가입을 하시겠습니까?</a></div>
                        </div>
                        
                        <!-- 구분선 -->
                        <div class="line"></div>
                        <button class="kakao-login">카카오톡 로그인</button>
                    </div>
                </div>
            </section>
            <!-- //section -->
        </main>
        <!-- //main -->

		<!-- footer -->
        <footer id="footer">
            <div class="footer1"><a href="#">Team Github</a></div>
            <p>© 2024 Made by oneTeam</p>
        </footer>
    </div>
    
    <script type="text/javascript">
    function openPopup(url) {
        var width = 500; 
        var height = 340; 
        var left = (screen.width - width) / 2;
        var top = (screen.height - height) / 2;
        var title = '아이디/비밀번호 찾기'; 
        var popupWindow = window.open('', title, 'width=' + width + ', height=' + height + ', top=' + top + ', left=' + left);

        popupWindow.location.href = url;
    }
    </script>
</body>
</html>
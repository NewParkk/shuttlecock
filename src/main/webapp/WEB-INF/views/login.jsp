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
	<% if (request.getAttribute("errorMsg") != null) { %>
        <script>
            alert("<%= request.getAttribute("errorMsg") %>");
        </script>
    <% } %>
    
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
                                <input type="checkbox" id="remember-check" name="remember-me" />
                                <span class="remember-text">로그인 상태 유지</span>
                            </label>
                            <div class="item1">
                                <span onclick="openPopup('/findsearch?tab=findIdSearch')">아이디 찾기</span>
                            	<span onclick="openPopup('/findsearch?tab=findPwSearch')">비밀번호 찾기</span>
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
                        <button class="kakao-login">
						<img src="/img/kakao.png">
						</button>
                        
                        <div class="line"></div>
                        <button class="naver-login">
                        <img src="/img/naver.png">
                        </button>
                        
                        <div class="line"></div>
                        <button class="google-login">
                        <img src="/img/google.png">
                        <span>구글 로그인</span>
                        </button>
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
    <script type="text/javascript">
    function openPopup(url) {
        var width = 500; 
        var height = 420; 
        var left = (screen.width - width) / 2;
        var top = (screen.height - height) / 2;
        var title = '아이디/비밀번호 찾기'; 
        var popupWindow = window.open('', title, 'width=' + width + ', height=' + height + ', top=' + top + ', left=' + left);

        popupWindow.location.href = url;
    }
    
    
    $(document).ready(function() 
    {
    	$('.kakao-login').click(function() 
    	{
			window.location.href = 'https://kauth.kakao.com/oauth/authorize' +
	    							'?response_type=code' +
	    							'&client_id=a94cb68f7a3356e950b067a4ffdc6d95' +
	    							'&redirect_uri=${loginDomain}kakaoLogin';
    	});
    	
    	$('.naver-login').click(function() 
    	{
			window.location.href = 'https://nid.naver.com/oauth2.0/authorize' +
	    							'?response_type=code' +
	    							'&client_id=FSQwLFUbTvnz71wxhlwK' +
	    							'&redirect_uri=${loginDomain}naverLogin' +
	    							'&state=${state}';
    	});
    	
    	$('.google-login').click(function() 
    	{
			window.location.href = 'https://accounts.google.com/o/oauth2/v2/auth' +
	    							'?client_id=339427214753-k5ggtr17joog964eu46ea1f2kl0au9t9.apps.googleusercontent.com' +
	    							'&redirect_uri=${loginDomain}googleLogin' +
	    							'&response_type=code' +
	    							'&scope=email profile';
    	});
    });
    </script>
</body>
</html>
package com.fp.global;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import com.fp.shuttlecock.user.UserDTO;
import com.fp.shuttlecock.user.UserServiceImpl;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class SessionInterceptor implements HandlerInterceptor
{	
	@Autowired
	private UserServiceImpl userService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception 
	{
		 // 자동로그인 유저를 위한 쿠키확인
		Cookie[] cookies = request.getCookies();
        if (cookies != null) 
        {
            for (Cookie cookie : cookies) 
            {
                if (cookie.getName().equals("autoLoginUser")) 
                {
                    // 쿠키에서 사용자 정보 추출
                    String userId = cookie.getValue();
                    // 자동 로그인 처리하는 서비스 호출
                    UserDTO user = userService.getUserByUserId(userId);
                    //현재 세션 초기화 후 위에서 불러온 user정보를 session에 저장
                    HttpSession session = request.getSession();
                    session.invalidate();
                    // 새로운 세션 생성 및 사용자 정보 저장
                    session = request.getSession(); 
                    session.setAttribute("user", user.getUserId());
                    session.setAttribute("isAdmin", user.isAdmin());
                    session.setAttribute("username", user.getUsername());
        			session.setAttribute("kakaoYN", user.isKakaoYN());
                    // 로그인 처리 후 메인 페이지로 리디렉션
                    response.sendRedirect(request.getContextPath() + "/main");
                    return false; // 인터셉터를 더 이상 실행하지 않고 요청을 종료합니다.
                }
            }
        }
		
		//session 유무 검증
		HttpSession session = request.getSession(false);
		
		if(session == null || session.getAttribute("userId") == null) {
			response.sendRedirect("/main");
			return false;
		}
		return true;
	}
}

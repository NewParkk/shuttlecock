package com.fp.global.interceptor;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.fp.shuttlecock.user.UserDTO;
import com.fp.shuttlecock.user.UserServiceImpl;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class AutoLoginInterceptor implements HandlerInterceptor
{	
	@Autowired
	private UserServiceImpl userService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception 
	{	
		 // 자동로그인 유저를 위한 쿠키확인
		Cookie[] cookies = request.getCookies();
//		System.out.println("자동로그인 핸들러 작동 유무");
        if (cookies != null) 
        {
            for (Cookie cookie : cookies) 
            {	
            	//자동로그인 유저인지 확인
                if (cookie.getName().equals("autoLoginUser")) 
                {	
//                	System.out.println("autoLoginUser 확인 : " + cookie.getValue());
                    // 쿠키에서 사용자 정보 추출
                    String userId = cookie.getValue();
                    // 자동 로그인 처리하는 서비스 호출
                    UserDTO user = userService.getUserByUserId(userId);
                    //현재 세션 초기화 후 위에서 불러온 user정보를 session에 저장
                    HttpSession session = request.getSession();
                    session.invalidate();
                    // 새로운 세션 생성 및 사용자 정보 저장
                    session = request.getSession(); 
                    session.setAttribute("userId", user.getUserId());
                    session.setAttribute("isAdmin", user.isAdmin());
                    session.setAttribute("username", user.getUsername());
        			session.setAttribute("kakaoYN", user.isKakaoYN());
        			session.setAttribute("badgeId", user.getBadgeId());
        			
                }
            }
        }
		
		return true;
	}
}

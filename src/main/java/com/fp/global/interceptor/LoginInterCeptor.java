package com.fp.global.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class LoginInterCeptor implements HandlerInterceptor
{	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception
	{	
//		System.out.println("Login 핸들러 작동 유무");
//		System.out.println("request 확인 : " + request.getSession().getAttribute("userId"));
		//session 유무 검증
		HttpSession session = request.getSession(false);
		if(session == null || session.getAttribute("userId") == null) 
		{
			response.sendRedirect("/login");
			return false;
		}
		return true;
	}
}
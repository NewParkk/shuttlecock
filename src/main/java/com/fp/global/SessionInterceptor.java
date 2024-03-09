package com.fp.global;

import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class SessionInterceptor implements HandlerInterceptor{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//session 유무 검증
		HttpSession session = request.getSession(false);
		
		if(session == null || session.getAttribute("userId") == null) {
			response.sendRedirect("/main");
			return false;
		}
		return true;
	}
}

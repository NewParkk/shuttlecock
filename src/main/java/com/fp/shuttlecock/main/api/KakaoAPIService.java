package com.fp.shuttlecock.main.api;

import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;

import jakarta.servlet.http.HttpSession;

public interface KakaoAPIService {
	
	//카카오 로그인
	String kakaoLogin(String code, HttpSession session, ModelAndView mv) throws JsonMappingException, JsonProcessingException;
	//카카오 나에게 보내기
	void sendKakaoMessage(String accessToken, HttpSession session) throws JsonProcessingException;
	
}

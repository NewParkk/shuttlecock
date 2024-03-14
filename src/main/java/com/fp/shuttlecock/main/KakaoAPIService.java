package com.fp.shuttlecock.main;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;

import jakarta.servlet.http.HttpSession;

public interface KakaoAPIService {

	String kakaoLogin(String code, HttpSession session, RedirectAttributes redirectAttributes) throws JsonMappingException, JsonProcessingException;

	void sendKakaoMessage(String accessToken, HttpSession session) throws JsonProcessingException;
	
}

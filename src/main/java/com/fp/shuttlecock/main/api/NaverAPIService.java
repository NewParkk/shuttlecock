package com.fp.shuttlecock.main.api;

import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;

import jakarta.servlet.http.HttpSession;

public interface NaverAPIService {

	String naverLogin(String code, HttpSession session, ModelAndView mv) throws JsonMappingException, JsonProcessingException;

}

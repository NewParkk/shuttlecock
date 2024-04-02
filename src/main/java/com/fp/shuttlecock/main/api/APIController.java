package com.fp.shuttlecock.main.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;

import jakarta.servlet.http.HttpSession;


@Controller
public class APIController {

    @Autowired
    private KakaoAPIService kakaoAPIService;
    
    @Autowired
    private NaverAPIService naverAPIService;

    @Autowired
    private GoogleAPIService googleAPIService;
    
    @GetMapping("/kakaoLogin")
    public String kakaoLogin(@RequestParam("code") String code, HttpSession session, ModelAndView mv) throws JsonMappingException, JsonProcessingException {
    	System.out.println("kakaoLogin 확인용");
        return kakaoAPIService.kakaoLogin(code, session, mv);
    }
    
    @GetMapping("/naverLogin")
    public String naverLogin(@RequestParam("code") String code, HttpSession session, ModelAndView mv) throws JsonMappingException, JsonProcessingException {
    	System.out.println("naverLogin 확인용");
        return naverAPIService.naverLogin(code, session, mv);
    }
    
    @GetMapping("/googleLogin")
    public String googleLogin(@RequestParam("code") String code, HttpSession session, ModelAndView mv) throws JsonMappingException, JsonProcessingException {
    	System.out.println("googleLogin 확인용");
    	return googleAPIService.googleLogin(code, session, mv);
    }
    
    
		
}

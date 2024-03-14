package com.fp.shuttlecock.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;

import jakarta.servlet.http.HttpSession;


@Controller
public class KakaoAPIController {

    @Autowired
    private KakaoAPIService kakaoAPIService;
    
    @GetMapping("/kakaoLogin")
    public String kakaoLogin(@RequestParam("code") String code, HttpSession session, RedirectAttributes redirectAttributes) throws JsonMappingException, JsonProcessingException {
    	System.out.println("kakaoLogin 확인용");
        return kakaoAPIService.kakaoLogin(code, session, redirectAttributes);
    }

}

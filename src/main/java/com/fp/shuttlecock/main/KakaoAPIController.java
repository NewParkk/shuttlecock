package com.fp.shuttlecock.main;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;


@Controller
public class KakaoAPIController {
	
	@GetMapping("/kakaoLogin")
	@ResponseBody
	public String kakaoLogin(String code) throws JsonMappingException, JsonProcessingException {
		//OkHttp
		//RestTemplate
		RestTemplate rt = new RestTemplate();

		//HttpHeader 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		//HttpBody 생성
		MultiValueMap<String, String>params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "ec9d318361ecd986f0d840a73495c081");
		params.add("redirect_uri", "http://localhost:8099/kakaoLogin");
		params.add("code", code);
		
		//HttpHeader와 HttpBody를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params,headers);
		
		//Post방식으로 Http요청하고 response변수의 응답을 받기
		ResponseEntity<String> response = rt.exchange
		(
			"https://kauth.kakao.com/oauth/token",
			HttpMethod.POST,
			kakaoTokenRequest,
			String.class
		);
		
		ObjectMapper objectMapper = new ObjectMapper();
		OAuthToken oauthToken = null;
		oauthToken = objectMapper.readValue(response.getBody(), OAuthToken.class);
	
		
		System.out.println("엑세스 토큰 : " + oauthToken.getAccess_token());
		
		
		RestTemplate rt2 = new RestTemplate();

		//HttpHeader 생성
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", "Bearer "+oauthToken.getAccess_token());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		//HttpHeader 담기
		HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest = new HttpEntity<>(headers2);
		
		//Post방식으로 Http요청하고 response변수의 응답을 받기
		ResponseEntity<String> response2 = rt2.exchange
		(
			"https://kapi.kakao.com/v2/user/me",
			HttpMethod.POST,
			kakaoProfileRequest,
			String.class
		);
		
		
		ObjectMapper objectMapper2 = new ObjectMapper();
		KakaoProfile kakaoProfile = objectMapper2.readValue(response2.getBody(), KakaoProfile.class);
		
		
		System.out.println("id : " + kakaoProfile.getId());
		System.out.println("Account : " + kakaoProfile.getKakaoAccount());
		System.out.println("Email : " + kakaoProfile.getKakaoAccount().getEmail());
		System.out.println("getProperties : " + kakaoProfile.getProperties());
		
		return response2.getBody();
	}
	
	@GetMapping("/kakaoLoginForm")
	public String kakaoLoginForm() {
		return "kakao";
	}
	
}

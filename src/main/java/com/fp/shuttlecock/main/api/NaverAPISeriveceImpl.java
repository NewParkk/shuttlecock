package com.fp.shuttlecock.main.api;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.Random;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Primary;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fp.shuttlecock.user.UserDTO;
import com.fp.shuttlecock.user.UserServiceImpl;

import jakarta.servlet.http.HttpSession;

@Primary
@Service
public class NaverAPISeriveceImpl implements NaverAPIService {
	
	@Value("${NAVER.KEY.ID}")
	private String apiKey;
	
	@Value("${NAVER.KEY.SECRET}")
	private String apiSecret;
	
	@Value("${KAKAO.LOGIN.DOMAIN}")
	private String loginDomain;
	
	@Autowired
	private UserServiceImpl userService;
	
	@Override
	public String naverLogin(String code, HttpSession session, ModelAndView mv) throws JsonMappingException, JsonProcessingException {
		
		//받아온 code로 사용자 정보 불러오기
		//RestTemplate
		RestTemplate rt = new RestTemplate();

		//HttpHeader 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		//HttpBody 생성
		MultiValueMap<String, String>params = new LinkedMultiValueMap<>();
		SecureRandom random = new SecureRandom();
	    String state = new BigInteger(130, random).toString();
	    params.add("grant_type", "authorization_code");
	    params.add("client_id", apiKey);
	    params.add("client_secret", apiSecret);
	    params.add("code", code);
		params.add("state", state);
		
		//HttpHeader와 HttpBody를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> naverTokenRequest = new HttpEntity<>(params,headers);
		
		//Post방식으로 Http요청하고 response변수의 응답을 받기
		ResponseEntity<String> response = rt.exchange
		(
			"https://nid.naver.com/oauth2.0/token",
			HttpMethod.POST,
			naverTokenRequest,
			String.class
		);
		
		//응답받은 response Token에 담기
		ObjectMapper objectMapper = new ObjectMapper();
		OAuthToken oauthToken = null;
		System.out.println("response : " + response);
		oauthToken = objectMapper.readValue(response.getBody(), OAuthToken.class);
		
		System.out.println("oauthToken : " + response.getBody().toString());
		
		
		//사용자 Profile 불러오기
		//RestTemplate
		RestTemplate rt2 = new RestTemplate();

		//HttpHeader 생성
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", "Bearer "+ oauthToken.getAccess_token());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		//HttpHeader 담기
		HttpEntity<MultiValueMap<String, String>> naverProfileRequest = new HttpEntity<>(headers2);
		
		//Post방식으로 Http요청하고 response변수의 응답을 받기
		ResponseEntity<String> response2 = rt2.exchange
		(
			"https://openapi.naver.com/v1/nid/me",
			HttpMethod.GET,
			naverProfileRequest,
			String.class
		);
		
		System.out.println("response2 : " + response2);
		ObjectMapper objectMapper2 = new ObjectMapper();
		NaverProfile naverProfile = objectMapper2.readValue(response2.getBody(), NaverProfile.class);
		
		String naverId = naverProfile.getResponse().getNickname();
		String username = naverProfile.getResponse().getNickname();
		String email = naverProfile.getResponse().getEmail();
		String strgender = naverProfile.getResponse().getGender();
		UUID uuid = UUID.randomUUID();
		String garbagePassword= uuid.toString().replace("-", "").substring(0, 12);
		int gender = strgender.equals("M") ? 1 : 2;
		UserDTO naverUser = UserDTO.builder()
							  .userId(username)
							  .username(username)
							  .userEmail(email)
							  .pw(garbagePassword)
							  .gender(gender)
							  .kakaoYN(true)
							  .build();
		UserDTO originUser = userService.getUserByUserId(naverId);
		
		// 가입한 아이디가 없으면 회원가입 진행
		if (originUser == null) {	
			userService.getJoinUser(naverUser);
		} 
		
		// 있으면 해당 정보로 로그인 진행
		UserDTO loginUser = userService.getUserByUserId(naverId);
		session.setAttribute("userId", loginUser.getUserId());
		session.setAttribute("isAdmin", loginUser.isAdmin());
		session.setAttribute("username", loginUser.getUsername());
		session.setAttribute("kakaoYN", loginUser.isKakaoYN());
		session.setAttribute("badgeId", loginUser.getBadgeId());
          
		
		
		return "redirect:/main";
		
	}
	
}

package com.fp.shuttlecock.main.api;

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
public class GoogleAPIServiceImpl implements GoogleAPIService{
	
	@Value("${GOOGLE.KEY.ID}")
	private String apiKey;
	
	@Value("${GOOGLE.KEY.PW}")
	private String apiPw;
	
	@Value("${KAKAO.LOGIN.DOMAIN}")
	private String loginDomain;
	
	@Autowired
	private UserServiceImpl userService;
	
	@Override
	public String googleLogin(String code, HttpSession session, ModelAndView mv) throws JsonMappingException, JsonProcessingException {
//		System.out.println("code : " + code);
		//받아온 code로 사용자 정보 불러오기
		//RestTemplate
		RestTemplate rt = new RestTemplate();

		//HttpHeader 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset");
		
		//HttpBody 생성
		MultiValueMap<String, String>params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("code", code);
		params.add("redirect_uri", loginDomain + "googleLogin");
		params.add("client_id", apiKey);
		params.add("client_secret", apiPw);
		
		//HttpHeader와 HttpBody를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> googleTokenRequest = new HttpEntity<>(params,headers);
		
		//Post방식으로 Http요청하고 response변수의 응답을 받기
		ResponseEntity<String> response = rt.exchange
		(
			"https://oauth2.googleapis.com/token",
			HttpMethod.POST,
			googleTokenRequest,
			String.class
		);
		
		//응답받은 response Token에 담기
		ObjectMapper objectMapper = new ObjectMapper();
		OAuthToken oauthToken = null;
		oauthToken = objectMapper.readValue(response.getBody(), OAuthToken.class);
//		System.out.println("oauthToken : " + response.getBody().toString());
//		System.out.println("Token값 확인 : " + oauthToken.getAccess_token());
		
		//사용자 Profile 불러오기
		//RestTemplate
		RestTemplate rt2 = new RestTemplate();

		//HttpHeader 생성
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", "Bearer "+ oauthToken.getAccess_token());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		//HttpHeader 담기
		HttpEntity<MultiValueMap<String, String>> googleProfileRequest = new HttpEntity<>(headers2);
		
		//Post방식으로 Http요청하고 response변수의 응답을 받기
		ResponseEntity<String> response2 = rt2.exchange
		(
			"https://www.googleapis.com/oauth2/v2/userinfo",
			HttpMethod.GET,
			googleProfileRequest,
			String.class
		);
		
//		System.out.println("googleProfileRequest : " + response2.getBody().toString());
		
		ObjectMapper objectMapper2 = new ObjectMapper();
		GoogleProfile googleProfile = objectMapper2.readValue(response2.getBody(), GoogleProfile.class);
//		System.out.println(googleProfile.toString());
		
		String googleId = googleProfile.getName();
		String username = googleProfile.getName();
		String email = googleProfile.getEmail();
		UUID uuid = UUID.randomUUID();
		String garbagePassword= uuid.toString().replace("-", "").substring(0, 12);
		int gender = 1;
		UserDTO googleUser = UserDTO.builder()
							  .userId(googleId)
							  .username(username)
							  .userEmail(email)
							  .pw(garbagePassword)
							  .gender(gender)
							  .kakaoYN(true)
							  .build();
		UserDTO originUser = userService.getUserByUserId(googleId);
		// 가입한 아이디가 없으면 회원가입 진행
		if (originUser == null) {	
			userService.getJoinUser(googleUser);
		} 
			
		// 있으면 해당 정보로 로그인 진행
		UserDTO loginUser = userService.getUserByUserId(googleId);
		session.setAttribute("userId", loginUser.getUserId());
		session.setAttribute("isAdmin", loginUser.isAdmin());
		session.setAttribute("username", loginUser.getUsername());
		session.setAttribute("kakaoYN", loginUser.isKakaoYN());
		session.setAttribute("badgeId", loginUser.getBadgeId());
		
		return "redirect:/main";
		
	}
}

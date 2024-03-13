package com.fp.shuttlecock.main;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
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
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fp.shuttlecock.user.UserDTO;
import com.fp.shuttlecock.user.UserServiceImpl;

import jakarta.servlet.http.HttpSession;


@Controller
public class KakaoAPIController {
	
	@Autowired
	UserServiceImpl userService;
	
	@GetMapping("/kakaoLogin")
	@ResponseBody
	public ModelAndView kakaoLogin(String code, HttpSession session) throws JsonMappingException, JsonProcessingException {
		//받아온 code로 사용자 정보 불러오기
		//RestTemplate
		RestTemplate rt = new RestTemplate();

		//HttpHeader 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		//HttpBody 생성
		MultiValueMap<String, String>params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "a94cb68f7a3356e950b067a4ffdc6d95");
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
		
		//응답받은 response Token에 담기
		ObjectMapper objectMapper = new ObjectMapper();
		OAuthToken oauthToken = null;
		oauthToken = objectMapper.readValue(response.getBody(), OAuthToken.class);
		
		
		// 
		RestTemplate rt2 = new RestTemplate();

		//HttpHeader 생성
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", "Bearer "+ oauthToken.getAccess_token());
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
		
		String id = kakaoProfile.getId().toString();
		String username = kakaoProfile.getProperties().getNickname();
		String email = kakaoProfile.getKakao_account().getEmail();
		String strgender = kakaoProfile.getKakao_account().getGender();
		int gender = 0;
		if (strgender.equals("male")) {
			gender = 1;
		}else {
			gender = 2;
		}
		UUID uuid = UUID.randomUUID();
		String garbagePassword= uuid.toString().replace("-", "").substring(0, 12);
		UserDTO kakaoUser = UserDTO.builder()
							  .userId(id)
							  .username(username)
							  .userEmail(email)
							  .pw(id)
							  .gender(gender)
							  .kakaoYN(true)
							  .build();
		UserDTO originUser = userService.getUserByUserId(id);
		
		ModelAndView mv = new ModelAndView();
		
		// 가입한 아이디가 있으면
		if (originUser == null) 
		{
			userService.getJoinUser(kakaoUser);
		// 없으면 회원가입 진행
		} else 
		{
			UserDTO loginUser = userService.getLoginUser(id, id);
			session.setAttribute("userId", loginUser.getUserId());
			session.setAttribute("isAdmin", loginUser.isAdmin());
		}
		// 리다이렉트할 뷰 이름 설정
		mv.setViewName("redirect:/main"); 
		
		return mv;
	}
	
	
}

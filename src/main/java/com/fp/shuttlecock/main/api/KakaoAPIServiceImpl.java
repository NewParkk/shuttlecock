package com.fp.shuttlecock.main.api;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import com.fp.shuttlecock.mypage.CalendarDTO;
import com.fp.shuttlecock.mypage.MypageServiceImpl;
import com.fp.shuttlecock.user.UserDTO;
import com.fp.shuttlecock.user.UserServiceImpl;

import jakarta.servlet.http.HttpSession;

@Primary
@Service
public class KakaoAPIServiceImpl implements KakaoAPIService{
	
	@Autowired
	private UserServiceImpl userService;
	
	@Autowired
	private MypageServiceImpl mypageService;
	
	@Value("${KAKAO.KEY.REST}")
	private String apiKey;
	
	@Value("${KAKAO.LOGIN.DOMAIN}")
	private String loginDomain;
	
	@Override
	public String kakaoLogin(String code, HttpSession session, ModelAndView mv) throws JsonMappingException, JsonProcessingException 
	{
		
		//받아온 code로 사용자 정보 불러오기
		//RestTemplate
		RestTemplate rt = new RestTemplate();

		//HttpHeader 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		//HttpBody 생성
		MultiValueMap<String, String>params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", apiKey);
		params.add("redirect_uri", loginDomain + "kakaoLogin");
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
		System.out.println("oauthToken : " + response.getBody().toString());
//		System.out.println("Token값 확인 : " + oauthToken.getAccess_token());
		//사용자 Profile 불러오기
		//RestTemplate
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
		String kakaoId = kakaoProfile.getProperties().getNickname();
		String username = kakaoProfile.getProperties().getNickname();
		String email = kakaoProfile.getKakao_account().getEmail();
		String strgender = kakaoProfile.getKakao_account().getGender();
		int gender = strgender.equals("male") ? 1 : 2;
		UUID uuid = UUID.randomUUID();
		String garbagePassword= uuid.toString().replace("-", "").substring(0, 12);
		UserDTO kakaoUser = UserDTO.builder()
							  .userId(kakaoId)
							  .username(username)
							  .userEmail(email)
							  .pw(garbagePassword)
							  .gender(gender)
							  .kakaoYN(true)
							  .build();
		UserDTO originUser = userService.getUserByUserId(kakaoId);
		// 가입한 아이디가 없으면 회원가입 진행
		if (originUser == null) {	
			userService.getJoinUser(kakaoUser);
		} 
		
		// 있으면 해당 정보로 로그인 진행
		UserDTO loginUser = userService.getUserByUserId(kakaoId);
		session.setAttribute("userId", loginUser.getUserId());
		session.setAttribute("isAdmin", loginUser.isAdmin());
		session.setAttribute("username", loginUser.getUsername());
		session.setAttribute("kakaoYN", loginUser.isKakaoYN());
		session.setAttribute("badgeId", loginUser.getBadgeId());
		
		sendKakaoMessage(oauthToken.getAccess_token(), session);
		
		return "redirect:/main";
	}

	@Override
	public void sendKakaoMessage(String accessToken, HttpSession session) throws JsonProcessingException 
	{	
		// 사용자의 모든 일정 리스트
//		System.out.println("session 확인 : "+session.getAttribute("userId"));
		List<CalendarDTO> calendarDTOs = mypageService.getCalendar((String)(session.getAttribute("userId")));
//		System.out.println(calendarDTOs);
		
		// 3일 내의 일정을 담은 배열 반환 (sql로 대체가능)
        List<CalendarDTO> talkDate = new ArrayList<>();

        // 현재 날짜 가져오기
        Calendar currentDate = Calendar.getInstance();
        currentDate.setTime(new Date());

        // 3일 후의 날짜 계산
        Calendar threeDaysLater = Calendar.getInstance();
        threeDaysLater.setTime(new Date());
        threeDaysLater.add(Calendar.DATE, 3);

        // 현재 날짜와 3일 후의 날짜 사이에 있는지 확인
        for (CalendarDTO calendarDTO : calendarDTOs) 
        {
            // CalendarDTO의 날짜 가져오기
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(calendarDTO.getDate());

            // 현재 날짜와 3일 후의 날짜 사이에 있는 경우에만 결과에 추가
            if (currentDate.compareTo(calendar) <= 0 && calendar.compareTo(threeDaysLater) <= 0) {
            	talkDate.add(calendarDTO);
            }
        }
        
//        System.out.println("talkDateList : " + talkDate);
        
        // 3일이내 일정들 알람톡으로 보내기
        for (CalendarDTO calendarDTO : talkDate) 
        {
        	UserDTO user = userService.getUserByUserId(calendarDTO.getUserId());
			
        	//알람톡 보내기
        	//RestTemplate
        	RestTemplate rt = new RestTemplate();
        	
        	//HttpHeader 생성
        	HttpHeaders headers = new HttpHeaders();
        	headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
        	headers.add("Authorization", "Bearer "+ accessToken);
        	
        	//HttpBody 생성
        	// template_object를 Map에 담기
        	Map<String, Object> templateObject = new HashMap<>();
        	templateObject.put("object_type", "text");
        	templateObject.put("text",user.getUsername() + "님!\n" + calendarDTO.getDate() + "일\n" + calendarDTO.getTitle() + " 일정이 예정되어있습니다!");
        	Map<String, String> link = new HashMap<>();
        	link.put("web_url", loginDomain + "mypage");
        	link.put("mobile_web_url", loginDomain + "mypage");
        	templateObject.put("link", link);
        	templateObject.put("button_title", "바로 확인");
        	
        	// ObjectMapper를 사용하여 Map을 JSON 문자열로 변환
        	ObjectMapper objectMapper = new ObjectMapper();
        	String templateJson = objectMapper.writeValueAsString(templateObject);
        	
        	MultiValueMap<String, String>params = new LinkedMultiValueMap<>();
        	params.add("template_object", templateJson);
        	
        	//HttpHeader 담기
        	HttpEntity<MultiValueMap<String, String>> kakaoTalkMessage = new HttpEntity<>(params,headers);
        	
        	//Post방식으로 Http요청하고 response변수의 응답을 받기
        	ResponseEntity<String> response = rt.exchange
        	(
				"https://kapi.kakao.com/v2/api/talk/memo/default/send",
				HttpMethod.POST,
				kakaoTalkMessage,
				String.class
        	);
        	
//        	System.out.println("response" + response.getBody().toString());
        	
        	
		}
        
	}


	
	
	
}

package com.fp.shuttlecock.user;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@Controller
public class UserController {
	
	@Autowired
	UserServiceImpl userService;
	
	@Value("${KAKAO.LOGIN.DOMAIN}")
	private String loginDomain;
	
	//로그인
	@GetMapping("/login")
	public String loginForm(Model model) {
		SecureRandom random = new SecureRandom();
	    String state = new BigInteger(130, random).toString();
		model.addAttribute("loginDomain",loginDomain);
		model.addAttribute("state",state);
		return "login"; //WEB-INF/views/login.jsp
	}
	
	@PostMapping("/login")
	public String loginUser(String userId, String pw, HttpSession session, Model model, 
							@RequestParam(value = "remember-me", required = false) boolean autoLogin, 
							HttpServletResponse response, HttpServletRequest request) 
	{
		UserDTO user = null;
//		System.out.println("autoLogin 값 : " + autoLogin);
		
		user = userService.getLoginUser(userId, pw);

		if(user!=null) 
		{
			session.setAttribute("userId", user.getUserId());
			session.setAttribute("isAdmin", user.isAdmin());
			session.setAttribute("username", user.getUsername());
			session.setAttribute("kakaoYN", user.isKakaoYN());
			session.setAttribute("badgeId", user.getBadgeId());
			
			if (autoLogin) 
			{
	            // 자동 로그인이 체크된 경우, 쿠키를 생성하고 저장합니다.
	            createAutoLoginCookie(response, user.getUserId());
	        } else
	        {
	            // 자동 로그인이 체크되지 않은 경우 해당 userId를 가진 쿠키의 만료 기간을 0으로 설정하여 무효화합니다.
	            invalidateAutoLoginCookie(response, user.getUserId(), request);
	        }
			
			return "redirect:/main";
		}else {
	        model.addAttribute("errorMsg", "아이디 또는 비밀번호가 일치하지 않습니다.");
	        return "login";
	    }
		
	}
	
	// 자동 로그인을 위한 쿠키 생성
	private void createAutoLoginCookie(HttpServletResponse response, String userId) 
	{
		Cookie autoLoginCookie = new Cookie("autoLoginUser", userId); // 쿠키 이름과 값 설정
		autoLoginCookie.setMaxAge(7 * 24 * 60 * 60); // 쿠키의 만료 시간 설정 (예: 7일)
		autoLoginCookie.setPath("/"); // 쿠키의 유효 범위 설정
		System.out.println("자동로그인 cookie 저장됨");
		response.addCookie(autoLoginCookie); // 응답에 쿠키 추가
	}
	
	// 자동 로그인 해제시 쿠키 삭제
	private void invalidateAutoLoginCookie(HttpServletResponse response, String userId, HttpServletRequest request) 
	{
	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) 
	    {
	        for (Cookie cookie : cookies) 
	        {
	            if (cookie.getName().equals("autoLoginUser") && cookie.getValue().equals(userId)) 
	            {
	                cookie.setMaxAge(0); 
	                cookie.setPath("/");
	                response.addCookie(cookie);
	                break;
	            }
	        }
	    }
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {

		if(session != null) {
			session.invalidate();
		}
		
		Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            cookie.setMaxAge(0);
	            response.addCookie(cookie);
	        }
	    }
		return "redirect:/main";
	}
	
	
	//회원가입
	@GetMapping("/join")
	public String joinForm() {
		return "join"; //WEB-INF/views/join.jsp
	}
	
	@PostMapping("/join")
	public String joinUser(@ModelAttribute UserDTO userDTO, Model model) {
		UserDTO user = null;
		String view = "error";
		boolean result = false;

		if(userDTO.getUserId() == null || userDTO.getUserId().isEmpty() || userDTO.getPw() == null) {
			model.addAttribute("error", "아이디 / 비밀번호를 입력해주세요!");
	        return view;
	    }
		
		try {
			user = userService.getUserByUserId(userDTO.getUserId());
			
			if(user != null) {
				model.addAttribute("error", "존재하는 아이디입니다");
		        return view;
			} else {
				result = userService.getJoinUser(userDTO);
				if(result) {
					view = "redirect:/login";
				}
			}
		} catch (Exception e) {
		    e.printStackTrace(); // 예외를 콘솔에 출력
		    model.addAttribute("error", "회원가입중 오류가 발생했습니다.");
		    return view;
		}
		return view;	
	}
	
	//아이디 중복 체크
	@GetMapping("/checkId")
	public String checkIdForm(@RequestParam("userId") String userId, Model model) {
		boolean result = userService.isCheckId(userId);
	    String message;
	    String checkButton;
	    
	    if (result) {
	        message = userId + "는 사용가능한 아이디입니다";
	        checkButton = "사용";
	    } else {
	        message = userId + "는 이미 사용중인 아이디입니다";
	        checkButton = "확인";
	    }

	    model.addAttribute("message", message); 
	    model.addAttribute("userId", userId);
	    model.addAttribute("checkButton", checkButton);
	    return "checkId"; //WEB-INF/views/checkId.jsp
	}
	
	//아이디/비밀번호 찾기(링크)
	@GetMapping("/findsearch")
	public String findsearchForm() {
		return "findsearch"; //WEB-INF/views/findsearch.jsp
	}
	
	//아이디 찾기
	 @PostMapping("/findIdSearch")
	    public ResponseEntity<?> findIdSearch(@RequestParam String username, @RequestParam String userEmail) {
	        try {
	            UserDTO userDTO = new UserDTO();
	            userDTO.setUsername(username);
	            userDTO.setUserEmail(userEmail);
	            
	            UserDTO userId = userService.findUserId(userDTO);

	            if (userId != null) {
	                return ResponseEntity.ok(userId.getUserId());
	            } else {
	                return ResponseEntity.ok(null);
	            }
	        } catch (Exception e) {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류 발생");
	        }
	    }
	
	 //비밀번호 찾기	 
	 @PostMapping("/findPwSearch")
	 public ResponseEntity<String> sendEmail(@RequestParam String userId, @RequestParam String userEmail, HttpServletRequest request) {
	     try {
	         //해당 아이디와 이메일을 가지고 있는 회원이 존재하는지 확인
	         boolean isExistUser = userService.isExistUser(userId, userEmail);
	         if (isExistUser) {
	             String sendEmailNum = userService.sendEmail(userEmail);
	             request.getSession().setAttribute("sendEmailNum", sendEmailNum);
	             return ResponseEntity.ok("success");
	         } else {
	             return ResponseEntity.ok("fail");
	         }
	     } catch (Exception e) {
	         e.printStackTrace();
	         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("이메일 전송 중 오류가 발생했습니다.");
	     }
	 }
	
	 //이메일로 보내진 인증번호 확인
	 @PostMapping("/checkNum")
	 public ResponseEntity<String> confirmCheckPw(@RequestParam String sendNum, HttpServletRequest request) {
	     String sendEmailNum = (String) request.getSession().getAttribute("sendEmailNum");

	     if (sendEmailNum != null && sendNum.equals(sendEmailNum)) {
	         //System.out.println("성공"); //확인용
	         return ResponseEntity.ok("success");
	     } else {
	         //System.out.println("실패");
	         return ResponseEntity.ok("fail");
	     }
	 }
	

	 //새 비밀번호로 변경
	 @PostMapping("/changePw")
	 public ResponseEntity<String> changePassword(@RequestParam("userId") String userId, @RequestParam("pw") String pw) {
		
		//확인용
		//System.out.println(userId);
		//System.out.println(pw);
		
		boolean success = userService.changePassword(userId, pw);
        
		if (success) {
	        return ResponseEntity.ok("success"); 
	    } else {
	        return ResponseEntity.ok("fail"); 
	    }
	}

	
	//이메일 중복 체크
	@GetMapping("/checkEmail")
	@ResponseBody
	public Map<String, Object> checkEmailForm(@RequestParam("userEmail") String userEmail) {
	    boolean result = userService.isCheckEmail(userEmail);
	    String emessage;

	    if (result) {
	        emessage = "사용가능한 email입니다";
	    } else {
	        emessage = "이미 사용중인 email입니다";
	    }

	    Map<String, Object> response = new HashMap<>();
	    response.put("emessage", emessage);
	    response.put("userEmail", userEmail);

	    return response;
	}

}
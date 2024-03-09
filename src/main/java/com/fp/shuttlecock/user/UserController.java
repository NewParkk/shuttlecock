package com.fp.shuttlecock.user;

import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;


@Controller
public class UserController {
	
	@Autowired
	UserServiceImpl userService;

	//로그인
	@GetMapping("/login")
	public String loginForm() {
		return "login"; //WEB-INF/views/login.jsp
	}
	
	@PostMapping("/login")
	public String loginUser(String userId, String pw, HttpSession session) {
		String view = "error";
		UserDTO user = null;
		
		user = userService.getLoginUser(userId, pw);

		if(user!=null) {
			session.setAttribute("userId", user.getUserId());
			session.setAttribute("admin", user.getAdmin());
			view = "redirect:/main";
			return view;
		}
		return view;
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {

		if(session != null) {
			session.invalidate();
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
	        message = userId + " 이미 사용중인 아이디입니다";
	        checkButton = "확인";
	    }

	    model.addAttribute("message", message); 
	    model.addAttribute("userId", userId);
	    model.addAttribute("checkButton", checkButton);
	    return "checkId"; //WEB-INF/views/checkId.jsp
	}

}
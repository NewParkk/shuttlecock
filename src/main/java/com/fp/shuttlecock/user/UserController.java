package com.fp.shuttlecock.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class UserController {
	
	@Autowired
	UserServiceImpl userService;

	@GetMapping("/login")
	public String loginForm() {
		return "login"; //WEB-INF/views/login.jsp
	}
	
	//로그인
	@PostMapping("/login")
	public ModelAndView loginUser(String userId, String pw) {
		UserDTO user = userService.getLoginUser(userId, pw);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("main");
		mv.addObject("user",user);
		
		return mv;
	}
	
	@GetMapping("/joinUser")
	public String join() {
		return "join"; //WEB-INF/views/join.jsp
	}
	
	//회원가입
	@PostMapping("/joinUser")
	public ModelAndView joinUser(UserDTO userDTO) {
	    ModelAndView mv = new ModelAndView();
	    String view = "login";
	    int result = 0;

	    try {
	        result = userService.getJoinUser(userDTO);
	        mv.addObject("result", result); //result 데이터 전달
	    } catch (Exception e) {
	        // 오류 발생시
	        mv.addObject("error", "사용자 등록 중 오류가 발생했습니다."); 
	        view = "error"; //에러 페이지
	    }

	    mv.setViewName(view); 
	    return mv;
	}
	
}

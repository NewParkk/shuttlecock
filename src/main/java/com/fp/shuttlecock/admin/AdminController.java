package com.fp.shuttlecock.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.fp.shuttlecock.user.UserDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

	@Autowired
	AdminServiceImpl service;

	// 모든회원 리스트
	@GetMapping("/admin")
	public String getAllUserList(HttpSession session ,PageRequestDTO pageRequest, Model model) {
		
		String userId = session.getAttribute("userId").toString();
		UserDTO user = service.getMypage(userId);
		
		if (user.isAdmin() == true) {
			model.addAttribute("user" ,user);
			System.out.println(pageRequest);
			List<UserDTO> userList = service.getAllUserList();
			List<UserDTO> userSearchList = service.getUserBySearchWithPage(pageRequest);
			
			// 검색했을때 1페이지로 넘어가기
			int totalCount = service.getTotalCount(pageRequest);
			
			PageResponseDTO pageResponse = new PageResponseDTO().builder()
					.total(totalCount)
					.pageAmount(pageRequest.getAmount())
					.pageRequest(pageRequest)
					.build();
			
			model.addAttribute("userList", userList);
			model.addAttribute("userSearchList", userSearchList);
			model.addAttribute("pageInfo", pageResponse);
		}else {
			return "error/error";
		}

		return "admin/adminPage";
	}

	// 회원 상세보기
	@GetMapping("/admin/{userId}")
	public String getUserByUserId( @PathVariable String userId, Model model, HttpSession session) {
		
		// 로그인한 유저 
		String loginUserId = session.getAttribute("userId").toString();
		UserDTO loginUser = service.getMypage(loginUserId);
		
		if (loginUser.isAdmin() == true) {
			model.addAttribute("loginUser" ,loginUser);
			
			// 상세보기 유저
			UserDTO user = service.getUserByUserId(userId);
			model.addAttribute("user", user);
			System.out.println(user);
		} else {
			return "error/error_500";
		}
		
		// 검색한 회원 정보
		return "admin/adminPageDetail";
	}
	
	@DeleteMapping(value = "/admin/delete/{userId}")
	public ResponseEntity<String> deleteUser(@PathVariable String userId, HttpSession session) {
	    System.out.println("삭제 메소드 실행");
	    boolean result = false;
	    if (String.valueOf(session.getAttribute("userId")) != null
	            && (session.getAttribute("isAdmin") != null && ((boolean) session.getAttribute("isAdmin")))) {
	    	
	    	result = service.deleteUser(userId); // deleteUser 메소드 호출하여 사용자 삭제
	        if (result) {
	            return ResponseEntity.ok("사용자 삭제 성공");
	        } else {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("사용자 삭제 실패");
	        }
	    } else {
	        return ResponseEntity.status(HttpStatus.FORBIDDEN).body("삭제 권한 없음");
	    }
	}
	
	// 관리자 부여
	@PostMapping("/admin/{userId}")
	public String updateUserAdmin(@PathVariable String userId, @ModelAttribute UserDTO newUser, HttpServletRequest request) {
		UserDTO user = null;
		String view = "error/error";
		boolean result = false;

		// 체크박스 boolean 여부 true, false
		boolean checkboxValue = request.getParameter("checkbox") != null;
		System.out.println("Checkbox value: " + checkboxValue);
		
		
		user = service.getUserByUserId(userId);
		user.setAdmin(checkboxValue);
		result = service.updateUserAdmin(user);
	

		if (result) {
			view = "redirect:/admin/{userId}";
			return view;
		}
		return view;
	}

//	// 오늘 방문자수
//	@GetMapping("/visitor")
//	public String todayVisit(Model model) {
//		List<VisitorDTO> visitorList = service.todayVisit();
//		model.addAttribute("visitorList", visitorList);
//
//		return "admin/visitor";
//	}

}

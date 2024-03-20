package com.fp.shuttlecock.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.fp.shuttlecock.mypage.MypageServiceImpl;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

	@Autowired
	AdminServiceImpl service;

	// 모든회원 리스트
	@GetMapping("/admin")
	public String getAllUserList(PageRequestDTO pageRequest, Model model) {
		
		System.out.println(pageRequest);
		
		List<UserDTO> userList = service.getAllUserList();
		
		List<UserDTO> userSearchList = service.getUserBySearchWithPage(pageRequest);
		
		// 검색했을때 1페이지로 넘어가기
		if (pageRequest.getPageNum() != 1) {
			pageRequest.setPageNum(1);
		}
		
		// 키워드가 빈칸일때 null
		/*
		 * if(pageRequest.getSearchKeyword() != "" && pageRequest.getSearchKeyword() !=
		 * null) {
		 * 
		 * }else { pageRequest.setSearchKeyword(null);
		 * 
		 * }
		 */

		int totalCount = service.getTotalCount(pageRequest);
		
		PageResponseDTO pageResponse = new PageResponseDTO().builder()
									.total(totalCount)
									.pageAmount(pageRequest.getAmount())
									.pageRequest(pageRequest)
									.build();
		
		model.addAttribute("userList", userList);
		model.addAttribute("userSearchList", userSearchList);
		model.addAttribute("pageInfo", pageResponse);


		return "admin/adminPage";
	}

	// 회원 상세보기
	@GetMapping("/admin/{userId}")
	public String getUserByUserId(@PathVariable String userId, Model model) {
		UserDTO user = service.getUserByUserId(userId);
		model.addAttribute("user", user);

		return "admin/adminPageDetail";
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
			view = "redirect:/admin";
			return view;
		}
		return view;
	}

	// 오늘 방문자수
	@GetMapping("/visitor")
	public String todayVisit(Model model) {
		List<VisitorDTO> visitorList = service.todayVisit();
		model.addAttribute("visitorList", visitorList);

		return "admin/visitor";
	}

}

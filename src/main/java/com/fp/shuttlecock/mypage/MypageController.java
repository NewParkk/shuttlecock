package com.fp.shuttlecock.mypage;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.fp.shuttlecock.admin.UserDTO;

@Controller
public class MypageController {

	@Autowired
	MypageServiceImpl service;

	// 마이페이지 폼
	@GetMapping("/mypage")
	public String getMypage(@PathVariable String userId, Model model) {
		UserDTO user = service.getMypage(userId);
		List<CalendarDTO> calendarList = service.getCalendar(userId);

		model.addAttribute("user", user);
		model.addAttribute("user", calendarList);

		return "mypage/myPage";
	}

	// 캘린더 추가
	@PostMapping("/mypage")
	public String insertCalendar(@PathVariable String userId, @ModelAttribute CalendarDTO newCalendar, Model model) {
		boolean result = false;
		newCalendar.setUser_userId(userId);
		result = service.insertCalendar(newCalendar);

		return "mypage/myPage";
	}

	// 캘린더 수정
	@PutMapping("/mypage")
	public String updateCalendar(@PathVariable String userId, @ModelAttribute CalendarDTO newCalendar, Model model,
			Date date) {
		CalendarDTO calendar = service.getCalendarByDate(date);
		calendar.setTitle(newCalendar.getTitle());
		boolean result = service.updateCalendar(newCalendar);

		return "mypage/myPage";
	}

	// 캘린더 삭제
	@DeleteMapping("/mypage")
	public String deleteCalendar(@PathVariable String userId) {
		boolean result = false;
		result = service.deleteCalendar(userId);
		
		return "mypage/myPage";
	}

	// 회원정보 수정폼
	@GetMapping("/updateUser")
	public String getUserId(@PathVariable String userId, Model model) {
		UserDTO user = service.getMypage(userId);
		model.addAttribute("user", user);
		
		return "mypage/updateUser";
	}

	// 회원정보 수정
	@PutMapping("/updateUser")
	public String updateUser(@PathVariable String userId, @ModelAttribute UserDTO newUser, Model model) {
		UserDTO user = service.getMypage(userId);
		// username, email, phone
		user.setUsername(newUser.getUsername());
		user.setUserEmail(newUser.getUserEmail());
		user.setUserPhone(newUser.getUserPhone());

		model.addAttribute("user", user);
		boolean result = service.updateUser(user);
		
		return "mypage/mypage";
	}

	// 회원탈퇴
	@DeleteMapping("/updateUser")
	public String deleteUser(@PathVariable String userId) {
		boolean result = false;
		result = service.deleteUser(userId);
		
		return "redirect:/main";
	}

	// 나의 활동내역 폼
	@GetMapping("/record")
	public String getRecord(@PathVariable String userId, Model model) {
		UserDTO user = service.getMypage(userId);
		model.addAttribute(model);
		
		return "mypage/record";
	}

	// 나의 활동내역
	@GetMapping("/record/{userId}")
	public String getLeagueboard(@PathVariable String userId, Model model) {
		UserDTO user = service.getMypage(userId);

		// 게시물
		List<LeagueboardDTO> leagueList = service.getLeagueboard(userId);
		List<FreeboardDTO> freeList = service.getFreeboard(userId);
		List<TradeboardDTO> tradeList = service.getTradeboard(userId);
		List<RecruitboardDTO> recruitList = service.getRecrtitboard(userId);

		model.addAttribute("league", leagueList);
		model.addAttribute("free", freeList);
		model.addAttribute("trade", tradeList);
		model.addAttribute("recruit", recruitList);

		// 댓글
		List<CommentsDTO> commentList = service.getComment(userId);

		model.addAttribute("comment", commentList);

		// 좋아요
		List<LikesDTO> likeList = service.getLike(userId);

		model.addAttribute("like", likeList);

		String view = "redirect:/record";
		return view;
	}

}

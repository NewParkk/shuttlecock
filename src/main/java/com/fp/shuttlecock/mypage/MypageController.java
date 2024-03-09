package com.fp.shuttlecock.mypage;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;

@Controller
public class MypageController {

	@Autowired
	MypageServiceImpl service;

	// 마이페이지 폼
	@GetMapping("/mypage")
	public String getMypage(HttpSession session, Model model) {
		String userId =session.getAttribute("userId").toString();
		System.out.println((String)session.getAttribute("userId"));
		
		UserDTO user = service.getMypage(userId);
		List<CalendarDTO> calendarList = service.getCalendar(userId);

		model.addAttribute("user", user);
		model.addAttribute("calendarList", calendarList);

		return "mypage/myPage";
	}

//	// 캘린더 추가
//	@PostMapping("/mypage")
//	public String insertCalendar(HttpSession session, @ModelAttribute CalendarDTO newCalendar, Model model) {
//		String userId =session.getAttribute("userId").toString();
//		boolean result = false;
//		newCalendar.setUser_userId(userId);
//		result = service.insertCalendar(newCalendar);
//
//		return "mypage/myPage";
//	}
//
//	// 캘린더 수정
//	@PutMapping("/mypage")
//	public String updateCalendar(HttpSession session, @ModelAttribute CalendarDTO newCalendar, Model model,
//			Date date) {
//		String userId =session.getAttribute("userId").toString();
//		CalendarDTO calendar = service.getCalendarByDate(date);
//		calendar.setTitle(newCalendar.getTitle());
//		boolean result = service.updateCalendar(newCalendar);
//
//		return "mypage/myPage";
//	}
//
//	// 캘린더 삭제
//	@DeleteMapping("/mypage")
//	public String deleteCalendar(@PathVariable String userId) {
//		boolean result = false;
//		result = service.deleteCalendar(userId);
//
//		return "mypage/myPage";
//	}
//
	// 회원정보 수정폼
	@GetMapping("/updateUser")
	public String getUserId(HttpSession session, Model model) {
		String userId =session.getAttribute("userId").toString();
		UserDTO user = null;
		try {
			user = service.getMypage(userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("user", user);

		return "mypage/updateUser";
	}

	// 회원정보 수정
	@PostMapping("/updateUser")
	public String updateUser(HttpSession session, @ModelAttribute UserDTO newUser, MultipartFile file) {
		String userId =session.getAttribute("userId").toString();
		UserDTO user = service.getMypage(userId);
		
		// username, email, phone
		user.setUsername(newUser.getUsername());
		user.setUserEmail(newUser.getUserEmail());
		user.setUserPhone(newUser.getUserPhone());

		boolean result = service.updateUser(user);
		if(file != null) {
			service.insertImage(file, userId);
		}
		return "redirect:mypage";
	}

	// 회원탈퇴
	@RequestMapping("/deleteUser")
	public String deleteUser(HttpSession session) {
		String userId = session.getAttribute("userId").toString();
		boolean result = false;
		result = service.deleteUser(userId);
		session.invalidate();

		return "redirect:/login";
	}

	// 나의 활동내역 폼
//	@GetMapping("/record")
//	public String getRecord(HttpSession session, Model model) {
//		String userId = session.getAttribute("userId").toString();
//		UserDTO user = null;
//		try {
//			user = service.getMypage(userId);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		model.addAttribute("user",user);
//
//		return "mypage/record";
//	}

	// 나의 활동내역
	@GetMapping("/record")
	public String getLeagueboard(HttpSession session, Model model) {
		String userId = session.getAttribute("userId").toString();

		UserDTO user = service.getMypage(userId);
		
		model.addAttribute("user", user);
		
		// 게시물
		List<LeagueboardDTO> leagueList = service.getLeagueboard(userId);
		List<FreeboardDTO> freeList = service.getFreeboard(userId);
		List<TradeboardDTO> tradeList = service.getTradeboard(userId);
		List<RecruitboardDTO> recruitList = service.getRecruitBoard(userId);

		model.addAttribute("league", leagueList);
		model.addAttribute("free", freeList);
		model.addAttribute("trade", tradeList);
		model.addAttribute("recruit", recruitList);

		// 댓글
		List<CommentsDTO> commentList = service.getComment(userId);

		model.addAttribute("comment", commentList);

		// 좋아요
		/* List<LikesDTO> likeList = service.getLike(userId); */
		List<HashMap<String, Object>> likeList = service.getLike(userId);
		model.addAttribute("like", likeList);

		String view = "mypage/record";
		return view;
	}

}

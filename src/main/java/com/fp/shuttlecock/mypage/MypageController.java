package com.fp.shuttlecock.mypage;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;

@Controller
public class MypageController {

	@Autowired
	MypageServiceImpl service;

	@Autowired
	FileUploadAPI fileupload;

	// 마이페이지 폼
	@GetMapping("/mypage")
	public String getMypage(HttpSession session, Model model) {
		String userId = session.getAttribute("userId").toString();
		System.out.println((String) session.getAttribute("userId"));

		UserDTO user = service.getMypage(userId);
		List<CalendarDTO> calendarList = service.getCalendar(userId);
		model.addAttribute("user", user);
		model.addAttribute("calendarList", calendarList);

		return "mypage/myPage";
	}

	// 캘린더 추가
	@PostMapping("/mypage")
	public String insertCalendar(HttpSession session, @ModelAttribute CalendarDTO newCalendar) {
		String userId = session.getAttribute("userId").toString();
		boolean result = false;
		newCalendar.setUserId(userId);
		result = service.insertCalendar(newCalendar);

		return "redirect:mypage";
	}

	// 캘린더 삭제
	@GetMapping("/delete.do")
	public String deleteCalendar(CalendarDTO calendarId) {
		System.out.println(calendarId);
		boolean result = false;
		result = service.deleteCalendar(calendarId);

		return "redirect:mypage";
	}

	// 회원정보 수정폼
	@GetMapping("/updateUser")
	public String getUserId(HttpSession session, Model model) {

		String userId = session.getAttribute("userId").toString();
//		fileupload.ncpFileupload(session);
		UserDTO user = null;
		user = service.getMypage(userId);
		model.addAttribute("user", user);
		return "mypage/updateUser";
	}

	// 회원정보 수정
	@PostMapping("/updateUser")
	public String updateUser(HttpSession session, @ModelAttribute UserDTO newUser, MultipartFile file) {
		String userId = session.getAttribute("userId").toString();
		UserDTO user = service.getMypage(userId);

		// username, email, phone
		user.setUsername(newUser.getUsername());
		user.setUserEmail(newUser.getUserEmail());

		boolean result = service.updateUser(user);

		System.out.println("파일 이미지: " + file.getOriginalFilename());
		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			System.out.println("파일!!" + file);
			String name = file.getOriginalFilename();
			String path = "C:\\multi\\image";
			UserDTO userFile = UserDTO.builder().userId(userId).userImageName(name).userImagePath(path).build();

			try {
				if (!new File(path).exists()) { // 존재여부 확인
					new File(path).mkdir(); // 파일 만들기
				}
				file.transferTo(new File(path + "\\" + name));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			service.insertImage(userFile);

			fileupload.ncpFileupload(session);
		}

		return "redirect:mypage";
	}

	// 회원탈퇴
	@RequestMapping("/deleteUser")
	public String deleteUser(HttpSession session, @RequestParam("pw") String pw) {
		String userId = session.getAttribute("userId").toString();
		UserDTO user = service.getMypage(userId);

		boolean result = false;
		System.out.println(user);
		System.out.println(pw.getClass());
		System.out.println(user.getPw().getClass());

		if (user.getPw() != (String) pw) {
			result = service.deleteUser(userId);
			session.invalidate();

		} else {
			return "error";
		}

		return "redirect:/login";
	}

	// 나의 활동내역
	@GetMapping("/record")
	public String getRecord(HttpSession session, Model model, PageRequestDTO pageRequest) {
		String userId = session.getAttribute("userId").toString();
		
		System.out.println(pageRequest);
		
		
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

//		List<HashMap<String, Object>> boardList = service.getBoard(pageRequest);
//		int totalCount = service.getTotalCount(pageRequest);
		
		
		
//		model.addAttribute("board", boardList);
//		
//		System.out.println(boardList);

		// 댓글
		List<CommentsDTO> commentList = service.getComment(userId);

		model.addAttribute("comment", commentList);

		// 좋아요
		List<HashMap<String, Object>> likeList = service.getLike(userId);
		model.addAttribute("like", likeList);
		System.out.println(likeList);
		
		return "mypage/record";
	}

}

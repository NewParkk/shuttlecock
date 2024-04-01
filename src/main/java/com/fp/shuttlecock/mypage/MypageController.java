package com.fp.shuttlecock.mypage;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.fp.shuttlecock.comments.CommentsDTO;
import com.fp.shuttlecock.freeboard.FreeboardDTO;
import com.fp.shuttlecock.leagueboard.LeagueboardDTO;
import com.fp.shuttlecock.recruitboard.RecruitboardDTO;
import com.fp.shuttlecock.tradeboard.TradeboardDTO;
import com.fp.shuttlecock.user.UserDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class MypageController {

	@Autowired
	MypageServiceImpl service;

	@Autowired
	FileUploadAPI fileupload;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	// 마이페이지 폼
	@GetMapping("/mypage")
	public String getMypage(HttpSession session, Model model) {
		String userId = session.getAttribute("userId").toString();

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
			String path = "C:\\shuttlecock";
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
	@PostMapping("/deleteUser")
	public String deleteUser(HttpSession session, @RequestParam("pw") String pw, Model model, HttpServletRequest request) {
		String userId = session.getAttribute("userId").toString();
		UserDTO user = service.getMypage(userId);
		
		boolean result = false;
		System.out.println(user);
		System.out.println("입력한 비밀번호 : "+pw);
		System.out.println(user.getPw());
		
		if(user.isKakaoYN() == false) {
			if (passwordEncoder.matches(pw, user.getPw())) {
				System.out.println("비밀번호 일치");
				result = service.deleteUser(userId);
				session.invalidate();
				
			} else {
				System.out.println("비밀번호 불일치");
				model.addAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
				return "mypage/updateUser";
			}
			
		}else {
			System.out.println("카카오 회원탈퇴");
			result = service.deleteUser(userId);
			session.invalidate();
		}

		return "redirect:/login";
	}

	// 나의 활동내역
	@GetMapping("/record")
	public String getRecord(HttpSession session, Model model, PageRequestDTO pageRequest) {
		String userId = session.getAttribute("userId").toString();
		
		UserDTO user = service.getMypage(userId);

		model.addAttribute("user", user);

		// 게시물
		List<FreeboardDTO> freeList = service.getFreeboard(userId);
		List<TradeboardDTO> tradeList = service.getTradeboard(userId);
		List<LeagueboardDTO> leagueList = service.getLeagueboard(userId);
		List<RecruitboardDTO> recruitList = service.getRecruitBoard(userId);

		model.addAttribute("league", leagueList);
		model.addAttribute("free", freeList);
		model.addAttribute("trade", tradeList);
		model.addAttribute("recruit", recruitList);

		// 댓글
		List<CommentsDTO> commentList = service.getComment(userId);

		model.addAttribute("comment", commentList);

		// 좋아요
		List<FreeboardDTO> freeLikeList = service.getFreeboardLike(userId);
		List<TradeboardDTO> tradeLikeList = service.getTradeboardLike(userId);
		List<RecruitboardDTO> recruitLikeList = service.getRecruitBoardLike(userId);
		
		model.addAttribute("tradeLikeList", tradeLikeList);
		model.addAttribute("freeLikeList", freeLikeList);
		model.addAttribute("recruitLike", recruitLikeList);
		
		//페이지 네이션
//		
//		
//		int totalCount = service.getTotalCount(pageRequest);
//		System.out.println(totalCount);
//		PageResponseDTO pageResponse = new PageResponseDTO().builder()
//				.total(totalCount)
//				.pageAmount(pageRequest.getAmount())
//				.pageRequest(pageRequest)
//				.build();
//		
//		model.addAttribute("pageInfo", pageResponse);
//		System.out.println(pageResponse);
		return "mypage/record";
	}

}

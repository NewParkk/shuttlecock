package com.fp.shuttlecock.recruitboard;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fp.shuttlecock.attachmentfile.FileRequest;
import com.fp.shuttlecock.attachmentfile.FileService;
import com.fp.shuttlecock.attachmentfile.NaverObjectStorage;
import com.fp.shuttlecock.comments.CommentsDTO;
import com.fp.shuttlecock.comments.CommentsService;
import com.fp.shuttlecock.comments.CommentsServiceImpl;
import com.fp.shuttlecock.leagueboard.LeagueboardDTO;
import com.fp.shuttlecock.likes.LikesDTO;
import com.fp.shuttlecock.likes.LikesServiceImpl;
import com.fp.shuttlecock.tradeboard.PageRequestDTO;
import com.fp.shuttlecock.tradeboard.PageResponseDTO;
import com.fp.shuttlecock.tradeboard.TradeboardServiceImpl;
import com.fp.shuttlecock.user.UserService;
import com.fp.shuttlecock.user.UserServiceImpl;
import com.fp.shuttlecock.util.LikesVO;

import jakarta.servlet.http.HttpSession;

@Controller
public class RecruitboardController {

	@Autowired
	private RecruitboardServiceImpl boardService;
	
	@Autowired
	private TradeboardServiceImpl badgeService;
	
	@Autowired
	UserServiceImpl userService;

	@Autowired
	private CommentsServiceImpl commentService;

	@Autowired
	private NaverObjectStorage naverfile;
	
	@Autowired
	private LikesServiceImpl likeService;

	@GetMapping("/Recruitboard/{recruitboardId}")
	public String getBoardByBoardId(@PathVariable int recruitboardId, Model model, HttpSession session) {
		String view = "error";
		RecruitboardDTO recruitboard = null;
		try {
			recruitboard = boardService.getTradePostByTradeboardId(recruitboardId);
			int badgeId = userService.getUserByUserId(recruitboard.getUserId()).getBadgeId(); 
			String badgeName = badgeService.getBadgeNameById(badgeId);
			if (recruitboard != null) {
				boolean isLiked = likeService.checkLikesList(new LikesDTO(String.valueOf(session.getAttribute("userId")), recruitboardId, 4));
				List<CommentsDTO> commentList = commentService.getCommentList(String.valueOf(session.getAttribute("userId")), recruitboardId, 4);
				boardService.increaseHit(recruitboardId);

				model.addAttribute("recruitboard", recruitboard);
				model.addAttribute("commentList", commentList);
				model.addAttribute("badgeName", badgeName);

				model.addAttribute("isLiked", isLiked); // 좋아요 상태 표시
				view = "Recruitboard/RecruitDetail";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return view;
	}

	// paging
	@GetMapping("/Recruitboard")
	public String getPagenatedSearch(PageRequestDTO pageRequest, Model model, HttpSession session) {
		if (session.getAttribute("userId") != null) {
			pageRequest.setUserId(String.valueOf(session.getAttribute("userId")));
		}
		pageRequest.setAmount(10);
		System.out.println(pageRequest);
		List<RecruitboardDTO> recruitboardList = boardService.getPagenatedSearch(pageRequest);
		int totalCount = boardService.getTotalCount(pageRequest);
		PageResponseDTO pageResponse = new PageResponseDTO().builder().total(totalCount)
				.pageAmount(pageRequest.getAmount()).pageRequest(pageRequest).build();
		model.addAttribute("recruitboardList", recruitboardList);
		model.addAttribute("pageInfo", pageResponse);
		return "Recruitboard/Recruitboard";

	}

	@GetMapping("/Recruitboard/insert")
	public String insertLeaguePostForm() {
		return "/Recruitboard/RecruitRegister";
	}

	@PostMapping("/Recruitboard/insert")
	public String insertBoard(RecruitboardDTO recruitboard, MultipartFile file) {
		String view = "error";
		boolean boardResult = false;
		try {
			if (!file.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
				recruitboard.setImageName(fileName);
				naverfile.ncpFileupload(file, fileName, 4);
			} else {
				System.out.println("파일 삽입 당시 이미지 안넣음");
				recruitboard.setImageName("noImage");
			}
			boardResult = boardService.insertBoard(recruitboard);
			if (boardResult) {
				boardService.increaseWriteCount(recruitboard.getUserId());
				view = "redirect:/Recruitboard";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return view;
	}

	@GetMapping("/Recruitboard/update/{recruitboardId}")
	public String updateBoardForm(@PathVariable("recruitboardId") int recruitboardId, Model model) {
		RecruitboardDTO recruitboard = boardService.getTradePostByTradeboardId(recruitboardId);
		model.addAttribute("recruitboard", recruitboard);
		return "/Recruitboard/RecruitUpdate";
	}

	@PostMapping("/Recruitboard/update")
	public String updateBoard(RecruitboardDTO recruitboard, MultipartFile file, HttpSession session) {
		System.out.println(file);
		boolean result = false;
		if (String.valueOf(session.getAttribute("userId")) != null
				&& recruitboard.getUserId().equals(String.valueOf(session.getAttribute("userId")))) {
			if (!file.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
				recruitboard.setImageName(fileName);
				result = boardService.updateTradePost(recruitboard);
				naverfile.ncpFileupload(file, fileName, 4);
			} else {
				System.out.println("이미지 데이터 : " + recruitboard.getImageName());
				if(recruitboard.getImageName() == null || recruitboard.getImageName().equals("")) {
					recruitboard.setImageName("noImage");
				}
				result = boardService.updateTradePost(recruitboard);
			}
			if (result) {
				return "redirect:/Recruitboard/" + recruitboard.getRecruitboardId();
			} else {
				return "error";
			}
		}
		return "redirect:/login";
	}

	@DeleteMapping(value = "/Recruitboard/{recruitboardId}")
	public ResponseEntity<String> deleteTradePost(@PathVariable int recruitboardId, HttpSession session) {
		System.out.println("삭제 메소드 실행");
		boolean result = false;
		RecruitboardDTO recruitboard = boardService.getTradePostByTradeboardId(recruitboardId);
		if (String.valueOf(session.getAttribute("userId")) != null
				&& (session.getAttribute("isAdmin") != null && ((boolean) session.getAttribute("isAdmin")
						|| recruitboard.getUserId().equals(String.valueOf(session.getAttribute("userId")))))) {
			result = boardService.updateDeletedTradePost(recruitboardId);
			if (result) {
				return ResponseEntity.ok("글 삭제 성공");

			}
			return ResponseEntity.status(500).body("글 삭제 실패");
		} else {
			return ResponseEntity.status(403).body("삭제 권한 없음");
		}
	}

	/*
	 * // 매일 자정마다 실행
	 * 
	 * @Scheduled(cron = "0 0/1 * 1/1 * ? *") public void deleteExpiredBoards() { //
	 * 현재 LocalDateTime threeDaysAgo = LocalDateTime.now().minusDays(3);
	 * 
	 * // 3일 전 게시글을 조회하여 삭제 List<Integer> completedBoardsId =
	 * boardService.findCompletedBoards(threeDaysAgo); for (Integer tradeboardId :
	 * completedBoardsId) { boardService.updateDeletedTradePost(tradeboardId); } }
	 */
}
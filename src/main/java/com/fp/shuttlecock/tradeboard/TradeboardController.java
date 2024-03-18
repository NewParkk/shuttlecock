package com.fp.shuttlecock.tradeboard;

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
import com.fp.shuttlecock.user.UserService;
import com.fp.shuttlecock.user.UserServiceImpl;

import jakarta.servlet.http.HttpSession;

@Controller
public class TradeboardController {

	@Autowired
	private TradeboardServiceImpl boardService;

	@Autowired
	private CommentsServiceImpl commentService;

	@Autowired
	private NaverObjectStorage naverfile;

	@GetMapping("/Tradeboard/{tradeboardId}")
	public String getBoardByBoardId(@PathVariable int tradeboardId, Model model, PageRequestDTO pageRequest) {
		String view = "error";
		TradeboardDTO tradeboard = null;
		try {
			tradeboard = boardService.getTradePostByTradeboardId(tradeboardId);
			model.addAttribute("pageInfo", pageRequest);
			if (tradeboard != null) {
				List<CommentsDTO> commentList = commentService.getCommentList(tradeboardId, 3);
				// FileRequest file = fileService.getBoardFileByTradeboardId(tradeboardId);
				boardService.increaseHit(tradeboardId);

				// model.addAttribute("file", file);
				model.addAttribute("tradeboard", tradeboard);
				model.addAttribute("commentList", commentList);
				System.out.println(commentList);
				view = "Tradeboard/TradeDetail";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return view;
	}

	// paging
	@GetMapping("/Tradeboard")
	public String getPagenatedSearch(PageRequestDTO pageRequest, Model model, HttpSession session) {
		if (session.getAttribute("userId") != null) {
			pageRequest.setUserId(String.valueOf(session.getAttribute("userId")));
		}
		pageRequest.setAmount(6);
		System.out.println(pageRequest);
		List<TradeboardDTO> tradeboardList = boardService.getPagenatedSearch(pageRequest);
		int totalCount = boardService.getTotalCount(pageRequest);
		PageResponseDTO pageResponse = new PageResponseDTO().builder().total(totalCount)
				.pageAmount(pageRequest.getAmount()).pageRequest(pageRequest).build();
		model.addAttribute("tradeboardList", tradeboardList);
		model.addAttribute("pageInfo", pageResponse);
		return "Tradeboard/Tradeboard";

	}

	@GetMapping("/Tradeboard/insert")
	public String insertLeaguePostForm() {
		return "/Tradeboard/TradeRegister";
	}

	@PostMapping("/Tradeboard/insert")
	public String insertBoard(TradeboardDTO tradeboard, MultipartFile file) {
		String view = "error";
		boolean boardResult = false;
		try {
			if (!file.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
				tradeboard.setImageName(fileName);
				naverfile.ncpFileupload(file, fileName, 3);
			} else {
				System.out.println("파일 삽입 당시 이미지 안넣음");
				tradeboard.setImageName("noImage");
			}
			boardResult = boardService.insertBoard(tradeboard);
			if (boardResult) {
				boardService.increaseWriteCount(tradeboard.getUserId());
				view = "redirect:/Tradeboard";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return view;
	}

	@GetMapping("/Tradeboard/update/{tradeboardId}")
	public String updateBoardForm(@PathVariable("tradeboardId") int tradeboardId, Model model) {
//		int tradeboardInt = Integer.parseInt(tradeboardId);
		TradeboardDTO tradeboard = boardService.getTradePostByTradeboardId(tradeboardId);
		// FileRequest file = fileService.getBoardFileByBoardId(tradeboardId);

		model.addAttribute("tradeboard", tradeboard);
		// model.addAttribute("file", file);
		return "/Tradeboard/TradeUpdate";
	}

	@PostMapping("/Tradeboard/update")
	public String updateBoard(TradeboardDTO tradeboard, MultipartFile file, HttpSession session) {
		System.out.println(file);
		boolean result = false;
		if (String.valueOf(session.getAttribute("userId")) != null
				&& tradeboard.getUserId().equals(String.valueOf(session.getAttribute("userId")))) {
			if (!file.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
				tradeboard.setImageName(fileName);
				result = boardService.updateTradePost(tradeboard);
				naverfile.ncpFileupload(file, fileName, 3);
			} else {
				if(tradeboard.getImageName() == null || tradeboard.getImageName().equals("")) {
					tradeboard.setImageName("noImage");
				}
				result = boardService.updateTradePost(tradeboard);
			}
			if (result) {
				return "redirect:/Tradeboard/" + tradeboard.getTradeboardId();
			} else {
				return "error";
			}
		}
		return "redirect:/login";
	}

	@DeleteMapping(value = "/Tradeboard/{tradeboardId}")
	public ResponseEntity<String> deleteTradePost(@PathVariable int tradeboardId, HttpSession session) {
		System.out.println("삭제 메소드 실행");
		boolean result = false;
		TradeboardDTO tradeboard = boardService.getTradePostByTradeboardId(tradeboardId);
		if (String.valueOf(session.getAttribute("userId")) != null
				&& (session.getAttribute("isAdmin") != null && ((boolean) session.getAttribute("isAdmin")
						|| tradeboard.getUserId().equals(String.valueOf(session.getAttribute("userId")))))) {
			result = boardService.updateDeletedTradePost(tradeboardId);
			if (result) {
				return ResponseEntity.ok("글 삭제 성공");

			}
			return ResponseEntity.status(500).body("글 삭제 실패");
		} else {
			return ResponseEntity.status(403).body("삭제 권한 없음");
		}
	}

}
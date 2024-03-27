package com.fp.shuttlecock.tradeboard;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.fp.shuttlecock.attachmentfile.NaverObjectStorage;
import com.fp.shuttlecock.comments.CommentsDTO;
import com.fp.shuttlecock.comments.CommentsServiceImpl;
import com.fp.shuttlecock.likes.LikesDTO;
import com.fp.shuttlecock.likes.LikesServiceImpl;
import com.fp.shuttlecock.user.UserServiceImpl;

import jakarta.servlet.http.HttpSession;

@Controller
public class TradeboardController {

	@Autowired
	private TradeboardServiceImpl boardService;

	@Autowired
	private CommentsServiceImpl commentService;
	
	@Autowired
	UserServiceImpl userService;

	@Autowired
	private NaverObjectStorage naverfile;
	
	@Autowired
	private LikesServiceImpl likeService;

	@GetMapping("/Tradeboard/{tradeboardId}")
	public String getBoardByBoardId(@PathVariable int tradeboardId, Model model, HttpSession session) {
		String view = "error";
		TradeboardDTO tradeboard = null;
		try {
			tradeboard = boardService.getTradePostByTradeboardId(tradeboardId);
			int badgeId = userService.getUserByUserId(tradeboard.getUserId()).getBadgeId(); 
			String badgeName = boardService.getBadgeNameById(badgeId);
			if (tradeboard != null) {
				boolean isLiked = likeService.checkLikesList(new LikesDTO(String.valueOf(session.getAttribute("userId")), tradeboardId, 3));
				List<CommentsDTO> commentList = commentService.getCommentList(String.valueOf(session.getAttribute("userId")), tradeboardId, 3);
				boardService.increaseHit(tradeboardId);
				List<Integer> regionList = boardService.getRegionList(tradeboardId);
				model.addAttribute("tradeboard", tradeboard);
				model.addAttribute("commentList", commentList);
				model.addAttribute("badgeName", badgeName);
				model.addAttribute("regionList", regionList);
				System.out.println(commentList);
				model.addAttribute("isLiked", isLiked); // 좋아요 상태 표시
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
		//pageRequest.setAmount(10);
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
				int tradeboardId = boardService.getTradeboardId();
				if(tradeboard.getRegions() == null) {
					List<Integer> list = new ArrayList<>();
					list.add(0);
					tradeboard.setRegions(list);
				}
				boardService.insertRegion(tradeboardId, tradeboard.getRegions());
				boardService.increaseWriteCount(tradeboard.getUserId());
				view = "redirect:/Tradeboard";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return view;
	}

	@GetMapping("/Tradeboard/update")
	public String updateBoardForm(@RequestParam("tradeboardId") int tradeboardId, @RequestParam("regionList")List<Integer> regionList, Model model) {
		TradeboardDTO tradeboard = boardService.getTradePostByTradeboardId(tradeboardId);
		System.out.println(regionList);
		model.addAttribute("tradeboard", tradeboard);
		model.addAttribute("regionList", regionList);
		return "/Tradeboard/TradeUpdate";
	}

	@PostMapping("/Tradeboard/update")
	public String updateBoard(TradeboardDTO tradeboard, MultipartFile file, HttpSession session) {
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
				boardService.deleteTraderegion(tradeboard.getTradeboardId());
				boardService.insertRegion(tradeboard.getTradeboardId(), tradeboard.getRegions());
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
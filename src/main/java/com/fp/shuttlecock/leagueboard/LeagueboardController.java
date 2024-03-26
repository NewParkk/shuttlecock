package com.fp.shuttlecock.leagueboard;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fp.shuttlecock.recruitboard.RecruitboardServiceImpl;
import com.fp.shuttlecock.tradeboard.TradeboardServiceImpl;
import com.fp.shuttlecock.user.UserServiceImpl;

import jakarta.servlet.http.HttpSession;

@Controller
public class LeagueboardController {
	@Autowired
	LeagueboardServiceImpl leagueservice;
	@Autowired
	UserServiceImpl userService;
	@Autowired
	RecruitboardServiceImpl boardService;
	@Autowired
	private TradeboardServiceImpl badgeService;
	
	private StringBuilder globalWinner = new StringBuilder();
	private StringBuilder globalLoser = new StringBuilder();
	private List<String> globalWinnerList = new ArrayList<>();
	private List<String> globalLoserList = new ArrayList<>();

	@GetMapping("/LeagueBoard")
	public String getLeaguePostByTitleOrUserId(Model model,
			PageRequestDTO pageRequest, HttpSession session) {
		List<LeagueboardDTO> leagueboardList = new ArrayList<LeagueboardDTO>();
		if(session.getAttribute("userId") != null) {
			pageRequest.setUserId(String.valueOf(session.getAttribute("userId")));
		}
		leagueboardList = leagueservice.getSearchedLeaguePost(pageRequest);
		int totalPosts = leagueservice.countSearchedLeaguePosts(pageRequest);
		PageResponseDTO pageResponse = new PageResponseDTO().builder().total(totalPosts)
				.pageAmount(pageRequest.getAmount()).pageRequest(pageRequest).build();

		model.addAttribute("leagueboardList", leagueboardList);
		model.addAttribute("pageInfo", pageResponse);
		return "/LeagueBoard/LeagueBoard";
	}

	@GetMapping("/LeagueBoard/{leagueboardId}")
	public String getLeaguePost(@PathVariable int leagueboardId, Model model) {
		LeagueboardDTO leagueboard = leagueservice.getLeaguePostById(leagueboardId);
		int badgeId = userService.getUserByUserId(leagueboard.getUserId()).getBadgeId(); 
		String badgeName = badgeService.getBadgeNameById(badgeId);
		model.addAttribute("leagueboard", leagueboard);
		model.addAttribute("badgeName", badgeName);
		return "/LeagueBoard/LeagueDetail";
	}

	@GetMapping("/LeagueBoard/insert")
	public String insertLeaguePostForm(@RequestParam("userList")List<String> userList, 
			@RequestParam("recruitType") int recruitType, @RequestParam("recruitboardId") int recruitboardId,
			Model model, HttpSession session) {
		userList.add(String.valueOf(session.getAttribute("userId")));
		System.out.println(recruitType);
		model.addAttribute("userList", userList);
		model.addAttribute("recruitType", recruitType);
		model.addAttribute("recruitboardId", recruitboardId);
		return "/LeagueBoard/LeagueRegister";
	}

	@PostMapping("/LeagueBoard/insert")
	public String insertLeaguePost(LeagueboardDTO leagueboardDTO, HttpSession session) {
		System.out.println(leagueboardDTO);
		leagueboardDTO.setUserId(String.valueOf(session.getAttribute("userId")));
		if(leagueboardDTO.getWinner() != null && leagueboardDTO.getLoser() != null) {
			leagueservice.insertLeaguePost(leagueboardDTO);
			leagueservice.increaseWinnerRanking(leagueboardDTO.getWinner());
			leagueservice.increaseLoserRanking(leagueboardDTO.getLoser());
		} else if (leagueboardDTO.getWinnerList() != null && leagueboardDTO.getLoserList() != null) {
			String winners = leagueboardDTO.getWinnerList().toString().replace("[", "").replace("]", "");
			String losers = leagueboardDTO.getLoserList().toString().replace("[", "").replace("]", "");
			System.out.println(winners);
			leagueboardDTO.setWinners(winners);
			leagueboardDTO.setLosers(losers);
			leagueservice.insertLeaguePost(leagueboardDTO);
			for(String winner : leagueboardDTO.getWinnerList()) {
				leagueservice.increaseWinnerRanking(winner);
			}
			for(String loser : leagueboardDTO.getLoserList()) {
				leagueservice.increaseLoserRanking(loser);
			}
		}
		leagueservice.increaseWriteCount(leagueboardDTO.getUserId());
		System.out.println(leagueboardDTO.getRecruitboardId());
		boardService.setPostCompleted(leagueboardDTO.getRecruitboardId());
		return "redirect:/LeagueBoard";
	}

	@GetMapping("/LeagueBoard/update/{leagueboardId}")
	public String updateLeaguePostForm(@PathVariable int leagueboardId, Model model) throws Exception {
		LeagueboardDTO leagueboard = leagueservice.getLeaguePostById(leagueboardId);
		globalWinner.setLength(0);
		globalWinnerList.clear();
		globalLoser.setLength(0);
		globalLoserList.clear();
		if(leagueboard.getWinner() != null && leagueboard.getLoser() != null) {
			globalWinner.append(leagueboard.getWinner());
			globalLoser.append(leagueboard.getLoser());
			List<String> userList = new ArrayList<>();
			userList.add(leagueboard.getWinner());
			userList.add(leagueboard.getLoser());
			model.addAttribute("userList", userList);
			System.out.println("유저리스트" + userList);
		} else if(leagueboard.getWinners() != null && leagueboard.getLosers() != null) {
			globalWinnerList.add(leagueboard.getWinners().split(",")[0].replace(" ", ""));
			globalWinnerList.add(leagueboard.getWinners().split(",")[1].replace(" ", ""));
			globalLoserList.add(leagueboard.getLosers().split(",")[0].replace(" ", ""));
			globalLoserList.add(leagueboard.getLosers().split(",")[1].replace(" ", ""));
			List<String> userList = new ArrayList<>();
			userList.add(leagueboard.getWinners().split(",")[0].replace(" ", ""));
			userList.add(leagueboard.getWinners().split(",")[1].replace(" ", ""));
			userList.add(leagueboard.getLosers().split(",")[0].replace(" ", ""));
			userList.add(leagueboard.getLosers().split(",")[1].replace(" ", ""));
			model.addAttribute("userList", userList);
			System.out.println("유저리스트" + userList);
		}
		model.addAttribute("leagueboard", leagueboard);
		return "/LeagueBoard/LeagueUpdate";
	}

	@PostMapping("/LeagueBoard/update")
	public String updateLeaguePost(LeagueboardDTO leagueboardDTO, HttpSession session) {
		boolean result = false;
		if (String.valueOf(session.getAttribute("userId")) != null &&
				leagueboardDTO.getUserId().equals(String.valueOf(session.getAttribute("userId")))) {
			if(leagueboardDTO.getWinner() != null && leagueboardDTO.getLoser() != null) {
				if(!globalWinner.equals(leagueboardDTO.getWinner())) {
					leagueservice.decreaseLoserRanking(leagueboardDTO.getWinner());
					globalWinner.setLength(0);
				}
				if(!globalLoser.equals(leagueboardDTO.getLoser())) {
					leagueservice.decreaseWinnerRanking(leagueboardDTO.getLoser());
					globalLoser.setLength(0);
				} 
			}
			else if(leagueboardDTO.getWinnerList() != null && leagueboardDTO.getLoserList() != null){
				Set<String> winnerSet = new HashSet<>(leagueboardDTO.getWinnerList());
				Set<String> loserSet = new HashSet<>(leagueboardDTO.getLoserList());
				Set<String> winnerDiff = new HashSet<>(winnerSet);
				Set<String> loserDiff = new HashSet<>(loserSet);
				winnerDiff.removeAll(globalWinnerList);
				loserDiff.removeAll(globalLoserList);
				globalWinnerList.clear();
				globalLoserList.clear();
				for(String winner : winnerDiff) {
					leagueservice.decreaseLoserRanking(winner);
				}
				for(String loser : loserDiff) {
					leagueservice.decreaseWinnerRanking(loser);
				}
				leagueboardDTO.setWinners(leagueboardDTO.getWinnerList().toString().replace("[", "").replace("]", ""));
				leagueboardDTO.setLosers(leagueboardDTO.getLoserList().toString().replace("[", "").replace("]", ""));
			}
			result = leagueservice.updateLeaguePost(leagueboardDTO);
			if (result) {
				return "redirect:/LeagueBoard/" + leagueboardDTO.getLeagueboardId();
			} else {
				return "error";
			}
		}
		return "/login";
	}

	@DeleteMapping(value = "/LeagueBoard/{leagueboardId}")
	public ResponseEntity<String> deleteLeaguePost(@PathVariable("leagueboardId") int leagueboardId,
			HttpSession session) {
		boolean result = false;
		LeagueboardDTO leagueboardDTO = leagueservice.getLeaguePostById(leagueboardId);
		if (String.valueOf(session.getAttribute("userId")) != null && (boolean)session.getAttribute("isAdmin") == true
				|| leagueboardDTO.getUserId().equals(String.valueOf(session.getAttribute("userId")))) {
			result = leagueservice.updateDeletedLeaguePost(leagueboardId);
			if (result) {
				return ResponseEntity.ok("글 삭제 성공");

			}
			return ResponseEntity.status(500).body("글 삭제 실패");
		} else {
			return ResponseEntity.status(403).body("삭제 권한 없음");
		}
	}
	
	
	@GetMapping("/removeGlobal")
	@ResponseBody
	public String removeGlobal() {
		globalWinner.setLength(0);
		globalWinnerList.clear();
		globalLoser.setLength(0);
		globalLoserList.clear();
		return "성공";
	}
	
}

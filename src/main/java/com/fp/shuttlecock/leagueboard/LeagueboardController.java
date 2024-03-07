package com.fp.shuttlecock.leagueboard;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@Controller
public class LeagueboardController {
	@Autowired
	LeagueboardServiceImpl leagueservice;

	@GetMapping("/LeagueBoard")
	public String getAllLeaguePost(Model model, PageRequestDTO pageRequest) {
		System.out.println(pageRequest);
		List<LeagueboardDTO> leagueboardList = leagueservice.getAllLeaguePostByPage(pageRequest);
		int totalPosts = leagueservice.countLeaguePosts();
		PageResponseDTO pageResponse = new PageResponseDTO().builder()
				.total(totalPosts)
				.pageAmount(pageRequest.getAmount())
				.pageRequest(pageRequest)
				.build();

		model.addAttribute("leagueboardList", leagueboardList);
		model.addAttribute("pageInfo", pageResponse);
		return "/LeagueBoard/LeagueBoard";
	}
	
	@GetMapping("/LeagueBoard/search")
	public String getLeaguePostByTitleOrUserId(@RequestParam String searchKeyword, 
			String dropdown, Model model, PageRequestDTO pageRequest) {
		System.out.println(pageRequest);
		List<LeagueboardDTO> leagueboardList = new ArrayList<LeagueboardDTO>();
		pageRequest.setSearchKeyword(searchKeyword);
		pageRequest.setCategory(dropdown);
		System.out.println(pageRequest.getCategory());
		leagueboardList = leagueservice.getSearchedLeaguePost(pageRequest);
		int totalPosts = leagueservice.countSearchedLeaguePosts(pageRequest);
		PageResponseDTO pageResponse = new PageResponseDTO().builder()
				.total(totalPosts)
				.pageAmount(pageRequest.getAmount())
				.pageRequest(pageRequest)
				.build();
		
		model.addAttribute("leagueboardList", leagueboardList);
		model.addAttribute("pageInfo", pageResponse);
		return "/LeagueBoard/LeagueBoard";
	}
	
	@GetMapping("/LeagueBoard/{leagueboardId}")
	public String getLeaguePost(@PathVariable int leagueboardId, Model model) {
		LeagueboardDTO leagueboard = leagueservice.getLeaguePostById(leagueboardId);
		model.addAttribute("leagueboard", leagueboard);
		return "/LeagueBoard/LeagueDetail";
	}
	
	@GetMapping("/LeagueBoard/insert")
	public String insertLeaguePostForm() {
		return "/LeagueBoard/LeagueRegister";
	}
	
	@PostMapping("/LeagueBoard/insert")
	public String insertLeaguePost(LeagueboardDTO leagueboardDTO) {
		String user = "user1";
		leagueboardDTO.setUser_userId(user);
		leagueservice.insertLeaguePost(leagueboardDTO);
		leagueservice.increaseWinnerPoint(leagueboardDTO.getWinner());
		leagueservice.increaseLoserPoint(leagueboardDTO.getLoser());
		return "redirect:/LeagueBoard";
	}
	
	@GetMapping("/LeagueBoard/update/{leagueboardId}")
	public String updateLeaguePostForm(@PathVariable int leagueboardId, Model model) throws Exception {
		LeagueboardDTO leagueboard = leagueservice.getLeaguePostById(leagueboardId);
		model.addAttribute("leagueboard", leagueboard);
		return "/LeagueBoard/LeagueUpdate";
	}
	
	@PostMapping("/LeagueBoard/update")
	public String updateLeaguePost(LeagueboardDTO leagueboardDTO) {
		System.out.println("리그보드 업데이트");
		//session객체 받아오기, user를 session에서 받아온 userId로 설정하기
		String user = "user1";
		leagueboardDTO.setUser_userId(user);
		boolean result = false;
		//UserDTO user = (UserDTO) session.getAttribute("user");
		//if (user != null && (user.getuserId() == 0 || boardService.isAuthor(newBoard.getFileNo(), user.getId()))) {
				result = leagueservice.updateLeaguePost(leagueboardDTO);
				if (result) {
					return "redirect:/LeagueBoard/" + leagueboardDTO.getLeagueboardId();
		}
		System.out.println(leagueboardDTO.getLeagueboardId());
		return "error";
	//}
	}
	
	@DeleteMapping(value = "/LeagueBoard/{leagueboardId}")
	public ResponseEntity<String> deleteLeaguePost(@PathVariable("leagueboardId") int leagueboardId, HttpSession session) {
		boolean result = false;
		//UserDTO user = (UserDTO) session.getAttribute("user");
		//if (user != null && (user.getAuthor() == 0 || boardService.isAuthor(fileNo, user.getId()))) {
				result = leagueservice.deleteLeaguePost(leagueboardId);
				if(result) {
					return ResponseEntity.ok("글 삭제 성공");
				
				}
				return ResponseEntity.status(500).body("글 삭제 실패");
//			}
//		} else {
//			return ResponseEntity.status(403).body("삭제 권한 없음"); // 권한 없을 경우 403 에러 반환
//		}
	}
	
}

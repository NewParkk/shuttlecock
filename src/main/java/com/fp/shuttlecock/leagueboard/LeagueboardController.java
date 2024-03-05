package com.fp.shuttlecock.leagueboard;

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
	LeagueboardService leagueservice;

	@GetMapping("/LeagueBoard")
	public void getAllLeaguePost(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		List<LeagueboardDTO> leagueboardList = leagueservice.getAllLeaguePostByPage(page, 20);
		int totalPosts = leagueservice.countLeaguePosts();
		int totalPages = (int) Math.ceil((double) totalPosts / 20);

		model.addAttribute("leagueboardList", leagueboardList);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
	}
	
	@GetMapping("/posts/search")
	public String getLeaguePostByTitle(@RequestParam String query, @RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		List<LeagueboardDTO> searchList = leagueservice.getLeaguePostByTitle(page, 20, query);
		int totalPosts = leagueservice.countSearchedLeaguePosts(query);
		int totalPages = (int) Math.ceil((double) totalPosts / 20);

		model.addAttribute("searchList", searchList);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);

		return "LeagueBoard";
	}
	
	@GetMapping("/LeagueBoard/{leagueboardId}")
	public String getLeaguePost(@PathVariable int leagueboardId, Model model) {
		LeagueboardDTO leagueboard = leagueservice.getLeaguePostById(leagueboardId);
		model.addAttribute("leagueboard", leagueboard);
		return "LeagueBoardDetail";
	}
	
	@PostMapping("/LeagueBoard/insert")
	public String insertLeaguePost(LeagueboardDTO leagueboardDTO) {
		leagueservice.insertLeaguePost(leagueboardDTO);
		return "redirect:/LeagueBoard";
	}
	
	@PostMapping(value = "/LeagueBoard/update")
	public String updateLeaguePost(LeagueboardDTO leagueboardDTO, HttpSession session) {
		boolean result = false;
		//UserDTO user = (UserDTO) session.getAttribute("user");
		//if (user != null && (user.getuserId() == 0 || boardService.isAuthor(newBoard.getFileNo(), user.getId()))) {
				result = leagueservice.updateLeaguePost(leagueboardDTO);
				if (result) {
					return "redirect:/board/" + leagueboardDTO.getLeagueboardId();
		}
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
					return ResponseEntity.ok("보드와 댓글 삭제 성공");
				
				}
				return ResponseEntity.status(500).body("보드와 댓글 삭제 실패");
//			}
//		} else {
//			return ResponseEntity.status(403).body("삭제 권한 없음"); // 권한 없을 경우 403 에러 반환
//		}
	}
	
}

package com.fp.shuttlecock.leagueboard;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fp.shuttlecock.user.UserDTO;

import jakarta.servlet.http.HttpSession;

@Controller
public class LeagueboardRankingController {

	@Autowired
	LeagueboardRankingServiceImpl LRS;
	
	@GetMapping("/LeagueBoardRanking")
	public String getLeagueRanking(Model model, HttpSession session) {
		
		List<UserDTO> leagueRankingList = LRS.getLeagueRanking();
		
		// 승점에 따라 내림차순으로 정렬
        Collections.sort(leagueRankingList, Comparator.comparingInt(user -> (((UserDTO) user).getWincount() - ((UserDTO) user).getLosecount())).reversed());

		
		model.addAttribute("leagueRankingList", leagueRankingList);
		
		return "/LeagueBoard/LeagueBoardRanking_new";
		
	}
	
	@GetMapping("/card")
	public String getMethodName() {
		return "/LeagueBoard/card";
	}
	
	
}

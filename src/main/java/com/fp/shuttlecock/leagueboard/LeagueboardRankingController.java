package com.fp.shuttlecock.leagueboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LeagueboardRankingController {

	@Autowired
	LeagueboardRankingServiceImpl LRS;
	
	@GetMapping("/LeagueBoardRanking")
	public void getLeagueRanking() {
		
	}
	
}

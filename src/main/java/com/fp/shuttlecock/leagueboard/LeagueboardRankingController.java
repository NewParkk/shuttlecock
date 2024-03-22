package com.fp.shuttlecock.leagueboard;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fp.shuttlecock.user.UserDTO;

import jakarta.servlet.http.HttpSession;

@Controller
public class LeagueboardRankingController {

	@Autowired
	LeagueboardRankingServiceImpl LRS;
	
	@GetMapping("/LeagueBoardRanking")
	public String getLeagueRanking(Model model, PageRequestDTO pageRequest, HttpSession session) {
		System.out.println(pageRequest);
		if(session.getAttribute("userId") != null) {
			pageRequest.setUserId(String.valueOf(session.getAttribute("userId")));
		}
		List<UserDTO> leagueRankingList = LRS.getLeagueRanking(pageRequest);
		
		
		int totalUser = LRS.countLeagueUser(pageRequest);
		PageResponseDTO pageResponse = new PageResponseDTO().builder().total(totalUser)
				.pageAmount(pageRequest.getAmount()).pageRequest(pageRequest).build();

		

		
		model.addAttribute("leagueRankingList", leagueRankingList);
		model.addAttribute("pageInfo", pageResponse);
		return "/LeagueBoard/LeagueBoardRanking_new";
		
	}
	
	

	
	@GetMapping("/LeagueBoardRanking/search")
	public String getLeagueRankingByUsername(Model model, PageRequestDTO pageRequest, HttpSession session,
	                               @RequestParam(required = false) String username) {
	    System.out.println(pageRequest);
	    if(session.getAttribute("userId") != null) {
	        pageRequest.setUserId(String.valueOf(session.getAttribute("userId")));
	    }
	    
	    List<UserDTO> leagueRankingList;
	    
	    leagueRankingList = LRS.getLeagueRankingByUsername(pageRequest);
	   
	    
	    int totalUser = LRS.countLeagueUser(pageRequest);
	    PageResponseDTO pageResponse = new PageResponseDTO().builder().total(totalUser)
	            .pageAmount(pageRequest.getAmount()).pageRequest(pageRequest).build();


	    model.addAttribute("leagueRankingList", leagueRankingList);
	    model.addAttribute("pageInfo", pageResponse);
	    return "/LeagueBoard/LeagueBoardRanking_new";
	}
	
	
	
	
}

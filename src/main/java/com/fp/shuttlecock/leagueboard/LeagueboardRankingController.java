package com.fp.shuttlecock.leagueboard;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

@Controller
public class LeagueboardRankingController {

	@Autowired
	LeagueboardRankingServiceImpl LRS;
	
	// 리그 순위
	// 페이지에 바로 들어올 시 전체 리그 순위 표시 및 분기별 리그 순위 기능 
	@GetMapping("/LeagueBoardRanking")
	public String getLeagueRanking(Model model, PageRequestDTO pageRequest,
	                                @RequestParam(required = false) String startDate,
	                                @RequestParam(required = false) String endDate,
	                                HttpSession session) {
	    if(session.getAttribute("userId") != null) {
	        pageRequest.setUserId(String.valueOf(session.getAttribute("userId")));
	    }
	    
	    pageRequest.setStartDate(startDate);
	    pageRequest.setEndDate(endDate);
	    
	    List<LeagueRankDTO> leagueRankingList = LRS.getLeagueRanking(pageRequest);

	    int totalUser = LRS.countLeagueUser(pageRequest);
	    PageResponseDTO pageResponse = new PageResponseDTO().builder().total(totalUser)
	            .pageAmount(pageRequest.getAmount()).pageRequest(pageRequest).build();

	    model.addAttribute("leagueRankingList", leagueRankingList);
	    model.addAttribute("pageInfo", pageResponse);
    
	    return "/LeagueBoard/LeagueBoardRanking";
	}

	
	

	// 리그 순위 검색기능
	@GetMapping("/LeagueBoardRanking/search")
	public String getLeagueRankingByUsername(Model model, PageRequestDTO pageRequest,
            									@RequestParam(required = false) String startDate,
            									@RequestParam(required = false) String endDate,
            									@RequestParam(required = false) String searchKeyword,
            									HttpSession session) {
	    if(session.getAttribute("userId") != null) {
	        pageRequest.setUserId(String.valueOf(session.getAttribute("userId")));
	    }
	    
	    pageRequest.setStartDate(startDate);
	    pageRequest.setEndDate(endDate);
	    pageRequest.setSearchKeyword(searchKeyword);
	    
	    List<LeagueRankDTO> leagueRankingList;
	    
	    leagueRankingList = LRS.getLeagueRankingByUsername(pageRequest);
	    	    
	    int totalUser = LRS.countLeagueUser(pageRequest);
	    PageResponseDTO pageResponse = new PageResponseDTO().builder().total(totalUser)
	            .pageAmount(pageRequest.getAmount()).pageRequest(pageRequest).build();
	    
	    model.addAttribute("leagueRankingList", leagueRankingList);
	    model.addAttribute("pageInfo", pageResponse);
	    
	    return "/LeagueBoard/LeagueBoardRanking";
	}
	
	
	
	
}

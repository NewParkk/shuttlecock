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
	// 현재 시간 기준으로 해당 분기에 자동으로 설정
	@GetMapping("/LeagueBoardRanking")
	public String getLeagueRanking(Model model, PageRequestDTO pageRequest,
	                                @RequestParam(required = false) String startDate,
	                                @RequestParam(required = false) String endDate,
	                                HttpSession session) {
	    if(session.getAttribute("userId") != null) {
	        pageRequest.setUserId(String.valueOf(session.getAttribute("userId")));
	    }
	    
	    
	    if (startDate == null & endDate == null) {
	    	 // 현재 날짜
		    LocalDate now = LocalDate.now();
		    int month = now.getMonthValue();
		    
		    LocalDate start = null;
		    LocalDate end = null;
		    
		    // 분기 설정
		    if (month >= 1 && month <= 3) {
		    	start = LocalDate.of(now.getYear(), 1, 1);
		    	end = LocalDate.of(now.getYear(), 3, 31);
		    } else if (month >= 4 && month <= 6) {
		    	start = LocalDate.of(now.getYear(), 4, 1);
		    	end = LocalDate.of(now.getYear(), 6, 30);
		    } else if (month >= 7 && month <= 9) {
		    	start = LocalDate.of(now.getYear(), 7, 1);
		    	end = LocalDate.of(now.getYear(), 9, 30);
		    } else if (month >= 10 && month <= 12) {
		    	start = LocalDate.of(now.getYear(), 10, 1);
		    	end = LocalDate.of(now.getYear(), 12, 31);
		    }
		    
		    // 문자열로 바꿈
		    startDate = start.toString();
		    endDate = end.toString();
	    }
	   
	    
	    
	    System.out.println(startDate);
	    System.out.println(endDate);
	    
	    pageRequest.setStartDate(startDate);
	    pageRequest.setEndDate(endDate);
	    
	    
	    List<LeagueRankDTO> leagueRankingList = LRS.getLeagueRanking(pageRequest);

	    int totalUser = LRS.countLeagueUser(pageRequest);
	    PageResponseDTO pageResponse = new PageResponseDTO().builder().total(totalUser)
	            .pageAmount(pageRequest.getAmount()).pageRequest(pageRequest).build();

	    model.addAttribute("leagueRankingList", leagueRankingList);
	    model.addAttribute("pageInfo", pageResponse);
	    model.addAttribute("startDate", startDate);
	    model.addAttribute("endDate", endDate);
	    
	    return "/LeagueBoard/LeagueBoardRanking";
	}

	
	

	// 리그 순위 검색기능
	@GetMapping("/LeagueBoardRanking/search")
	public String getLeagueRankingByUsername(Model model, PageRequestDTO pageRequest,
            									@RequestParam(required = false) String startDate,
            									@RequestParam(required = false) String endDate,
            									@RequestParam(required = false) String searchKeyword,
            									HttpSession session) {
	    System.out.println("search : " + startDate);
	    System.out.println("search : " + endDate);
	    System.out.println(pageRequest);
	    if(session.getAttribute("userId") != null) {
	        pageRequest.setUserId(String.valueOf(session.getAttribute("userId")));
	    }
	    
	    
	    pageRequest.setPageNum(1);
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
	    model.addAttribute("startDate", startDate);
	    model.addAttribute("endDate", endDate);
	    model.addAttribute("searchKeyword", searchKeyword);
	    return "/LeagueBoard/LeagueBoardRanking";
	}
	
	
	
	
	// 리그 순위
	// 페이지에서 버튼을 누르면 해당 분기 순위로 이동
	@GetMapping("/LeagueBoardRanking/quarter")
	public String getLeagueQuarterRanking (Model model, PageRequestDTO pageRequest,
	                                @RequestParam(required = false) String startDate,
	                                @RequestParam(required = false) String endDate,
	                                HttpSession session) {
	    if(session.getAttribute("userId") != null) {
	        pageRequest.setUserId(String.valueOf(session.getAttribute("userId")));
	    }
	    
	    System.out.println(" quarter : " +  startDate);
	    System.out.println(" quarter : " + endDate);
	    
	    pageRequest.setStartDate(startDate);
	    pageRequest.setEndDate(endDate);
	    
	    
	    List<LeagueRankDTO> leagueRankingList = LRS.getLeagueRanking(pageRequest);

	    int totalUser = LRS.countLeagueUser(pageRequest);
	    PageResponseDTO pageResponse = new PageResponseDTO().builder().total(totalUser)
	            .pageAmount(pageRequest.getAmount()).pageRequest(pageRequest).build();
	    

	    
	    model.addAttribute("leagueRankingList", leagueRankingList);
	    model.addAttribute("pageInfo", pageResponse);
	    model.addAttribute("startDate", startDate);
	    model.addAttribute("endDate", endDate);
	    return "/LeagueBoard/LeagueBoardRanking";
	}
	
	
	
	
}

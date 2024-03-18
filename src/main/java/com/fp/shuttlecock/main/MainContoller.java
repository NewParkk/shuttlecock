package com.fp.shuttlecock.main;

import java.text.ParseException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fp.shuttlecock.freeboard.FreeboardDTO;
import com.fp.shuttlecock.freeboard.FreeboardServiceImpl;
import com.fp.shuttlecock.leagueboard.LeagueboardDTO;
import com.fp.shuttlecock.leagueboard.LeagueboardServiceImpl;
import com.fp.shuttlecock.leagueboard.PageRequestDTO;
import com.fp.shuttlecock.tradeboard.TradeboardServiceImpl;

import jakarta.servlet.http.HttpSession;

@Controller
public class MainContoller {
	
	@Autowired
	MainService mainService;
	
	@Autowired
	LeagueboardServiceImpl leagueservice;
	
	@Value("${KAKAO.KEY.JS}")
	private String apiKey;
	
	@GetMapping("/main")
    public String showMainPage(Model model, HttpSession session, PageRequestDTO pagerequest) throws ParseException {
		if(session.getAttribute("userId") != null) {
			pagerequest.setUserId(String.valueOf(session.getAttribute("userId")));
		}
		pagerequest.setIsMain(1);
		List<LeagueboardDTO> leaguePosts = leagueservice.getAllLeaguePostByPage(pagerequest);
		
		List<FreeboardDTO> freePosts = mainService.get5FreePosts();
		System.out.println(apiKey);
		model.addAttribute("leaguePosts", leaguePosts);
		model.addAttribute("freePosts", freePosts);
		model.addAttribute("apiKey", apiKey);
		
        return "main"; // "main"은 실제로 /WEB-INF/views/main.jsp에 매핑됩니다.
    }
	
	
}

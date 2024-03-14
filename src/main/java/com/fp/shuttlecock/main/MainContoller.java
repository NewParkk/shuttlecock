package com.fp.shuttlecock.main;

import java.text.ParseException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fp.shuttlecock.freeboard.FreeboardDTO;
import com.fp.shuttlecock.freeboard.FreeboardServiceImpl;
import com.fp.shuttlecock.leagueboard.LeagueboardDTO;
import com.fp.shuttlecock.leagueboard.LeagueboardServiceImpl;
import com.fp.shuttlecock.tradeboard.TradeboardServiceImpl;

@Controller
public class MainContoller {
	
	@Autowired
	MainService mainService;
	
	@GetMapping("/main")
    public String showMainPage(Model model) throws ParseException {
		
		List<LeagueboardDTO> leaguePosts = mainService.get5LeaguePosts();
		
		List<FreeboardDTO> freePosts = mainService.get5FreePosts();
		
		model.addAttribute("leaguePosts", leaguePosts);
		model.addAttribute("freePosts", freePosts);
		
        return "main"; // "main"은 실제로 /WEB-INF/views/main.jsp에 매핑됩니다.
    }
	
	
}

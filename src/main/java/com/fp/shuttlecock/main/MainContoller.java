package com.fp.shuttlecock.main;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fp.shuttlecock.freeboard.FreeboardDTO;
import com.fp.shuttlecock.freeboard.FreeboardServiceImpl;
import com.fp.shuttlecock.information.CompetitionServiceImpl;
import com.fp.shuttlecock.recruitboard.RecruitboardDTO;
import com.fp.shuttlecock.recruitboard.RecruitboardServiceImpl;
import com.fp.shuttlecock.tradeboard.PageRequestDTO;
import com.fp.shuttlecock.util.PageVO;

import jakarta.servlet.http.HttpSession;


@Controller
public class MainContoller {
	
	@Autowired
	private FreeboardServiceImpl freeService;
	
	@Autowired
	private RecruitboardServiceImpl boardService;
	
	@Autowired
	private CompetitionServiceImpl competitionService;
	 
	@Value("${KAKAO.KEY.JS}")
	private String apiKey;
	
	@GetMapping("/")
	public String enter() {
		return "redirect:/main";
	}
	
	
	@GetMapping("/main")
    public String showMainPage(Model model, HttpSession session, PageRequestDTO pagerequest, PageVO vo,
    		String region) throws ParseException {
		if(session.getAttribute("userId") != null) {
			pagerequest.setUserId(String.valueOf(session.getAttribute("userId")));
		}
		pagerequest.setIsMain(1);
		List<RecruitboardDTO> leaguePosts = boardService.getPagenatedSearch(pagerequest);
		List<Map<String, Object>> events = competitionService.getCompetitionDB(region);
		List<FreeboardDTO> freePosts = freeService.get5FreePosts();
		
		model.addAttribute("leaguePosts", leaguePosts);
		model.addAttribute("freePosts", freePosts);
		model.addAttribute("apiKey", apiKey);
	    model.addAttribute("events", events);
		
        return "main";
    }
	
}

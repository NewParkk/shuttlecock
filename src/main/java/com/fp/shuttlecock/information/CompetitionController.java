package com.fp.shuttlecock.information;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CompetitionController {

	@Autowired
	CompetitionServiceImpl competitionService;
	
	@GetMapping("/getGame")
    public String getEventByDate(CompetitionDTO competitionDTO, @RequestParam(value="region",required=false) String region, Model model) {
		boolean isFirstData = competitionService.isFirstData();
		
		//초기데이터가 있는지 없는지 확인
	    if (!isFirstData) {	
	        System.out.println("competitionDB 초기 데이터가 없으므로 데이터 삽입을 수행합니다.");
	        try {
	            competitionService.crawlData(); //초기 데이터 삽입
	            System.out.println("competitionDB insert 성공");
	        } catch (Exception e) {
	            System.out.println("competitionDB insert 실패: " + e.getMessage());
	        }
	    } else {
	        System.out.println("competitionDB 초기 데이터 이미 존재합니다.");
	    }

	    //System.out.println(gamesList); //확인용
	    List<Map<String, Object>> events = new ArrayList<>();
	    events = competitionService.getCompetitionDB(region);
	    model.addAttribute("events", events);
    	 
	    return "information/competition";
	}

}

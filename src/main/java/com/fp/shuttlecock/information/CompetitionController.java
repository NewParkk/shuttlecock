package com.fp.shuttlecock.information;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CompetitionController {

	@Autowired
	CompetitionServiceImpl competitionService;
	
	
//	@GetMapping("/getGame")
//    public String getEventByDate(CompetitionDTO competitionDTO, String region, Model model) {
//		
//		//데이터 insert
//		CompetitionDTO competition = competitionService.insertGame(competitionDTO); 
//    	if (competition != null) {
//            System.out.println("competitionDB insert 성공");
//       } else {
//           System.out.println("competitionDB insert 실패");
//       }	
//
//    	 //List<CompetitionDTO> gamesList = competitionService.getEventByDate(region);
//    	 //model.addAttribute("gameList", gamesList);
// 
//	     return "information/competition";
//	}
	
	@GetMapping("/getGame")
    public String insertGame() {
        competitionService.collectData();
        return "information/competition"; // 적절한 페이지로 리다이렉트
    }

}

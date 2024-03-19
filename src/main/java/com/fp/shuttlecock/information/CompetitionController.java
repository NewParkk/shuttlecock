package com.fp.shuttlecock.information;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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

	    
	    List<CompetitionDTO> gamesList;
	    if (region != null && !region.isEmpty()) {
	    	//만약 "전국"이면
	        if (region.equals("전국")) {
	            gamesList = competitionService.getRegionEvent(region);
	        } else {
	        	//"전국"이 아니면 제외하고 출력
	            gamesList = competitionService.getEventByDate();
	            gamesList.removeIf(event -> event.getRegion().equals("전국"));
	        }
	    //null/공백이면 전부 출력
	    } else {
	        gamesList = competitionService.getEventByDate();
	    }
	    //System.out.println(gamesList); //확인용
    	 
	    
	     //캘린더에 DB에 저장된 데이터 가져오기
    	 List<Map<String, Object>> events = new ArrayList<>();
    	 for (CompetitionDTO game : gamesList) {
    		String region1 = game.getRegion();
    		String url1 = game.getUrl();
    		String eventTitle = "[" + region1 + "] " + game.getTitle(); //[지역]대회이름
    		 
		    Map<String, Object> eventData = new HashMap<>();
		    eventData.put("region", region1);
		    eventData.put("title", eventTitle);
		    eventData.put("url", url1); 
		    
		    //캘린더는 ISO 8601 형식의 문자열이나 Timestamp 등을 사용하여 날짜를 표현해야함
		    Date startDate = game.getStartDate();
		    Date endDate = game.getEndDate();
		    
		    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		    String formattedStartDate = formatter.format(startDate);
		    String formattedEndDate = formatter.format(endDate);
		    
		    eventData.put("start", formattedStartDate); //시작일
		    eventData.put("end", formattedEndDate);     //종료일
		    
		    String backgroundColor;
		    if (region1.contains("전국")) {
		    	backgroundColor = "rgba(255, 204, 0, 0.3)"; //전국인 경우
		    } else {
		    	backgroundColor = "rgba(46, 139, 87, 0.2)"; //그 외의 경우
		    }
		    eventData.put("backgroundColor", backgroundColor);
		    eventData.put("textColor", "#fff");
    		   
    	     
    	     events.add(eventData);
    	 }
         
         model.addAttribute("events", events);
 
	     return "information/competition";
	}

}

package com.fp.shuttlecock.information;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CompetitionServiceImpl implements CompetitionService {

	@Autowired
	CompetitionMapper competitionMapper;

	@Autowired
    private WebDriver webDriver;

    private static final String BASE_URL = "http://www.badmintongame.co.kr/game/game.html";

  //selenium으로 데이터 삽입
    public void crawlData() throws Exception {
    	try {
	    	//첫 페이지 데이터
	        webDriver.get(BASE_URL);
	        collectData();
	
	        //두번째 페이지 데이터
	        webDriver.get(BASE_URL);
	        clickNextMonth();
	        collectData();
	
	        //세번째 페이지 데이터
	        webDriver.get(BASE_URL);
	        clickNextMonth();
	        clickNextMonth();
	        collectData();
	    } catch (Exception e) {
	        throw new Exception("실행 중 에러 발생", e);
	    } finally {
	        webDriver.quit();
	    }
    }
    
    //스케줄러
    @Scheduled(cron = "0 0 0 * * *") //매일 자정에 실행
    public void scheduledCrawlData() {
    	try {
            crawlData();
            System.out.println("competitionDB 스케줄러에 의한 데이터 삽입 성공");
        } catch (Exception e) {
            System.out.println("competitionDB 스케줄러에 의한 데이터 삽입 실패: " + e.getMessage());
        }
    }

    //버튼 클릭
    private void clickNextMonth() {
    	WebElement nextButton = webDriver.findElement(By.xpath("//*[@id=\"calendars\"]/table/tbody/tr/td[3]/span"));
    	JavascriptExecutor executor = (JavascriptExecutor) webDriver;
    	executor.executeScript("arguments[0].click();", nextButton);
        
        try {
        	Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public void collectData() {
        //webDriver.get(BASE_URL);

        List<WebElement> linkElements = webDriver.findElements(By.cssSelector("a.fc-event:not([style*='background-color: rgb(253, 210, 214)'])"));
        Set<String> hrefs = new HashSet<>();

        for (WebElement element : linkElements) {
            String hrefValue = element.getAttribute("href");
            hrefs.add(hrefValue);
        }

        for (String href : hrefs) {
            webDriver.get(href);

            WebElement title = webDriver.findElement(By.xpath("//*[@id=\"container_title\"]/span"));
            WebElement region = webDriver.findElement(By.xpath("//*[@id=\"container\"]/div[2]/table/tbody/tr[2]/td"));
            WebElement dateElement = webDriver.findElement(By.xpath("//*[@id=\"container\"]/div[2]/table/tbody/tr[3]/td"));
            WebElement applicationDateElement = webDriver.findElement(By.xpath("//*[@id=\"container\"]/div[2]/table/tbody/tr[4]/td"));
            WebElement imageUrlElement = null;
            String url = href;
            try {
                imageUrlElement = webDriver.findElement(By.xpath("//*[@id=\"container\"]/div[2]/table/tbody/tr[1]/td[1]/a/img"));
            } catch (org.openqa.selenium.NoSuchElementException e) {
                // 이미지가 없을 경우 예외 처리
            }

            String dateText1 = dateElement.getText().trim();
            String dateText2 = applicationDateElement.getText().trim();

            LocalDate startDate = parseLocalDate(dateText1.split(" ~ ")[0]);
            LocalDate endDate = parseLocalDate(dateText1.split(" ~ ")[1]);
            LocalDate applicationStartDate = parseLocalDate(dateText2.split(" ~ ")[0]);
            LocalDate applicationEndDate = parseLocalDate(dateText2.split(" ~ ")[1]);
            
            //Date type으로 변환
            java.sql.Date startDate1 = (startDate != null) ? java.sql.Date.valueOf(startDate) : null;
            java.sql.Date endDate1 = (endDate != null) ? java.sql.Date.valueOf(endDate) : null;
            java.sql.Date applicationStartDate1 = (applicationStartDate != null) ? java.sql.Date.valueOf(applicationStartDate) : null;
            java.sql.Date applicationEndDate1 = (applicationEndDate != null) ? java.sql.Date.valueOf(applicationEndDate) : null;
            //System.out.println(startDate1); //확인용
            //System.out.println(endDate1);  //확인용

            String image = (imageUrlElement != null) ? imageUrlElement.getAttribute("src") : null;

            CompetitionDTO competition = new CompetitionDTO(0, region.getText(), title.getText(), startDate1, endDate1, image, url, applicationStartDate1, applicationEndDate1);

            if (!isCompCheck(competition)) {
                insertGame(competition);
            }
        }
    }

    private LocalDate parseLocalDate(String dateText) {
        try {
            if (dateText.equals("0000년 0월 0일")) {
                return null;
            }
            //문자열로 파싱
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 M월 d일");
            return LocalDate.parse(dateText, formatter);
        } catch (DateTimeParseException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    //캘린더에 DB에 저장된 데이터 가져오기
    public List<Map<String, Object>> getCompetitionDB(String region) {
    
   	 List<Map<String, Object>> events = new ArrayList<>();
   	 
   	 List<CompetitionDTO> gamesList;
     if (region != null && !region.isEmpty()) {
    	//만약 "전국"이면
    	 if (region.equals("전국")) {
            gamesList = getRegionEvent(region);
    	 } else {
    		 //"전국"이 아니면 제외하고 출력
    		 gamesList = getEventByDate();
    		 gamesList.removeIf(event -> event.getRegion().equals("전국"));
    	 }
    	 //null/공백이면 전부 출력
     } else {
    	 gamesList = getEventByDate();
     }
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
	  
	   	 return events;
	}
    
    
    
    //정규대회 중복체크
    public boolean isCompCheck(CompetitionDTO competition) {
    	return competitionMapper.isCompCheck(competition.getTitle());
    }
    
   //selenium으로 데이터 insert
    public void insertGame(CompetitionDTO competitionDTO) {
        competitionMapper.insertGame(competitionDTO);
    }
	
	//모든 정규대회 출력
	public List<CompetitionDTO> getEventByDate() {
		return competitionMapper.getEventByDate();
	}

	//초기데이터가 있는지 없는지  확인
	public boolean isFirstData() {
		int count = competitionMapper.isFirstData();
	    return count != 0; //0이 아니면 true, 0이면 false
	}

	//전국,지역으로 데이터 추출
	public List<CompetitionDTO> getRegionEvent(String region) {
		return competitionMapper.getRegionEvent(region);
	}

}

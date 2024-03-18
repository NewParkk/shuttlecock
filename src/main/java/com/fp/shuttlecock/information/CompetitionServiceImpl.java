package com.fp.shuttlecock.information;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CompetitionServiceImpl implements CompetitionService {

	@Autowired
	CompetitionMapper competitionMapper;

	@Autowired
    private WebDriver webDriver;

    private static final String BASE_URL = "http://www.badmintongame.co.kr/game/game.html";

    public void crawlData() {
        webDriver.get(BASE_URL);

        //첫 번째 페이지 데이터 수집
        collectData();

        webDriver.get(BASE_URL);
        //두 번째 데이터 수집
        clickNextMonth();
        collectData();

        webDriver.get(BASE_URL);
        //세 번째 데이터 수집
        clickNextMonth();
        clickNextMonth();
        collectData();

        webDriver.quit();
    }

    private void clickNextMonth() {
        WebElement nextButton = webDriver.findElement(By.xpath("//*[@id=\"calendars\"]/table/tbody/tr/td[3]/span"));
        nextButton.click();
    }

    private Date parseDate(String dateText) {
        if (dateText.equals("0000년 0월 0일")) {
            return null;
        }
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
        try {
            return dateFormat.parse(dateText);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

	
	//selenium으로 정규대회 크롤링
	public void collectData() {
		/*
		 * webDriver.get(BASE_URL); System.out.println("실행");
		 * System.out.println(webDriver.toString());
		 * System.out.println(webDriver.getCurrentUrl()); List<WebElement> linkElements
		 * = webDriver.findElements(By.
		 * cssSelector("a.fc-event:not([style*='background-color: rgb(253, 210, 214)'])"
		 * )); Set<String> hrefs = new HashSet<>();
		 * System.out.println(linkElements.size()); for (WebElement element :
		 * linkElements) { String hrefValue = element.getAttribute("href");
		 * hrefs.add(hrefValue); }
		 * 
		 * for (String href : hrefs) { webDriver.get(href); WebElement title =
		 * webDriver.findElement(By.xpath("//*[@id=\"container_title\"]/span"));
		 * WebElement region = webDriver.findElement(By.xpath(
		 * "//*[@id=\"container\"]/div[2]/table/tbody/tr[2]/td")); WebElement Date =
		 * webDriver.findElement(By.xpath(
		 * "//*[@id=\"container\"]/div[2]/table/tbody/tr[3]/td")); WebElement
		 * applicationDate = webDriver.findElement(By.xpath(
		 * "//*[@id=\"container\"]/div[2]/table/tbody/tr[4]/td")); WebElement imageUrl =
		 * null; String url = href; try { imageUrl = webDriver.findElement(By.xpath(
		 * "//*[@id=\"container\"]/div[2]/table/tbody/tr[1]/td[1]/a/img")); } catch
		 * (org.openqa.selenium.NoSuchElementException e) { //이미지가 없을 경우 예외 처리 }
		 * 
		 * //값 추출 String dateText1 = Date.getText().trim(); String dateText2 =
		 * applicationDate.getText().trim();
		 * 
		 * //날짜 형식 변환 Date startDate = parseDate(dateText1.split(" ~ ")[0]); Date
		 * endDate = parseDate(dateText2.split(" ~ ")[1]);
		 * 
		 * Date applicationStartDate = parseDate(dateText1.split(" ~ ")[0]); Date
		 * applicationEndDate = parseDate(dateText2.split(" ~ ")[1]);
		 * 
		 * String image = (imageUrl != null) ? imageUrl.getAttribute("src") : null;
		 * 
		 * System.out.println(dateText1); System.out.println(dateText2);
		 * 
		 * CompetitionDTO competition = new CompetitionDTO(0, region.getText(),
		 * title.getText(), startDate, endDate, image, url, applicationStartDate,
		 * applicationEndDate);
		 * 
		 * if (!isCompCheck(competition)) { insertGame(competition); } }
		 */
}
	
	public CompetitionDTO insertGame(CompetitionDTO competitionDTO) {
	    competitionMapper.insertGame(competitionDTO);
	    return competitionDTO;
	}
	
	public boolean isCompCheck(CompetitionDTO competition) {
		return competitionMapper.isCompCheck(competition.getTitle());
	}

	//모든 정규대회 출력
	public List<CompetitionDTO> getEventByDate(String region) {
		return competitionMapper.getEventByDate(region);
	}

}

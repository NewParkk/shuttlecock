package com.fp.shuttlecock.information;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.fp.shuttlecock.user.UserDTO;
import com.fp.shuttlecock.user.UserMapper;
import com.fp.shuttlecock.user.UserService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ArticleServiceImpl implements ArticleService{
	
	@Autowired
	ArticleMapper articleMapper;

	private static final String News_URL = "https://www.thefairnews.co.kr/news/articleList.html?sc_sub_section_code=S2N1&view_type=sm";
	
	//jsoup으로 기사 크롤링
	public void insertNews() {
	    try {
	        Document doc = Jsoup.connect(News_URL).get();

	        Elements title = doc.select("#section-list > ul > li > div > h2 > a");
	        Elements content = doc.select("#section-list > ul > li > div > p > a");
	        Elements writer = doc.select("#section-list > ul > li > div > span > em:nth-child(2)");
	        Elements image = doc.select("#section-list > ul > li > a > span > img");
	        Elements url = doc.select("#section-list > ul > li > a");
	        Elements updateDate = doc.select("#section-list > ul > li > div > span > em:nth-child(1)");

	        for (int i = 0; i < title.size(); i++) {
	        	String dateString = updateDate.get(i).text();
	            LocalDate localDate = LocalDate.parse(dateString, DateTimeFormatter.ofPattern("yyyy.MM.dd"));
	            java.sql.Date wDate = java.sql.Date.valueOf(localDate);

	            String contentText = content.get(i).text();
	            String realData = contentText.substring(contentText.lastIndexOf("=") + 1);
	            
	            ArticleDTO article = new ArticleDTO(0, title.get(i).text(), realData, writer.get(i).text(),
	                    image.get(i).attr("abs:src"), url.get(i).absUrl("href"), wDate);

	            if (!isNewsCheck(article)) {
	                articleMapper.getinsertNews(article);
	            }
	        }
	        //System.out.println("articleDB 스케줄러에 의한 데이터 삽입 성공");
	    } catch (IOException e) {
	    	//System.out.println("articleDB 스케줄러에 의한 데이터 삽입 실패: " + e.getMessage());
	    }
	}
	
	//스케줄러
    @Scheduled(cron = "0 0 0 * * *") //매일 자정에 실행
    public void scheduledNewsData() {
    	try {
    		insertNews();
            System.out.println("articleDB 스케줄러에 의한 데이터 삽입 성공");
        } catch (Exception e) {
            System.out.println("articleDB 스케줄러에 의한 데이터 삽입 실패: " + e.getMessage());
        }
    }
	
	
		//중복된 뉴스체크
		public boolean isNewsCheck(ArticleDTO article) {
			return articleMapper.isNewsCheck(article.getTitle());
		}
		
		//최신기사부터 출력하기
		public List<ArticleDTO> getNewsByDate(int page, int pageSize) {
			
	        int offset = (page - 1) * pageSize;
	        Map<String, Object> articleList = new HashMap<>();
	        articleList.put("offset", offset);
	        articleList.put("pageSize", pageSize);

			return articleMapper.getNewsByDate(articleList);
		}

		//기사의 총 수를 가져옴(페이지네이션)
		public int countArticle() {
			return articleMapper.countArticle();
		}
		
		//초기데이터가 있는지 없는지
		public boolean isNewsData() {
			int count = countArticle();
		    return count != 0; //0이 아니면 true, 0이면 false
		}


}

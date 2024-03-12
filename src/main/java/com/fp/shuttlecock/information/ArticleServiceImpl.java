package com.fp.shuttlecock.information;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
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
	public ArticleDTO insertNews(ArticleDTO articleDTO) {
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
	                articleMapper.insertNews(article);
	            }
	        }

	        return articleDTO;
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    return null;
	}
		//중복된 뉴스체크
		public boolean isNewsCheck(ArticleDTO article) {
			return articleMapper.isNewsCheck(article.getTitle());
		}
		
		//최신기사부터 출력하기
		public List<ArticleDTO> getNewsByDate(ArticleDTO articleDTO) {
			return articleMapper.getNewsByDate(articleDTO);
		}


}

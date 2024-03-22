package com.fp.shuttlecock.information;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fp.shuttlecock.user.UserDTO;
import com.fp.shuttlecock.user.UserServiceImpl;

@Controller
public class ArticleController {

	@Autowired
	ArticleServiceImpl articleService;
	

	  	//최신 기사 가져오기
	    @GetMapping("/getNews")
	    public String getNewsByDate(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "8") int pageSize
	    							,ArticleDTO articleDTO, Model model) {
	    	boolean isNewsData = articleService.isNewsData();
	    	
	    	//초기데이터가 있는지 없는지 확인
		    if (!isNewsData) {	
		        System.out.println("articleDB 초기 데이터가 없으므로 데이터 삽입을 수행합니다.");
		        try {
		        	articleService.insertNews(); //초기 데이터 삽입
		            System.out.println("articleDB insert 성공");
		        } catch (Exception e) {
		            System.out.println("articleDB insert 실패: " + e.getMessage());
		        }
		    } else {
		        System.out.println("articleDB 초기 데이터 이미 존재합니다.");
		    }
	    	
	    	
		    //웹크롤링 데이터 insert
	    	//ArticleDTO article = articleService.insertNews(articleDTO); 
	    	//if (article != null) {
	        //    System.out.println("articleDB insert 성공");
	        //} else {
	        //    System.out.println("articleDB insert 실패");
	        //}	
        
	    	List<ArticleDTO> newsList = articleService.getNewsByDate(page, pageSize); 
	    	
	    	 int totalArticle = articleService.countArticle();
	    	 int totalPage = (int) Math.ceil((double) totalArticle / pageSize);

	    	 model.addAttribute("newsList", newsList);
	    	 model.addAttribute("currentPage", page);
	    	 model.addAttribute("totalPage", totalPage);
    	    
    	    return "information/news";
    	}
	
}

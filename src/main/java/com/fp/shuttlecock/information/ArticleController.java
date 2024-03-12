package com.fp.shuttlecock.information;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.fp.shuttlecock.user.UserDTO;
import com.fp.shuttlecock.user.UserServiceImpl;

@Controller
public class ArticleController {

	@Autowired
	ArticleServiceImpl articleService;
	
	  //웹크롤링 데이터 insert
	  @GetMapping("/insertNews")
	    public String insertNewsData(ArticleDTO articleDTO, Model model) {
		  ArticleDTO article = articleService.insertNews(articleDTO);
		  	if (article != null) {
		        //model.addAttribute("articleDTO", articleDTO);
		  		System.out.println("articleDB insert 성공");
		    }else {
		        System.out.println("articleDB insert 실패");
		    }
		    return "information/news";
	    }

	  	//최신 기사 가져오기
	    @GetMapping("/getNews")
	    public String getNewsByDate(ArticleDTO articleDTO, Model model) {
    	 List<ArticleDTO> newsList = articleService.getNewsByDate(articleDTO); 
    	    model.addAttribute("newsList", newsList); 
    	    return "information/news";
    	}
	
}

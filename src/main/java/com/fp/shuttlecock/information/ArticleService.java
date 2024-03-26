package com.fp.shuttlecock.information;

import java.util.List;

import com.fp.shuttlecock.user.UserDTO;

public interface ArticleService {
	boolean isNewsCheck(ArticleDTO article);
	
	void insertNews();
	
	List<ArticleDTO> getNewsByDate(int page, int pageSize);
	
	int countArticle();
	
	/* boolean isNewsData(); */
}

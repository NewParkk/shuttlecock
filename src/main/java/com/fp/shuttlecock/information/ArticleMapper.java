package com.fp.shuttlecock.information;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ArticleMapper {

	public boolean isNewsCheck(String title);

	/* public void insertNews(ArticleDTO articleDTO); */

	public List<ArticleDTO> getNewsByDate(Map<String, Object> articleList);

	public int countArticle();

	/* public int isNewsData(); */

	public void getinsertNews(ArticleDTO article);


}

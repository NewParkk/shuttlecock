package com.fp.shuttlecock.information;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ArticleMapper {

	public boolean isNewsCheck(String title);

	public void insertNews(ArticleDTO articleDTO);

	public List<ArticleDTO> getNewsByDate(ArticleDTO articleDTO);


}

package com.fp.shuttlecock.information;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class ArticleDTO {
	private int articleId;	//기사번호
	private String title;	//기사제목
	private String content;	//기사내용
	private String writer;	//기사작성자
	private String image;	//기사이미지
	private String url;		//기사링크
	private Date updateDate;//기사작성일
}

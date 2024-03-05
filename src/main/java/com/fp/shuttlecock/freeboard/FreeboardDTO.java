package com.fp.shuttlecock.freeboard;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class FreeboardDTO {
	private int freeboardId;
	private String title;
	private String writer; // 작성자 추가
	private String content;
	private int like;
	private int hit;
	private Date writeDate;
	private Date updateDate;
	private int commentCount;
	private int likeCount;
}

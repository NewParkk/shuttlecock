package com.fp.shuttlecock.mypage;

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
public class FreeboardDTO {
	private int freeboardId;
	private String title;
	private String content;
	private int like;
	private int hit;
	private String uploadpath;
	private String fileloca;
	private String filename;
	private String ilerealname;
	private Date regdate;
	private int commentCount;
	private int likeCount;
	private String userId;
}

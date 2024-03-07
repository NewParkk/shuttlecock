package com.fp.shuttlecock.mypage;

import java.sql.Date;

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
public class CommentsDTO {
	private int commentsId;
	private int bno;
	private String writerId;
	private String content;
	private Date regdate;
	private int secret;
	private int tradeboardId;
	private int freeboardId;
	private String user_userId;
	private int recruitboard_recruitboardId;
}

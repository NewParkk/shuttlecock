package com.fp.shuttlecock.mypage;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
@AllArgsConstructor
public class CommentsDTO {
	
	private int commentsId;
	private String content;
	private Timestamp regdate;
	private int secret;
	private int bno;
	private boolean deleteYN;
	private int commentType;
	private String userId;
	
}

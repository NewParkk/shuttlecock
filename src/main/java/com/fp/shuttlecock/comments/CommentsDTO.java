package com.fp.shuttlecock.comments;

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
	
	private int commentNo;
	private String commentId;
	private String content;
	private Timestamp regdate;
	private int secret;
	private int freeboardId;
	private int tradeboardId;
	private int recruitboardId;
}

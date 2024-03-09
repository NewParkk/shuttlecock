package com.fp.shuttlecock.comments;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class CommentsDTO {
//
//	create table Comments (
//			commentNo int(10) AUTO_INCREMENT PRIMARY KEY not null,	// 댓글의 고유 식별자인 댓글 번호.
//			bno int(10),											// 댓글이 속한 게시물의 번호를 나타내는 외래 키(foreign key).
//			commentId varchar(20),									// 댓글을 작성한 사용자의 아이디나 식별자.
//			content varchar(1000),									// 댓글의 내용을 저장하는 열.
//			regdate TIMESTAMP DEFAULT NOW()							// 댓글이 작성된 날짜와 시간을 나타내는 타임스탬프.
//			);
	
	private int commentNo;
	private String commentId;
	private String content;
	private Timestamp regdate;
	private int secret;
	private int freeboard_freeboardId;
	private int tradeboard_tradeboardId;
	private int recruitboard_recruitboardId;
}

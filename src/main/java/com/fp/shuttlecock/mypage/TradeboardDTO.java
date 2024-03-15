package com.fp.shuttlecock.mypage;

import java.sql.Timestamp;

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
public class TradeboardDTO {
	private int tradeboardId;
	private String title;
	private String content;
	private int hit;
	private Timestamp regdate;
	private int like;
	private int commentCount;
	private int region;
	private int complete;
	private String userId;
}

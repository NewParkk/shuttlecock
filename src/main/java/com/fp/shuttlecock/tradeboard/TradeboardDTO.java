package com.fp.shuttlecock.tradeboard;

import java.sql.Timestamp;

import lombok.Data;

@Data
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
	private int delete_yn;
	private String userId;
	
}

package com.fp.shuttlecock.tradeboard;

import java.sql.Timestamp;
import java.util.List;

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
	private int complete;
	private int deleteYN;
	private String userId;
	private int itemClass;
	private String imageName;
	private int badgeId;
	private String badgeName;
	private int region;
	private List<Integer> regions;
}

package com.fp.shuttlecock.recruitboard;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class RecruitboardDTO {
	private int recruitboardId;
	private String title;
	private String content;
	private int like;
	private Timestamp regdate;
	private int hit;
	private int commentCount;
	private int region;
	private int complete;
	private int deleteYN;
	private String userId;
	private int recruitType;
	private String imageName;
	private int badgeId;
	private String badgeName;
}

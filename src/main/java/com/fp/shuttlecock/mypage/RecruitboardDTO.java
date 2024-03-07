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
public class RecruitboardDTO {
	private int recruitboardId;
	private String title;
	private String content;
	private int like;
	private int hit;
	private Date updateDate;
	private int commentCount;
	private int complete;
	private int recruitType;
	private int region;
	private String user_userId;
}

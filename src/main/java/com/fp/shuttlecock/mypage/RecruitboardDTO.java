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
public class RecruitboardDTO {
	private int recruitboardId;
	private String title;
	private String content;
	private int like;
	private int hit;
	private Timestamp regdate;
	private int commentCount;
	private int complete;
	private int recruitType;
	private int region;
	private String userId;
	private boolean delete_yn;
}

package com.fp.shuttlecock.mypage;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@Setter
@ToString
public class UserDTO {
	private String userId;
	private String pw;
	private String username;
	private int gender;
	private int admin;
	private String userEmail;
	private String userImage;
	private String userPhone;
	private int userLeagueGrade;
	private int wincount;
	private int losecount;
	private int writeCount;
	private int badge_badgeId;
}

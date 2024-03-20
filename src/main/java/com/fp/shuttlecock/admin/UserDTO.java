package com.fp.shuttlecock.admin;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class UserDTO {
	private String userId;
	private String pw;
	private String username;
	private int gender;
	private boolean admin;
	private String userEmail;
	private String userImageName;
	private String userImagePath;
	private int userLeagueGrade;
	private int wincount;
	private int losecount;
	private int writeCount;
	private int badgeId;

	@Builder
	public UserDTO(String userId, String pw, String username, int gender, boolean admin, String userEmail, String userImageName,String userImagePath,
			int userLeagueGrade, int wincount, int losecount, int writeCount, int badgeId) {
		super();
		this.userId = userId;
		this.pw = pw;
		this.username = username;
		this.gender = gender;
		this.admin = admin;
		this.userEmail = userEmail;
		this.userImageName = userImageName;
		this.userImagePath = userImagePath;
		this.userLeagueGrade = userLeagueGrade;
		this.wincount = wincount;
		this.losecount = losecount;
		this.writeCount = writeCount;
		this.badgeId = badgeId;
	}
}

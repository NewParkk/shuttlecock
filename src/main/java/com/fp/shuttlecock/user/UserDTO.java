package com.fp.shuttlecock.user;

import lombok.AllArgsConstructor;
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
	private int idx;			//row_number
	private String userId; 		//사용자ID
	private String pw;			//비밀번호
	private String username;	//이름
	private int gender;			//성별(1:남자,2:여자)
	private boolean admin;		//관리자판별여부(0:회원,1:관리자)
	private String userEmail;	//이메일
	private String userImageName; // 프로필이미지 파일 이름
	private int userLeagueGrade;//리그뱃지번호
	private int wincount;		//승리횟수
	private int losecount;		//패배횟수
	private int writeCount;		//글작성수(기존0)
	private int badgeId;	//회원등급(기존1)
	private String userImagePath;	//프로필이미지 경로
	private boolean kakaoYN;	//카카오 회원여부
	
	@Builder
	public UserDTO(String userId, String pw, String username, int gender, boolean admin, String userEmail,
			String userImageName, int userLeagueGrade, int wincount, int losecount, int writeCount,
			int badgeId,String userImagePath, boolean kakaoYN) {
		super();
		this.userId = userId;
		this.pw = pw;
		this.username = username;
		this.gender = gender;
		this.admin = admin;
		this.userEmail = userEmail;
		this.userImageName = userImageName;
		this.userLeagueGrade = userLeagueGrade;
		this.wincount = wincount;
		this.losecount = losecount;
		this.writeCount = writeCount;
		this.badgeId = badgeId;
		this.userImagePath = userImagePath;
		this.kakaoYN = kakaoYN;
	}
	
	
	
}

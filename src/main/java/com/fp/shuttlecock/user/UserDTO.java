package com.fp.shuttlecock.user;

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
public class UserDTO {

	private String userId; 		//사용자ID
	private String pw;			//비밀번호
	private String username;	//이름
	private int gender;			//성별(1:남자,2:여자)
	private boolean admin;			//관리자판별여부(0:회원,1:관리자)
	private String userEmail;	//이메일
	private String userImage;	//프로필이미지
	private String userPhone;	//전화번호
	private int userLeagueGrade;//리그뱃지번호
	private int wincount;		//승리횟수
	private int losecount;		//패배횟수
	private int writeCount;		//글작성수(기존0)
	private int badge_badgeId;	//회원등급(기존1)
	
}

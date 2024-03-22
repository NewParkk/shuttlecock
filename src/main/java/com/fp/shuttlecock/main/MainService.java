package com.fp.shuttlecock.main;

import java.text.ParseException;
import java.util.List;

import com.fp.shuttlecock.freeboard.FreeboardDTO;
import com.fp.shuttlecock.leagueboard.LeagueboardDTO;
import com.fp.shuttlecock.user.UserDTO;

public interface MainService {
	
	//메인에 표기할 leagueboard게시물
	List<LeagueboardDTO> get5LeaguePosts() throws ParseException;
	//메인에 표기할 freeboard게시물
	//List<FreeboardDTO> get5FreePosts() throws ParseException;
	//뱃지 정보 가져오기
	List<BadgeDTO> getBadgeList(int badgeType);
	//유저 커뮤니티 뱃지 갱신
	int updateCommunityBadge(UserDTO user);
	//유저 순위 갱신
	void updateUserLeagueGrade();
	
}

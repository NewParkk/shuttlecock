package com.fp.shuttlecock.main;

import java.text.ParseException;
import java.util.List;

import com.fp.shuttlecock.freeboard.FreeboardDTO;
import com.fp.shuttlecock.leagueboard.LeagueboardDTO;

public interface MainService {
	
	//메인에 표기할 leagueboard게시물
	List<LeagueboardDTO> get5LeaguePosts() throws ParseException;
	//메인에 표기할 freeboard게시물
	List<FreeboardDTO> get5FreePosts() throws ParseException;
	//모든 유저 커뮤니티 뱃지 갱신
//	void updateCommunityBadge();
	
}

package com.fp.shuttlecock.leagueboard;

import java.util.List;

import com.fp.shuttlecock.user.UserDTO;

public interface LeagueboardRankingService {

	List<UserDTO> getLeagueRanking();

	List<UserDTO> getRankedList();
	
	int countLeagueUser();
	
}

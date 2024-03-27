package com.fp.shuttlecock.leagueboard;

import java.util.List;

import com.fp.shuttlecock.user.UserDTO;

public interface LeagueboardRankingService {

	List<LeagueRankDTO> getLeagueRanking(PageRequestDTO pageRequest);

	int countLeagueUser(PageRequestDTO pageRequest);
	
	List<LeagueRankDTO> getLeagueRankingByUsername(PageRequestDTO pageRequest);
	
}

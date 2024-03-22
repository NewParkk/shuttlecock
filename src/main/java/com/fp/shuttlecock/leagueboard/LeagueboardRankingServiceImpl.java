package com.fp.shuttlecock.leagueboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fp.shuttlecock.user.UserDTO;

@Service
public class LeagueboardRankingServiceImpl implements LeagueboardRankingService {

	@Autowired
	LeagueboardRankingMapper LRM;
	
	public List<UserDTO> getLeagueRanking(PageRequestDTO pageRequest) {
		return LRM.getLeagueRanking(pageRequest);
	}

	@Override
	public List<UserDTO> getRankedList() {
		return LRM.getRankedList();
	}

	public int countLeagueUser(PageRequestDTO pageRequest) {
		return LRM.countLeagueUser(pageRequest);
	}
//
//	public List<UserDTO> getSearchLeagueUser(PageRequestDTO pageRequest) {
//		return LRM.getSearchLeagueUser(pageRequest);
//	}
//
//	public int countSearchLeagueUser(PageRequestDTO pageRequest) {
//		return LRM.countSearchLeagueUser(pageRequest);
//	}

	public List<UserDTO> getLeagueRankingByUsername(PageRequestDTO pageRequest) {
	    return LRM.getLeagueRankingByUsername(pageRequest);
	}
}

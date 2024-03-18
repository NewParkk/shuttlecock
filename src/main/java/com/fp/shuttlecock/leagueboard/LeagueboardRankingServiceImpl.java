package com.fp.shuttlecock.leagueboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fp.shuttlecock.user.UserDTO;

@Service
public class LeagueboardRankingServiceImpl implements LeagueboardRankingService {

	@Autowired
	LeagueboardRankingMapper LRM;
	
	public List<UserDTO> getLeagueRanking() {
		return LRM.getLeagueRanking();
	}

	@Override
	public List<UserDTO> getRankedList() {
		return LRM.getRankedList();
	}
	
}

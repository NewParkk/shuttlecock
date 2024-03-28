package com.fp.shuttlecock.leagueboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fp.shuttlecock.user.UserDTO;

@Service
public class LeagueboardRankingServiceImpl implements LeagueboardRankingService {

	@Autowired
	LeagueboardRankingMapper LRM;
	
	// 리그 유저의 데이터
	public List<LeagueRankDTO> getLeagueRanking(PageRequestDTO pageRequest) {
		return LRM.getLeagueRanking(pageRequest);
	}
	
	// 리그 인원 수
	public int countLeagueUser(PageRequestDTO pageRequest) {
		return LRM.countLeagueUser(pageRequest);
	}
	
	// 해당 username에 대한 인원 검색
	public List<LeagueRankDTO> getLeagueRankingByUsername(PageRequestDTO pageRequest) {
        return LRM.getLeagueRankingByUsername(pageRequest);
	}
	
}

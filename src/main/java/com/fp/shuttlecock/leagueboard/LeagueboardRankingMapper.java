package com.fp.shuttlecock.leagueboard;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.data.repository.query.Param;

@Mapper
public interface LeagueboardRankingMapper {

	public List<LeagueRankDTO> getLeagueRanking(PageRequestDTO pageRequest);

	public int countLeagueUser(PageRequestDTO pageRequest);

	public List<LeagueRankDTO> getLeagueRankingByUsername(PageRequestDTO pageRequest);
	
}

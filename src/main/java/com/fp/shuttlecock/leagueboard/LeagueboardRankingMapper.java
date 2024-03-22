package com.fp.shuttlecock.leagueboard;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fp.shuttlecock.user.UserDTO;

@Mapper
public interface LeagueboardRankingMapper {

	public List<UserDTO> getLeagueRanking(PageRequestDTO pageRequest);

	public List<UserDTO> getRankedList();

	public int countLeagueUser(PageRequestDTO pageRequest);

	public List<UserDTO> getSearchLeagueUser(PageRequestDTO pageRequest);

	public int countSearchLeagueUser(PageRequestDTO pageRequest);

	public List<UserDTO> getLeagueRankingByUsername(PageRequestDTO pageRequest);
}

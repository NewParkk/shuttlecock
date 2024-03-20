package com.fp.shuttlecock.leagueboard;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fp.shuttlecock.user.UserDTO;

@Mapper
public interface LeagueboardRankingMapper {

	public List<UserDTO> getLeagueRanking();

	public List<UserDTO> getRankedList();

	public int countLeagueUser();
}

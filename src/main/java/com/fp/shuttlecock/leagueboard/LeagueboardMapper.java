package com.fp.shuttlecock.leagueboard;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LeagueboardMapper {

	List<LeagueboardDTO> getAllLeaguePost();

	LeagueboardDTO getLeaguePostById(int leagueboardId);

	int insertLeaguePost(LeagueboardDTO leagueboardDTO);

	int updateLeaguePost(LeagueboardDTO leagueboardDTO);

	int deleteLeaguePost(int leagueboardId);

	void increaseWinnerPoint(String winner);

	void increaseLoserPoint(String loser);

	List<LeagueboardDTO> getAllLeaguePostByPage(PageRequestDTO pageRequest);

	int countLeaguePosts();
	
	List<LeagueboardDTO> getSearchedLeaguePost(PageRequestDTO pageRequest);

	int countSearchedLeaguePosts(PageRequestDTO pageRequest);

	void increaseWriteCount(String userId);

	int updateDeletedLeaguePost(int leagueboardId);

	void decreaseLoserPoint(String userId);

	void decreaseWinnerPoint(String userId);

	void increaseWinnerRanking(String userId);

	void decreaseLoserRanking(String userId);

	void increaseLoserRanking(String loser);

	void decreaseWinnerRanking(String loser);
	
}

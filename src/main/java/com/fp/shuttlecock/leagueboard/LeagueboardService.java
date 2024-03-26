package com.fp.shuttlecock.leagueboard;

import java.util.List;

public interface LeagueboardService {
	List<LeagueboardDTO> getAllLeaguePost();
	
	LeagueboardDTO getLeaguePostById(int leagueboardId);
	
	void insertLeaguePost(LeagueboardDTO leagueboardDTO);
	
	boolean updateLeaguePost(LeagueboardDTO leagueboardDTO);
	
	boolean deleteLeaguePost(int leagueboardId);
	
	void increaseWinnerPoint(String winner);
	
	void increaseLoserPoint(String loser);
	
	List<LeagueboardDTO> getAllLeaguePostByPage(PageRequestDTO pageRequest);
	
	int countLeaguePosts();
	
	List<LeagueboardDTO> getSearchedLeaguePost(PageRequestDTO pageRequest);
	
	int countSearchedLeaguePosts(PageRequestDTO pageRequest);
	
	void increaseWriteCount(String userId);
	
	boolean updateDeletedLeaguePost(int leagueboardId);
	
	void increaseWinnerPoint(List<String> winnerList);
	
	void increaseLoserPoint(List<String> loserList);
	
	void decreaseLoserPoint(String userId);
	
	void decreaseWinnerPoint(String userId);
}

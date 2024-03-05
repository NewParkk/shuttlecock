package com.fp.shuttlecock.leagueboard;

import java.util.List;

public interface LeagueboardServiceImpl {
	List<LeagueboardDTO> getAllLeaguePost();
	
	List<LeagueboardDTO> getAllLeaguePostByPage(int offset, int pagesize);
	
	int countLeaguePosts();
	
	LeagueboardDTO getLeaguePostById(int leagueboardId);
	
	void insertLeaguePost(LeagueboardDTO leagueboardDTO);
	
	boolean updateLeaguePost(LeagueboardDTO leagueboardDTO);
	
	boolean deleteLeaguePost(int leagueboardId);
	
}

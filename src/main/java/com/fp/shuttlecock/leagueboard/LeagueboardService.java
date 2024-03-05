package com.fp.shuttlecock.leagueboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LeagueboardService implements LeagueboardServiceImpl{
	@Autowired
	LeagueboardMapper leaguemapper;

	public List<LeagueboardDTO> getAllLeaguePost() {
		return leaguemapper.getAllLeaguePost();
	}

	public List<LeagueboardDTO> getAllLeaguePostByPage(int page, int pagesize) {
		int offset = (page - 1) * pagesize;
		return leaguemapper.getAllLeaguePostByPage(offset, pagesize);
	}

	public int countLeaguePosts() {
		return leaguemapper.countLeaguePosts();
	}
	
	public List<LeagueboardDTO> getLeaguePostByTitle(int page, int pagesize, String query) {
		int offset = (page - 1) * pagesize;
		return leaguemapper.getLeaguePostByTitle(offset, pagesize, query);
	}

	public int countSearchedLeaguePosts(String query) {
		return leaguemapper.countSearchedLeaguePosts(query);
	}

	public LeagueboardDTO getLeaguePostById(int leagueboardId) {
		LeagueboardDTO leagueboard = leaguemapper.getLeaguePostById(leagueboardId);
		return leagueboard;
	}

	public void insertLeaguePost(LeagueboardDTO leagueboardDTO) {
		leaguemapper.insertLeaguePost(leagueboardDTO);
	}

	public boolean updateLeaguePost(LeagueboardDTO leagueboardDTO) {
		boolean result = false;
		if(leaguemapper.updateLeaguePost(leagueboardDTO) == 1) {
			result = true;
		}
		return result;
	}

	public boolean deleteLeaguePost(int leagueboardId) {
		boolean result = false;
		if(leaguemapper.deleteLeaguePost(leagueboardId) == 1) {
			result = true;
		}
		return result;
	}

}

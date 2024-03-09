package com.fp.shuttlecock.leagueboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;

@Service
public class LeagueboardServiceImpl implements LeagueboardService{
	@Autowired
	LeagueboardMapper leaguemapper;

	public List<LeagueboardDTO> getAllLeaguePost() {
		return leaguemapper.getAllLeaguePost();
	}
	
	public LeagueboardDTO getLeaguePostById(int leagueboardId) {
		LeagueboardDTO leagueboard = leaguemapper.getLeaguePostById(leagueboardId);
		return leagueboard;
	}

	public void insertLeaguePost(@ModelAttribute LeagueboardDTO leagueboardDTO) {
		leaguemapper.insertLeaguePost(leagueboardDTO);
	}

	public boolean updateLeaguePost(LeagueboardDTO leagueboardDTO) {
		boolean result = false;
		if(leaguemapper.updateLeaguePost(leagueboardDTO) != 0) {
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

	public void increaseWinnerPoint(String winner) {
		if(winner.contains(",")) {
			String[] winnerList = winner.split(",");
			leaguemapper.increaseWinnerPoint(winnerList[0]);
			leaguemapper.increaseWinnerPoint(winnerList[1]);
		}
		leaguemapper.increaseWinnerPoint(winner);
	}

	public void increaseLoserPoint(String loser) {
		if(loser.contains(",")) {
			String[] loserList = loser.split(",");
			leaguemapper.increaseLoserPoint(loserList[0]);
			leaguemapper.increaseLoserPoint(loserList[1]);
		}
		leaguemapper.increaseLoserPoint(loser);
	}

	public List<LeagueboardDTO> getAllLeaguePostByPage(PageRequestDTO pageRequest) {
		return leaguemapper.getAllLeaguePostByPage(pageRequest);
	}
	
	public int countLeaguePosts() {
		return leaguemapper.countLeaguePosts();
	}

	public List<LeagueboardDTO> getSearchedLeaguePost(PageRequestDTO pageRequest) {
		return leaguemapper.getSearchedLeaguePost(pageRequest);
	}

	public int countSearchedLeaguePosts(PageRequestDTO pageRequest) {
		System.out.println("service : " + pageRequest);
		return leaguemapper.countSearchedLeaguePosts(pageRequest);
	}

	public void increaseWriteCount(String userId) {
		leaguemapper.increaseWriteCount(userId);
	}

}

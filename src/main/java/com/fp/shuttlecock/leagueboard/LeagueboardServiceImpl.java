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
		leaguemapper.increaseWinnerPoint(winner);
	}

	public void increaseLoserPoint(String loser) {
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

	public boolean updateDeletedLeaguePost(int leagueboardId) {
		boolean result = false;
		if(leaguemapper.updateDeletedLeaguePost(leagueboardId) == 1) {
			result = true;
		}
		return result;
	}

	public void increaseWinnerPoint(List<String> winnerList) {
		for(String winner : winnerList) {
			leaguemapper.increaseWinnerPoint(winner);
		}
	}

	public void increaseLoserPoint(List<String> loserList) {
		for(String loser : loserList) {
			leaguemapper.increaseLoserPoint(loser);
		}
	}

	public void decreaseLoserPoint(String userId) {
		leaguemapper.decreaseLoserPoint(userId);
	}

	public void decreaseWinnerPoint(String userId) {
		leaguemapper.decreaseWinnerPoint(userId);
	}

	public void increaseWinnerRanking(String winner) {
		leaguemapper.increaseWinnerRanking(winner);
	}

	public void decreaseLoserRanking(String winner) {
		leaguemapper.decreaseLoserRanking(winner);
	}

	public void increaseLoserRanking(String loser) {
		leaguemapper.increaseLoserRanking(loser);
	}

	public void decreaseWinnerRanking(String loser) {
		leaguemapper.decreaseWinnerRanking(loser);
	}

}

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

	public int countSearchedLeaguePostsByTitle(String query) {
		return leaguemapper.countSearchedLeaguePostsByTitle(query);
	}

	public List<LeagueboardDTO> getLeaguePostByUserId(int page, int pagesize, String query) {
		int offset = (page - 1) * pagesize;
		return leaguemapper.getLeaguePostByUserId(offset, pagesize, query);
	}
	
	public int countSearchedLeaguePostsByUserId(String query) {
		return leaguemapper.countSearchedLeaguePostsByUserId(query);
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
		System.out.println("업데이트 리그포스트 서비스");
		if(leaguemapper.updateLeaguePost(leagueboardDTO) != 0) {
			System.out.println("성공?");
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
		return leaguemapper.getAllLeaguePostByPagenew(pageRequest);
	}

	public List<LeagueboardDTO> getSearchedLeaguePost(PageRequestDTO pageRequest) {
		return leaguemapper.getSearchedLeaguePost(pageRequest);
	}

	public int countSearchedLeaguePosts(PageRequestDTO pageRequest) {
		System.out.println("service : " + pageRequest);
		return leaguemapper.countSearchedLeaguePosts(pageRequest);
	}

}

package com.fp.shuttlecock.leagueboard;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LeagueboardMapper {

	List<LeagueboardDTO> getAllLeaguePost();

	List<LeagueboardDTO> getAllLeaguePostByPage(int offset, int pagesize);

	int countLeaguePosts();

	LeagueboardDTO getLeaguePostById(int leagueboardId);

	int insertLeaguePost(LeagueboardDTO leagueboardDTO);

	int updateLeaguePost(LeagueboardDTO leagueboardDTO);

	int deleteLeaguePost(int leagueboardId);

	List<LeagueboardDTO> getLeaguePostByTitle(int offset, int pagesize, String query);

	int countSearchedLeaguePosts(String query);
	
}

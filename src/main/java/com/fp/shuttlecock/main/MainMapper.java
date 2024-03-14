package com.fp.shuttlecock.main;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fp.shuttlecock.freeboard.FreeboardDTO;
import com.fp.shuttlecock.leagueboard.LeagueboardDTO;

@Mapper
public interface MainMapper {

	List<LeagueboardDTO> get5LeaguePosts();

	List<FreeboardDTO> get5FreePosts();
	
}

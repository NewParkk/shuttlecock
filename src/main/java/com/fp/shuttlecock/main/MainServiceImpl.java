package com.fp.shuttlecock.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.fp.shuttlecock.freeboard.FreeboardDTO;
import com.fp.shuttlecock.leagueboard.LeagueboardDTO;

@Primary
@Service
public class MainServiceImpl implements MainService{
	
	@Autowired
	MainMapper mainMapper;
	
	@Override
	public List<LeagueboardDTO> get5LeaguePosts() {
		return mainMapper.get5LeaguePosts();
	}

	@Override
	public List<FreeboardDTO> get5FreePosts() {
		return  mainMapper.get5FreePosts();
	}
	
	
	
}

package com.fp.shuttlecock.main;

import java.text.ParseException;
import java.util.List;

import com.fp.shuttlecock.freeboard.FreeboardDTO;
import com.fp.shuttlecock.leagueboard.LeagueboardDTO;

public interface MainService {

	List<LeagueboardDTO> get5LeaguePosts() throws ParseException;

	List<FreeboardDTO> get5FreePosts() throws ParseException;

}

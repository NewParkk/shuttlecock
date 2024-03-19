package com.fp.shuttlecock.information;

import java.util.List;

public interface CompetitionService {

	void insertGame(CompetitionDTO competitionDTO);
	
	List<CompetitionDTO> getEventByDate();
	
	boolean isCompCheck(CompetitionDTO competition);
	
	boolean isFirstData();
	
	List<CompetitionDTO> getRegionEvent(String region);
}

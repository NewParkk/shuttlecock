package com.fp.shuttlecock.information;

import java.util.List;

public interface CompetitionService {

	CompetitionDTO insertGame(CompetitionDTO competitionDTO);
	
	List<CompetitionDTO> getEventByDate(String region);
	
	boolean isCompCheck(CompetitionDTO competition);
}

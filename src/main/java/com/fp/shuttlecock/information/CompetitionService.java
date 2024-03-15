package com.fp.shuttlecock.information;

import java.util.List;

public interface CompetitionService {

	CompetitionDTO insertGame(CompetitionDTO competition);
	
	List<CompetitionDTO> getEventByDate(String region);
}

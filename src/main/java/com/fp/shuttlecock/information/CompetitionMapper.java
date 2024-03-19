package com.fp.shuttlecock.information;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CompetitionMapper {

	List<CompetitionDTO> getEventByDate();

	void insertGame(CompetitionDTO competitionDTO);

	boolean isCompCheck(String title);

	int isFirstData();

	List<CompetitionDTO> getRegionEvent(String region);

}

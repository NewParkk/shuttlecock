package com.fp.shuttlecock.information;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CompetitionMapper {

	List<CompetitionDTO> getEventByDate(String region);

	CompetitionDTO insertGame(CompetitionDTO competition);

}

package com.fp.shuttlecock.information;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CompetitionServiceImpl implements CompetitionService {

	@Autowired
	CompetitionMapper competitionMapper;

	//selenium으로 정규대회 크롤링
	public CompetitionDTO insertGame(CompetitionDTO competition) {

		return competitionMapper.insertGame(competition);
	}

	//모든 정규대회 출력
	public List<CompetitionDTO> getEventByDate(String region) {
		return competitionMapper.getEventByDate(region);
	}
}

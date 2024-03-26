package com.fp.shuttlecock.recruitboard;

import java.sql.Timestamp;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fp.shuttlecock.tradeboard.PageRequestDTO;

@Mapper
public interface RecruitboardMapper {

	RecruitboardDTO getTradePostByTradeboardId(int recruitboardId);

	void increaseHit(int recruitboardId);

	List<RecruitboardDTO> getPagenatedSearch(PageRequestDTO pageRequest);

	int getTotalCount(PageRequestDTO pageRequest);

	int insertBoard(RecruitboardDTO recruitboard);

	int updateTradePost(RecruitboardDTO recruitboard);

	int deleteTradePost(int recruitboardId);

	void increaseWriteCount(String userId);

	int updateDeletedTradePost(int recruitboardId);

	int getLatestTradeboardId();

	List<Integer> findCompletedBoards(Timestamp threeDaysAgo);

	List<Integer> getCompletedPost();

	void setPostCompleted(int recruitboardId);

	int deleteCompletedPost();
	
}

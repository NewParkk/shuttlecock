package com.fp.shuttlecock.recruitboard;

import java.util.List;

import com.fp.shuttlecock.tradeboard.PageRequestDTO;

public interface RecruitboardService {
	RecruitboardDTO getTradePostByTradeboardId(int recruitboardId);
	
	void increaseHit(int recruitboardId);
	
	List<RecruitboardDTO> getPagenatedSearch(PageRequestDTO pageRequest);
	
	int getTotalCount(PageRequestDTO pageRequest);
	
	boolean insertBoard(RecruitboardDTO recruitboard);
	
	boolean updateTradePost(RecruitboardDTO recruitboard);
	
	boolean deleteTradePost(int recruitboardId);
	
	void increaseWriteCount(String userId);
	
	boolean updateDeletedTradePost(int recruitboardId);
	
//	void getCompletedPost();
	
	int findCompletedBoards();
	
	void setPostCompleted(int recruitboardId);
}

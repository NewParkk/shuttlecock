package com.fp.shuttlecock.tradeboard;

import java.util.List;

public interface TradeboardService {
	TradeboardDTO getTradePostByTradeboardId(int tradeboardId);
	
	void increaseHit(int tradeboardId);
	
	List<TradeboardDTO> getPagenatedSearch(PageRequestDTO pageRequest);
	
	int getTotalCount(PageRequestDTO pageRequest);
	
	boolean insertBoard(TradeboardDTO tradeboard);
	
	boolean updateTradePost(TradeboardDTO tradeboard);
	
	boolean deleteTradePost(int tradeboardId);
	
	void increaseWriteCount(String userId);
	
	boolean updateDeletedTradePost(int tradeboardId);
	
	int findCompletedBoards();
	
	//void getCompletedPost();
	
	String getBadgeNameById(int badgeId);
	
	void insertRegion(int tradeboardId, List<Integer> regions);
	
	int getTradeboardId();
	
	void deleteTraderegion(int tradeboardId);
	
	List<Integer> getRegionList(int tradeboardId);
}

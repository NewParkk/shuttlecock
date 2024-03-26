package com.fp.shuttlecock.tradeboard;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TradeboardMapper {

	TradeboardDTO getTradePostByTradeboardId(int tradeboardId);

	void increaseHit(int tradeboardId);

	List<TradeboardDTO> getPagenatedSearch(PageRequestDTO pageRequest);

	int getTotalCount(PageRequestDTO pageRequest);

	int insertBoard(TradeboardDTO tradeboard);

	int updateTradePost(TradeboardDTO tradeboard);

	int deleteTradePost(int tradeboardId);

	void increaseWriteCount(String userId);

	int updateDeletedTradePost(int tradeboardId);

	int deleteCompletedPost();

	List<Integer> getCompletedPost();

	String getBadgeNameById(int badgeId);

	void insertRegion(HashMap<String, Integer> map);

	int getTradeboardId();

	void deleteTraderegion(int tradeboardId);

	List<TraderegionDTO> getRegionList(int tradeboardId);
	
}

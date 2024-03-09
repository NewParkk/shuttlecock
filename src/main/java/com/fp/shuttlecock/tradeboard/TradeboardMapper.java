package com.fp.shuttlecock.tradeboard;

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

	void increaseWriteCount(String user_userId);
	
}

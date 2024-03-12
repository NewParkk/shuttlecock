package com.fp.shuttlecock.tradeboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TradeboardServiceImpl implements TradeboardService {
	@Autowired
	TradeboardMapper tradeboardmapper;

	public TradeboardDTO getTradePostByTradeboardId(int tradeboardId) {
		return tradeboardmapper.getTradePostByTradeboardId(tradeboardId);
	}

	public void increaseHit(int tradeboardId) {
		tradeboardmapper.increaseHit(tradeboardId);
	}

	public List<TradeboardDTO> getPagenatedSearch(PageRequestDTO pageRequest) {
		return tradeboardmapper.getPagenatedSearch(pageRequest);
	}

	public int getTotalCount(PageRequestDTO pageRequest) {
		return tradeboardmapper.getTotalCount(pageRequest);
	}

	public boolean insertBoard(TradeboardDTO tradeboard) {
		int result = tradeboardmapper.insertBoard(tradeboard);
		if(result == 1) {
			return true;
		}
		return false;
	}

	public boolean updateTradePost(TradeboardDTO tradeboard) {
		int result = tradeboardmapper.updateTradePost(tradeboard);
		if(result == 1) {
			return true;
		}
		return false;
	}

	public boolean deleteTradePost(int tradeboardId) {
		int result = tradeboardmapper.deleteTradePost(tradeboardId);
		if(result == 1) {
			return true;
		}
		return false;
	}

	public void increaseWriteCount(String user_userId) {
		tradeboardmapper.increaseWriteCount(user_userId);
	}

	public boolean updateDeletedTradePost(int tradeboardId) {
		int result = tradeboardmapper.updateDeletedTradePost(tradeboardId);
		if(result == 1) {
			return true;
		}
		return false;
	}
}

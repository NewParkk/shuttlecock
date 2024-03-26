package com.fp.shuttlecock.tradeboard;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
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
		if (result == 1) {
			return true;
		}
		return false;
	}

	public boolean updateTradePost(TradeboardDTO tradeboard) {
		int result = tradeboardmapper.updateTradePost(tradeboard);
		if (result == 1) {
			return true;
		}
		return false;
	}

	public boolean deleteTradePost(int tradeboardId) {
		int result = tradeboardmapper.deleteTradePost(tradeboardId);
		if (result == 1) {
			return true;
		}
		return false;
	}

	public void increaseWriteCount(String userId) {
		tradeboardmapper.increaseWriteCount(userId);
	}

	public boolean updateDeletedTradePost(int tradeboardId) {
		int result = tradeboardmapper.updateDeletedTradePost(tradeboardId);
		if (result == 1) {
			return true;
		}
		return false;
	}

	@Scheduled(cron = "0 0 0 1/1 * ?")
	public int findCompletedBoards() {
		System.out.println("삭제작업 실행중");
		return tradeboardmapper.deleteCompletedPost();
	}

//	@Scheduled(cron = "0 0 0 1/1 * ?")
//	public void getCompletedPost() {
//		System.out.println("완료된 게시글 가져오기 실행중");
//		List<Integer> completedPost = tradeboardmapper.getCompletedPost();
//		for (Integer tradeboardId : completedPost) {
//			tradeboardmapper.updateDeletedTradePost(tradeboardId);
//		}
//	}

	public String getBadgeNameById(int badgeId) {
		return tradeboardmapper.getBadgeNameById(badgeId);
	}

	public void insertRegion(int tradeboardId, List<Integer> regions) {
		for (int region : regions) {
			HashMap<String, Integer> map = new HashMap<>();
			map.put("tradeboardId", tradeboardId);
			map.put("region", region);
			tradeboardmapper.insertRegion(map);
		}
	}

	public int getTradeboardId() {
		return tradeboardmapper.getTradeboardId();
	}

	public void deleteTraderegion(int tradeboardId) {
		tradeboardmapper.deleteTraderegion(tradeboardId);
	}

	public List<Integer> getRegionList(int tradeboardId) {
		List<TraderegionDTO> regionListDTO = tradeboardmapper.getRegionList(tradeboardId);
		List<Integer> regionList = new ArrayList<>();
		for (TraderegionDTO region : regionListDTO) {
			regionList.add(region.getRegion());
		}
		return regionList;
	}

}

package com.fp.shuttlecock.recruitboard;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.fp.shuttlecock.tradeboard.PageRequestDTO;

@Service
public class RecruitboardServiceImpl implements RecruitboardService{
	@Autowired
	RecruitboardMapper recruitboardmapper;

	public RecruitboardDTO getTradePostByTradeboardId(int recruitboardId) {
		return recruitboardmapper.getTradePostByTradeboardId(recruitboardId);
	}

	public void increaseHit(int recruitboardId) {
		recruitboardmapper.increaseHit(recruitboardId);
	}

	public List<RecruitboardDTO> getPagenatedSearch(PageRequestDTO pageRequest) {
		return recruitboardmapper.getPagenatedSearch(pageRequest);
	}

	public int getTotalCount(PageRequestDTO pageRequest) {
		return recruitboardmapper.getTotalCount(pageRequest);
	}

	public boolean insertBoard(RecruitboardDTO recruitboard) {
		int result = recruitboardmapper.insertBoard(recruitboard);
		if(result == 1) {
			return true;
		}
		return false;
	}

	public boolean updateTradePost(RecruitboardDTO recruitboard) {
		int result = recruitboardmapper.updateTradePost(recruitboard);
		if(result == 1) {
			return true;
		}
		return false;
	}

	public boolean deleteTradePost(int recruitboardId) {
		int result = recruitboardmapper.deleteTradePost(recruitboardId);
		if(result == 1) {
			return true;
		}
		return false;
	}

	public void increaseWriteCount(String userId) {
		recruitboardmapper.increaseWriteCount(userId);
	}

	public boolean updateDeletedTradePost(int recruitboardId) {
		int result = recruitboardmapper.updateDeletedTradePost(recruitboardId);
		if(result == 1) {
			return true;
		}
		return false;
	}

//	@Scheduled(cron="0 0 0 1/1 * ?")
//	public void getCompletedPost() {
//		System.out.println("완료된 게시글 가져오기 실행중");
//		List<Integer> completedPost = recruitboardmapper.getCompletedPost();
//		for(Integer recruitboardId : completedPost) {
//			recruitboardmapper.updateDeletedTradePost(recruitboardId);
//		}
//	}
	
	@Scheduled(cron = "0 0 0 1/1 * ?")
	public int findCompletedBoards() {
		System.out.println("삭제작업 실행중");
		return recruitboardmapper.deleteCompletedPost();
	}
	
	public void setPostCompleted(int recruitboardId) {
		recruitboardmapper.setPostCompleted(recruitboardId);
	}
}

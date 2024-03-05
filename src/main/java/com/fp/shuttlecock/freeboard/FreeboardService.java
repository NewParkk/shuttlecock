package com.fp.shuttlecock.freeboard;

import java.util.List;

import com.fp.shuttlecock.util.PageVO;

public interface FreeboardService {

	// 글 등록
	void insertFreeboard(FreeboardDTO dto);
	
	// 글 목록
	List<FreeboardDTO> getFreeboard(PageVO vo);
	
	// 글 상세보기
	FreeboardDTO freeDetail(int freeboardId);
	
	int getTotal(PageVO vo);
	
	void hit(int freeboardId);
	
	void comCNT(int freeboardId);
	
	// 좋아요 누른 여부 체크
	int findLike(int boardId, String userId);
	
	// 좋아요
	void likeUp(int boardId, String userId, int likeType);
	
	// 좋아요 취소
	void likeDown(int boardId, String userId, int likeType);
	
	int getLike(int boardId, int likeType);
	
	void deleteFree(int freeboradId);
	
	void updateFree(FreeboardDTO dto);

	
	
	
	
	
	
	
	
	
	
}

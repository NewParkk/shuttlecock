package com.fp.shuttlecock.freeboard;

import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fp.shuttlecock.util.PageVO;

public interface FreeboardService {

	// 글 등록
	int insertFreeboard(FreeboardDTO dto);
	
	// 글 목록
	List<FreeboardDTO> getFreeboard(PageVO vo);
	
	// 글 상세보기
	FreeboardDTO freeDetail(int freeboardId);
	
	int getTotal(PageVO vo);
	
	void hit(int freeboardId);
	
	void comCNT(int freeboardId);
	
	void deleteFree(int freeboradId);
	
	void updateFree(FreeboardDTO dto);
	
//	boolean updateFreePost(FreeboardDTO freeboard);
	
	FreeboardDTO getFreeboardByFreeboardId(int freeboardId);

	
	
	
	
	
	
	
	
	
	
}
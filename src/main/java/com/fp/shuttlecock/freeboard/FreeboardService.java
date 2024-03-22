package com.fp.shuttlecock.freeboard;

import java.text.ParseException;
import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fp.shuttlecock.util.PageVO;

public interface FreeboardService {

	// 글 등록
	boolean insertFreeboard(FreeboardDTO dto);
	
	// 글 목록
	List<FreeboardDTO> getFreeboard(PageVO vo);
	
	List<FreeboardDTO> get5FreePosts() throws ParseException;
	
	int getTotal(PageVO vo);
	
	void hit(int freeboardId);
	
	void comCNT(int freeboardId);
	
	boolean deleteFree(int freeboardId);

	void increaseWriteCount(String userId);

	boolean updateDeletedFreePost(int freeboardId);
	
	boolean updateFreePost(FreeboardDTO freeboard);

	FreeboardDTO getFreePostByFreeboardId(int freeboardId);


	
	
	
	
	
	
	
	
	
	
}
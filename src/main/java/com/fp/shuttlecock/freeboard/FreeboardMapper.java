package com.fp.shuttlecock.freeboard;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fp.shuttlecock.tradeboard.TradeboardDTO;
import com.fp.shuttlecock.util.PageVO;

@Mapper
public interface FreeboardMapper {
	
	FreeboardDTO getFreePostByFreeboardId(int freeboardId);
	
	List<FreeboardDTO> get5FreePosts();
	// 게시판에 글 추가
	boolean insertFreeboard(FreeboardDTO dto);

	// 게시판 목록에 뿌려줄 정보를 List로 반환
	List<FreeboardDTO> getFreeboard(PageVO vo);

	int getTotal(PageVO vo);

	void hit(int freeboardId);

	void comCNT(int freeboardId);

	int updateFreePost(FreeboardDTO freeboard);
	
	int deleteFree(int freeboradId);

	void increaseWriteCount(String userId);

	int updateDeletedFreePost(int freeboradId);
}
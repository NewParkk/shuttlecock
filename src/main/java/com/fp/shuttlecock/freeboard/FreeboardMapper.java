package com.fp.shuttlecock.freeboard;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.fp.shuttlecock.util.PageVO;

@Mapper
public interface FreeboardMapper {
	// 게시판에 글 추가
	void insertFreeboard(FreeboardDTO dto);

	// 게시판 목록에 뿌려줄 정보를 List로 반환
	List<FreeboardDTO> getFreeboard(PageVO vo);

	// 상세 글보기에 보여줄 정보를 dto 형태로 반환
	FreeboardDTO freeDetail(int freeboardId);

	int getTotal(PageVO vo);

	void hit(int freeboardId);

	void comCNT(int freeboardId);

	int findLike(Map<String, Object> map);

	void likeUp(Map<String, Object> map);

	void likeDown(Map<String, Object> map);

	int getLike(Map<String, Object> map);

	void deleteFree(int freeboradId);

	void updateFree(FreeboardDTO dto);


}

package com.fp.shuttlecock.freeboard;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fp.shuttlecock.util.PageVO;

@Service
public class FreeboardServiceImpl implements FreeboardService{
	
	@Autowired
	private FreeboardMapper mapper;

	@Override
	public void insertFreeboard(FreeboardDTO dto) {
		mapper.insertFreeboard(dto);
	}

	@Override
	public List<FreeboardDTO> getFreeboard(PageVO vo) {
		
		return mapper.getFreeboard(vo);
	}

	@Override
	public FreeboardDTO freeDetail(int freeboardId) {
		
		return mapper.freeDetail(freeboardId);
	}

	@Override
	public int getTotal(PageVO vo) {
		return mapper.getTotal(vo);
	}

	@Override
	public void hit(int freeboardId) {
		mapper.hit(freeboardId);		
	}

	@Override
	public void comCNT(int freeboardId) {
		mapper.comCNT(freeboardId);		
	}

	@Override
	public int findLike(int boardId, String userId) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("boardId", boardId);
		map.put("userId", userId);
		return mapper.findLike(map);
	}

	@Override
	public void likeUp(int boardId, String userId, int likeType) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("boardId", boardId);
		map.put("userId", userId);
		map.put("likeType", likeType);
		mapper.likeUp(map);
	}

	@Override
	public void likeDown(int boardId, String userId, int likeType) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("boardId", boardId);
		map.put("userId", userId);
		map.put("likeType", likeType);
		mapper.likeDown(map);
	}

	@Override
	public int getLike(int boardId, int likeType) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("boardId", boardId);
		map.put("likeType", likeType);
		return mapper.getLike(map);
	}

	@Override
	public void deleteFree(int freeboradId) {
		mapper.deleteFree(freeboradId);		
	}

	@Override
	public void updateFree(FreeboardDTO dto) {
		mapper.updateFree(dto);		
	}
	
}

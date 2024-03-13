package com.fp.shuttlecock.freeboard;


import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fp.shuttlecock.tradeboard.TradeboardDTO;
import com.fp.shuttlecock.util.PageVO;

@Service
public class FreeboardServiceImpl implements FreeboardService{
	
	@Autowired
	private FreeboardMapper mapper;
	

	@Override
	public int insertFreeboard(FreeboardDTO dto){
		
        
		return mapper.insertFreeboard(dto);
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

//	@Override
//	public int findLike(int freeboardId, String userId) {
//		Map<String,Object> map = new HashMap<String,Object>();
//		map.put("freeboardId", freeboardId);
//		map.put("userId", userId);
//		return mapper.findLike(map);
//	}
//
//	@Override
//	public void likeUp(int freeboardId, String userId, int likeType) {
//		Map<String,Object> map = new HashMap<String,Object>();
//		map.put("freeboardId", freeboardId);
//		map.put("userId", userId);
//		map.put("likeType", likeType);
//		mapper.likeUp(map);
//	}
//
//	@Override
//	public void likeDown(int freeboardId, String userId, int likeType) {
//		Map<String,Object> map = new HashMap<String,Object>();
//		map.put("freeboardId", freeboardId);
//		map.put("userId", userId);
//		map.put("likeType", likeType);
//		mapper.likeDown(map);
//	}
//
//	@Override
//	public int getLike(int freeboardId, int likeType) {
//		Map<String,Object> map = new HashMap<String,Object>();
//		map.put("freeboardId", freeboardId);
//		map.put("likeType", likeType);
//		return mapper.getLike(map);
//	}

	@Override
	public void deleteFree(int freeboradId) {
		mapper.deleteFree(freeboradId);		
	}

	@Override
	public void updateFree(FreeboardDTO dto) {
		mapper.updateFree(dto);		
	}
	
//	public boolean updateFreePost(FreeboardDTO freeboard) {
//		int result = mapper.updateFreePost(freeboard);
//		if(result == 1) {
//			return true;
//		}
//		return false;
//	}

	@Override
	public FreeboardDTO getFreeboardByFreeboardId(int freeboardId) {
		return mapper.getFreeboardByFreeboardId(freeboardId);
	}

	
}
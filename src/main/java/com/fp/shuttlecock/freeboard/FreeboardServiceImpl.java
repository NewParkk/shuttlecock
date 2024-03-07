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

import com.fp.shuttlecock.util.FileUtils;
import com.fp.shuttlecock.util.PageVO;

@Service
public class FreeboardServiceImpl implements FreeboardService{
	
	@Autowired
	private FreeboardMapper mapper;
	

	@Override
	public int insertFreeboard(FreeboardDTO dto){
//		// 이미지 파일 업로드 처리 시작
//        String projectPath = System.getProperty("user.dir") // 프로젝트 경로를 가져옴
//                + "\\src\\main\\webapp\\resources\\static\\files"; // 파일이 저장될 폴더의 경로
//
//        UUID uuid = UUID.randomUUID(); // 랜덤으로 식별자를 생성
//
//        String fileName = uuid + "_" + file.getOriginalFilename(); // UUID와 파일이름을 포함된 파일 이름으로 저장
//
//        File saveFile = new File(projectPath, fileName); // projectPath는 위에서 작성한 경로, name은 전달받을 이름
//
//        file.transferTo(saveFile);
//
//        dto.setFilename(fileName);
//        dto.setUploadpath("/files/" + fileName); // static 아래부분의 파일 경로로만으로도 접근이 가능
//        // 파일 업로드 처리 끝
		
        
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

	@Override
	public int findLike(int freeboardId, String userId) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("freeboardId", freeboardId);
		map.put("userId", userId);
		return mapper.findLike(map);
	}

	@Override
	public void likeUp(int freeboardId, String userId, int likeType) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("freeboardId", freeboardId);
		map.put("userId", userId);
		map.put("likeType", likeType);
		mapper.likeUp(map);
	}

	@Override
	public void likeDown(int freeboardId, String userId, int likeType) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("freeboardId", freeboardId);
		map.put("userId", userId);
		map.put("likeType", likeType);
		mapper.likeDown(map);
	}

	@Override
	public int getLike(int freeboardId, int likeType) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("freeboardId", freeboardId);
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

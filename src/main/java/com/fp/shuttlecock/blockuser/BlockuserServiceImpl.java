package com.fp.shuttlecock.blockuser;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fp.shuttlecock.tradeboard.PageRequestDTO;

@Service
public class BlockuserServiceImpl implements BlockuserService{
	@Autowired
	BlockuserMapper blockuserMapper;

	public void insertBlockuser(BlockuserDTO blockuser) {
		blockuserMapper.insertBlockuser(blockuser);
	}
	
	public void deleteBlockuser(BlockuserDTO blockuser) {
		blockuserMapper.deleteBlockuser(blockuser);
	}

	public List<BlockuserDTO> getBlockedUserList(PageRequestDTO pagerequest) {
		List<BlockuserDTO> blockuser = blockuserMapper.getBlockedUserList(pagerequest);
		return blockuser;
	}

	public int getTotalCount(PageRequestDTO pagerequest) {
		return blockuserMapper.getTotalCount(pagerequest);
	}
	
	
}

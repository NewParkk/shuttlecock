package com.fp.shuttlecock.blockuser;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BlockuserServiceImpl {
	@Autowired
	BlockuserMapper blockuserMapper;

	public void insertBlockuser(BlockuserDTO blockuser) {
		blockuserMapper.insertBlockuser(blockuser);
	}
	
	public List<BlockuserDTO> getBlockedUserList(String userId) {
		List<BlockuserDTO> blockuser = blockuserMapper.getBlockedUserList(userId);
		return blockuser;
	}

	public void deleteBlockuser(BlockuserDTO blockuser) {
		blockuserMapper.deleteBlockuser(blockuser);
	}
	
	
}

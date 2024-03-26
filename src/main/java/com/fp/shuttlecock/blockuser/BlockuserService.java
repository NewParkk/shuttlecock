package com.fp.shuttlecock.blockuser;

import java.util.List;

import com.fp.shuttlecock.tradeboard.PageRequestDTO;

public interface BlockuserService {
	void insertBlockuser(BlockuserDTO blockuser);
	
	void deleteBlockuser(BlockuserDTO blockuser);
	
	List<BlockuserDTO> getBlockedUserList(PageRequestDTO pagerequest);
	
	int getTotalCount(PageRequestDTO pagerequest);
}

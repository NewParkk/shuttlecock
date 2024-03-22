package com.fp.shuttlecock.blockuser;

import java.util.List;

import com.fp.shuttlecock.tradeboard.PageRequestDTO;

public interface BlockuserMapper {

	void insertBlockuser(BlockuserDTO blockuser);

	List<BlockuserDTO> getBlockedUserList(String userId);

	void deleteBlockuser(BlockuserDTO blockuser);

	List<BlockuserDTO> getBlockedUserList(PageRequestDTO pagerequest);

	int getTotalCount(PageRequestDTO pagerequest);
	
}

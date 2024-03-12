package com.fp.shuttlecock.blockuser;

import java.util.List;

public interface BlockuserMapper {

	void insertBlockuser(BlockuserDTO blockuser);

	List<BlockuserDTO> getBlockedUserList(String userId);

	void deleteBlockuser(BlockuserDTO blockuser);
	
}

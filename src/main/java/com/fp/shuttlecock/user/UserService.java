package com.fp.shuttlecock.user;

public interface UserService {

	UserDTO getLoginUser(String userId, String pw);
	
	UserDTO getUserByUserId(String userId);

	boolean getJoinUser(UserDTO userDTO);
	
	boolean isCheckId(String userId);
	
	UserDTO findUserId(UserDTO userDTO);

}

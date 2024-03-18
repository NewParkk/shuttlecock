package com.fp.shuttlecock.user;

import java.util.List;

public interface UserService {

	UserDTO getLoginUser(String userId, String pw);
	
	UserDTO getUserByUserId(String userId);

	boolean getJoinUser(UserDTO userDTO);
	
	boolean isCheckId(String userId);
	
	UserDTO findUserId(UserDTO userDTO);

	boolean isCheckEmail(String userEmail);
	
	boolean isExistUser(String userId, String userEmail);

	List<UserDTO> getAllUsers();
	
	String sendEmail(String userEmail);

	boolean changePassword(String userId, String newPw);
}

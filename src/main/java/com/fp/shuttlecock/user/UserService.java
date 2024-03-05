package com.fp.shuttlecock.user;

public interface UserService {

	UserDTO getLoginUser(String userId, String pw);

	int getJoinUser(UserDTO userDTO);

}

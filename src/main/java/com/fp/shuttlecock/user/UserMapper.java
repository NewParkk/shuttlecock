package com.fp.shuttlecock.user;

import java.util.Map;

public interface UserMapper {

	//로그인
	public UserDTO getLoginUser(Map<String, String> map);

	//회원가입
	public int getJoinUser(UserDTO userDTO);

}

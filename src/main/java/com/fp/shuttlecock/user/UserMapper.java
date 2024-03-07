package com.fp.shuttlecock.user;

import org.apache.ibatis.annotations.Param;

public interface UserMapper {

	//로그인
	public UserDTO getLoginUser(@Param("userId") String userId,@Param("pw") String pw);

	//회원가입
	public UserDTO getUserByUserId(String userId);
	
	public int getJoinUser(UserDTO userDTO);

	public int CheckIdUser(String userId);


}

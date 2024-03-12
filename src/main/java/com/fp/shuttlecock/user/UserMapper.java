package com.fp.shuttlecock.user;

import org.apache.ibatis.annotations.Param;

public interface UserMapper {

	//로그인
	public UserDTO getLoginUser(@Param("userId") String userId,@Param("pw") String pw);

	//회원가입전 아이디 체크
	public UserDTO getUserByUserId(String userId);
	
	//회원가입
	public int getJoinUser(UserDTO userDTO);

	//아이디중복체크
	public int CheckIdUser(String userId);

	//아이디찾기
	public UserDTO findUserId(UserDTO userDTO);


}

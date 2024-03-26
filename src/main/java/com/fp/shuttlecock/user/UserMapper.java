package com.fp.shuttlecock.user;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface UserMapper {

	//로그인 + 회원가입전 아이디 체크
	public UserDTO getLoginUser(@Param("userId") String userId);

	//회원가입전 아이디 체크
	/* public UserDTO getUserByUserId(String userId); */
	
	//회원가입
	public int getJoinUser(UserDTO userDTO);

	//아이디중복체크
	public int CheckIdUser(String userId);

	//아이디찾기
	public UserDTO findUserId(UserDTO userDTO);

	//이메일 중복체크
	public int isCheckEmail(String userEmail);

	//비밀번호 찾기 - 해당 회원의 정보가 있는지 확인
	public boolean isExistUser(@Param("userId") String userId, @Param("userEmail") String userEmail);

	public List<UserDTO> getAllUsers();
	
	//새 비밀번호로 변경
	public boolean changePassword(UserDTO userDTO);


}

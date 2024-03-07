package com.fp.shuttlecock.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
	UserMapper userMapper;
	
	//로그인
	public UserDTO getLoginUser(String userId, String pw) {
		
		UserDTO user = null;
		user = userMapper.getLoginUser(userId, pw);
		
		return user;
	}

	//회원가입
	public UserDTO getUserByUserId(String userId) {
		UserDTO user = null;
		user = userMapper.getUserByUserId(userId);
		return user;
	}
	
	public boolean getJoinUser(UserDTO userDTO) {
		boolean result = false;
		
		int res = userMapper.getJoinUser(userDTO);
		if (res != 0) {
			result = true;
		}else {
			new Exception("회원가입 실패");
		}
		return result;
	}

	public boolean isCheckId(String userId) {
		boolean result = false;
		int count = userMapper.CheckIdUser(userId);
//		System.out.println(count); //확인용
		
		if (count == 1) { 
	        result = false; 
	    } else if (count == 0) {
	        result = true; 
	    } else {
			new Exception("아이디 체크 실패");
		}

		return result;
	}


}

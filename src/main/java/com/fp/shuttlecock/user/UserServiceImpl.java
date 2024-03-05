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
		
		Map<String, String> map= new HashMap<String, String>();
		map.put("userId", userId);
		map.put("pw", pw);
		
		return userMapper.getLoginUser(map);
	}

	//회원가입
	public int getJoinUser(UserDTO userDTO) {
		return userMapper.getJoinUser(userDTO);
	}

}

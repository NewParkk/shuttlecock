package com.fp.shuttlecock.user;


import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
	private UserMapper userMapper;

	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	//로그인
	public UserDTO getLoginUser(String userId, String pw) {
		
		UserDTO user = null;
		
		//DB에 저장된 화원정보 조회
		UserDTO dbUser = userMapper.getLoginUser(userId);
		
		//입력받은 비밀번호를 암호화하여 DB에 저장된 비밀번호(암호화)와 비교
		if (passwordEncoder.matches(pw, dbUser.getPw())) {
			user = dbUser;
		}
		
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
		
		//비밀번호 암호화
		String encryptedPw = passwordEncoder.encode(userDTO.getPw());
		userDTO.setPw(encryptedPw);
		System.out.println(encryptedPw);
		
		int res = userMapper.getJoinUser(userDTO);
		if (res != 0) {
			result = true;
		}else {
			new Exception("회원가입 실패");
		}
		return result;
	}

	//아이디 중복체크
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

	//아이디 찾기
	public UserDTO findUserId(UserDTO userDTO) {
		
		UserDTO user = null;
		user = userMapper.findUserId(userDTO);
		
		return user;
	}
	
	
	//이메일 중복체크
	public boolean isCheckEmail(String userEmail) {
		boolean result = false;
		int count = userMapper.isCheckEmail(userEmail);
//		System.out.println(count); //확인용
		
		if (count == 1) { 
	        result = false; 
	    } else if (count == 0) {
	        result = true; 
	    } else {
			new Exception("email 체크 실패");
		}

		return result;
	}

	//회원의 id, email이 있는지 확인
	public boolean isExistUser(String userId, String userEmail) {		
	    return userMapper.isExistUser(userId, userEmail);
	}

	public String sendEmail(String email) {
		
		return null;
	}

	@Override
	public List<UserDTO> getAllUsers() {
		return userMapper.getAllUsers();
	}

	
	
	
}

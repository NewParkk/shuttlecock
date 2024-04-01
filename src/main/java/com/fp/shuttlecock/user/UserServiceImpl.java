package com.fp.shuttlecock.user;


import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
	private UserMapper userMapper;

	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
    private JavaMailSender javaMailSender;

	//로그인
	public UserDTO getLoginUser(String userId, String pw) {
		
		UserDTO user = null;
		System.out.println("pw : " + pw);
		//DB에 저장된 화원정보 조회
		UserDTO dbUser = userMapper.getLoginUser(userId);
		
		//DB에 저장된 아이디가 없을 경우
		if (dbUser == null) {
	        return null;
	    }
		System.out.println(pw.equals(dbUser.getPw()));
		System.out.println("dbUser.getPw() : " + dbUser.getPw());
		//입력받은 비밀번호를 암호화하여 DB에 저장된 비밀번호(암호화)와 비교
		if (passwordEncoder.matches(pw, dbUser.getPw())) {
			
			user = dbUser;
		}
		
		return user;
	}

	//회원가입
	public UserDTO getUserByUserId(String userId) {
		UserDTO user = null;
		//user = userMapper.getUserByUserId(userId); 
		user = userMapper.getLoginUser(userId);
		return user;
	}
	
	public boolean getJoinUser(UserDTO userDTO) {
		boolean result = false;
		
		//이름에 admin이 들어가면 관리자로 부여!
		if (userDTO.getUsername().contains("admin")) {
	        userDTO.setAdmin(true);
	    } else {
	        userDTO.setAdmin(false);
	    }
		
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

	//회원의 id, email이 존재하는지 확인
	public boolean isExistUser(String userId, String userEmail) {		
	    return userMapper.isExistUser(userId, userEmail);
	}

	//인증번호 저장
	public String sendEmail(String userEmail) {		
		String sendEmailNum = randomNum();
		try {
			sendHtmlEmail(userEmail, sendEmailNum);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return sendEmailNum;
	}
	
	// MimeMessageHelper를 사용하여 HTML 형식의 이메일 작성
	private void sendHtmlEmail(String userEmail, String sendEmailNum) throws MessagingException {
		MimeMessage message = javaMailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		
		helper.setTo(userEmail);
		helper.setSubject("[shuttle-cock] 인증번호 발송");
		String htmlContent = "<p>안녕하세요. shuttl-cock입니다.</p><p>회원님의 인증번호는 <strong>" + sendEmailNum + "</strong> 입니다.</p>";
		helper.setText(htmlContent, true);
		
		//이메일 발송
		javaMailSender.send(message);
	}
	
	//6자리 랜덤 숫자 생성하기
	private String randomNum() {
		Random random = new Random();
		int code = 100000 + random.nextInt(900000);
		return String.valueOf(code);
	}
	
	//userId로 암호화된 새 비밀번호로 변경하기
	public boolean changePassword(String userId, String newPw) {
		UserDTO userDTO = new UserDTO(); 
		userDTO.setUserId(userId);
		String encryptedNewPw = passwordEncoder.encode(newPw);
		userDTO.setPw(encryptedNewPw);
		return userMapper.changePassword(userDTO);
	}

	@Override
	public List<UserDTO> getAllUsers() {
		return userMapper.getAllUsers();
	}
	
	
}

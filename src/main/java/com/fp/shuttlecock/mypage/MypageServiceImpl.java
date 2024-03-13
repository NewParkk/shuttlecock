package com.fp.shuttlecock.mypage;

import java.io.File;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class MypageServiceImpl {

	@Autowired
	MypageMapper mapper;

	public UserDTO getMypage(String userId) {
		return mapper.getMypage(userId);
	}

	public List<CalendarDTO> getCalendar(String userId) {
		return mapper.getCalendar(userId);
	}

	public boolean insertCalendar(CalendarDTO newCalendar) {
		boolean result = false;
		int res = mapper.insertCalendar(newCalendar);
		if (res != 0) {
			result = true;
		}

		return result;
	}

	public boolean deleteCalendar(CalendarDTO calendarId) {
		boolean result = false;
		int res = mapper.deleteCalendar(calendarId);
		if (res != 0) {
			result = true;
		}

		return result;
	}
	
	public boolean updateUser(UserDTO user) {
		boolean result = false;
		int res = mapper.updateUser(user);
		if (res != 0) {
			result = true;
		}

		return result;
	}

	public boolean deleteUser(String userId) {
		boolean result = false;
		int res = mapper.deleteUser(userId);
		if (res != 0) {
			result = true;
		}

		return result;
	}

	public List<LeagueboardDTO> getLeagueboard(String userId) {
		return mapper.getLeagueboard(userId);
	}

	public List<FreeboardDTO> getFreeboard(String userId) {
		return mapper.getFreeboard(userId);
	}

	public List<TradeboardDTO> getTradeboard(String userId) {
		return mapper.getTradeboard(userId);
	}

	public List<RecruitboardDTO> getRecruitBoard(String userId) {
		return mapper.getRecruitBoard(userId);
	}

	public List<CommentsDTO> getComment(String userId) {
		return mapper.getComment(userId);
	}

	public List<HashMap<String, Object>> getLike(String userId) {
		return mapper.getLike(userId);
	}

	public boolean insertImage(MultipartFile file, String userId) {
		boolean result = false;
		
		String name = file.getOriginalFilename();
		String currentDir = System.getProperty("user.dir");
		String path = currentDir;
		UserDTO user = UserDTO.builder()
								.userId(userId)
								.userImageName(name)
								.userImagePath(path)
								.build();
		System.out.println(currentDir);
		int res = mapper.insertImage(user);
		if (res != 0) {
			result = true;
		}
		return result;
	}
	public class CurrentDirectory {    public static void main(String[] args) {                String currentDir = System.getProperty("user.dir");         System.out.println(currentDir);    }}

}

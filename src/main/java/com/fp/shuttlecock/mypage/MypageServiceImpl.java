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

	public CalendarDTO getCalendarByDate(Date date) {
		return mapper.getCalendarByDate(date);
	}

	public boolean updateCalendar(CalendarDTO newCalendar) {
		boolean result = false;
		int res = mapper.updateCalendar(newCalendar);
		if (res != 0) {
			result = true;
		}
		return result;
	}

	public boolean deleteCalendar(String userId) {
		boolean result = false;
		int res = mapper.deleteCalendar(userId);
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

	/*
	 * public List<LikesDTO> getLike(String userId) {
	 *  return mapper.getLike(userId);
	 * }
	 */
	public List<HashMap<String, Object>> getLike(String userId) {
		return mapper.getLike(userId);
	}

	public boolean insertImage(MultipartFile file, String userId) {
		boolean result = false;
		
		String Image = "C:\\multi\\imege";
		UserDTO user = UserDTO.builder()
								.userId(userId)
								.userImage(Image)
								.build();

		int res = mapper.insertImage(user);
		if (res != 0) {
			result = true;
		}
		return result;
	}


}

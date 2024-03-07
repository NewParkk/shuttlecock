package com.fp.shuttlecock.mypage;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fp.shuttlecock.admin.UserDTO;

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
		if(res != 0) {
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

	public List<RecruitboardDTO> getRecrtitboard(String userId) {
		return mapper.getRecrtitboard(userId);
	}

	public List<CommentsDTO> getComment(String userId) {
		return mapper.getComment(userId);
	}

	public List<LikesDTO> getLike(String userId) {
		return mapper.getLike(userId);
	}


}

package com.fp.shuttlecock.mypage;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fp.shuttlecock.comments.CommentsDTO;
import com.fp.shuttlecock.freeboard.FreeboardDTO;
import com.fp.shuttlecock.leagueboard.LeagueboardDTO;
import com.fp.shuttlecock.recruitboard.RecruitboardDTO;
import com.fp.shuttlecock.tradeboard.TradeboardDTO;
import com.fp.shuttlecock.user.UserDTO;

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

	public boolean insertImage(UserDTO user) {
		boolean result = false;

		int res = mapper.insertImage(user);
		if (res != 0) {
			result = true;
		}
		return result;
	}

	/*
	 * public List<HashMap<String, Object>> getBoard(String userId) { return
	 * mapper.getBoard(userId); }
	 */

	public List<HashMap<String, Object>> getBoard(PageRequestDTO pageRequest) {
		return mapper.getBoard(pageRequest);
	}

	public List<RecruitboardDTO> getRecruitBoardLike(String userId) {
		return mapper.getRecruitBoardLike(userId);
	}

	public List<TradeboardDTO> getTradeboardLike(String userId) {
		return mapper.getTradeboardLike(userId);
	}

	public List<FreeboardDTO> getFreeboardLike(String userId) {
		return mapper.getFreeboardLike(userId);
	}

	public int getTotalCount(PageRequestDTO pageRequest) {
		return mapper.getTotalCount(pageRequest);
	}




}

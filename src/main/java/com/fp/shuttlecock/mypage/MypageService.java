package com.fp.shuttlecock.mypage;

import java.sql.Date;
import java.util.List;

import com.fp.shuttlecock.admin.UserDTO;

public interface MypageService {

	UserDTO getMypage(String userId);

	List<CalendarDTO> getCalendar(String userId);

	int insertCalendar(CalendarDTO newCalendar);

	int deleteCalendar(String userId);

	int updateUser(UserDTO user);

	CalendarDTO getCalendarByDate(Date date);

	int updateCalendar(CalendarDTO newCalendar);

	int deleteUser(String userId);

	List<LeagueboardDTO> getLeagueboard(String userId);

	List<FreeboardDTO> getFreeboard(String userId);

	List<TradeboardDTO> getTradeboard(String userId);

	List<RecruitboardDTO> getRecrtitboard(String userId);

	List<CommentsDTO> getComment(String userId);

	List<LikesDTO> getLike(String userId);
}

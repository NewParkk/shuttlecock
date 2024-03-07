package com.fp.shuttlecock.mypage;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fp.shuttlecock.admin.UserDTO;

@Mapper
public interface MypageMapper {

	public UserDTO getMypage(String userId);

	public List<CalendarDTO> getCalendar(String userId);

	public int insertCalendar(CalendarDTO newCalendar);

	public int deleteCalendar(String userId);

	public int updateUser(UserDTO user);

	public CalendarDTO getCalendarByDate(Date date);

	public int updateCalendar(CalendarDTO newCalendar);

	public int deleteUser(String userId);

	public List<LeagueboardDTO> getLeagueboard(String userId);

	public List<FreeboardDTO> getFreeboard(String userId);

	public List<TradeboardDTO> getTradeboard(String userId);

	public List<RecruitboardDTO> getRecrtitboard(String userId);

	public List<CommentsDTO> getComment(String userId);

	public List<LikesDTO> getLike(String userId);


}

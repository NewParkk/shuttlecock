package com.fp.shuttlecock.mypage;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MypageMapper {

	public UserDTO getMypage(String userId);

	public List<CalendarDTO> getCalendar(String userId);

	public int insertCalendar(CalendarDTO newCalendar);

	public int deleteCalendar(CalendarDTO calendarId);

	public int updateUser(UserDTO user);

	public int deleteUser(String userId);

	public List<LeagueboardDTO> getLeagueboard(String userId);

	public List<FreeboardDTO> getFreeboard(String userId);

	public List<TradeboardDTO> getTradeboard(String userId);

	public List<RecruitboardDTO> getRecruitBoard(String userId);

	public List<CommentsDTO> getComment(String userId);

	public List<HashMap<String, Object>> getLike(String userId);

	public int insertImage(UserDTO user);

//	public List<HashMap<String, Object>> getBoard(String userId);

	public List<HashMap<String, Object>> getBoard(PageRequestDTO pageRequest);

	public List<RecruitboardDTO> getRecruitBoardLike(String userId);

	public List<FreeboardDTO> getFreeboardLike(String userId);

	public List<TradeboardDTO> getTradeboardLike(String userId);

	public int getTotalCount(PageRequestDTO pageRequest);

}

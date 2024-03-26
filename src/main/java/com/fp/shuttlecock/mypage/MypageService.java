package com.fp.shuttlecock.mypage;

import java.util.List;

import com.fp.shuttlecock.comments.CommentsDTO;
import com.fp.shuttlecock.freeboard.FreeboardDTO;
import com.fp.shuttlecock.leagueboard.LeagueboardDTO;
import com.fp.shuttlecock.likes.LikesDTO;
import com.fp.shuttlecock.recruitboard.RecruitboardDTO;
import com.fp.shuttlecock.tradeboard.TradeboardDTO;
import com.fp.shuttlecock.user.UserDTO;

public interface MypageService {

	UserDTO getMypage(String userId);

	List<CalendarDTO> getCalendar(String userId);

	int insertCalendar(CalendarDTO newCalendar);

	int deleteCalendar(String userId);

	int updateUser(UserDTO user);

	int deleteUser(String userId);

	List<LeagueboardDTO> getLeagueboard(String userId);

	List<FreeboardDTO> getFreeboard(String userId);

	List<TradeboardDTO> getTradeboard(String userId);

	List<RecruitboardDTO> getRecrtitboard(String userId);

	List<CommentsDTO> getComment(String userId);

	List<LikesDTO> getLike(String userId);
	
	int insertImage(UserDTO user);
}

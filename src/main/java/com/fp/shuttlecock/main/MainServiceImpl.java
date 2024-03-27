package com.fp.shuttlecock.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.fp.shuttlecock.freeboard.FreeboardDTO;
import com.fp.shuttlecock.leagueboard.LeagueboardDTO;
import com.fp.shuttlecock.user.UserDTO;

@Primary
@Service
public class MainServiceImpl implements MainService{
	
	@Autowired
	MainMapper mainMapper;

	@Override
	public int updateCommunityBadge(UserDTO user) {
		return mainMapper.updateCommunityBadge(user);
	}

	@Override
	public List<BadgeDTO> getBadgeList(int badgeType) {
		return mainMapper.getBadgeList(badgeType);
	}

	@Override
	public void updateUserLeagueGrade() {
		mainMapper.updateUserLeagueGrade();
	}

	
	
	
}

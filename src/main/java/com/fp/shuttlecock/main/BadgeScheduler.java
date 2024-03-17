package com.fp.shuttlecock.main;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.fp.shuttlecock.leagueboard.LeagueboardRankingServiceImpl;
import com.fp.shuttlecock.user.UserDTO;
import com.fp.shuttlecock.user.UserServiceImpl;

@Component
public class BadgeScheduler {
	
	@Autowired
	private MainService mainService;
	
	@Autowired
	private UserServiceImpl userService;
	
	@Autowired
	private LeagueboardRankingServiceImpl leagueboardRankingService;
	
	@Scheduled(cron  = "0 */1 * * * *")
	public void badgeupdate() 
	{
		// 뱃지 update
		final int badgeType  = 0; 
		List<BadgeDTO> badgeList = mainService.getBadgeList(badgeType);
		List<UserDTO> userList = userService.getAllUsers();
		List<UserDTO> updateUserList = new ArrayList<UserDTO>();
			
		for (UserDTO user : userList) 
		{
			int badgeId = 1;
			
			for (BadgeDTO badge : badgeList) 
			{
				// 현재점수가 뱃지의 minWriteCount이상이면
				if (user.getWriteCount() >= badge.getMinWriteCount()) 
				{
					badgeId = badge.getBadgeId();
				}
			}
			// 현재 뱃지와 동일하지 않을때 updateList에 추가
			if (user.getBadgeId() != badgeId) 
			{
				user.setBadgeId(badgeId);
				updateUserList.add(user);
			}
		}
		
		//badgeId update
		for (UserDTO user : updateUserList) {
			mainService.updateCommunityBadge(user);
		}
		LocalDateTime currentTime = LocalDateTime.now().withSecond(0).withNano(0);
		System.out.println(currentTime + " badgeId 갱신");
	}
	
	@Scheduled(cron  = "0 */1 * * * *")
	public void LeagueBadgeUpdate() {
		final int badgeType  = 1;
		List<BadgeDTO> badgeList = mainService.getBadgeList(badgeType);
		
		// badge테이블의 badgeId값 1위 : 6, 2위 : 7, 3위 : 8
		int LeaguebadgeId = 6;
		boolean top3 = false;
		// 리그 뱃지 update
		List<UserDTO> rankingList = leagueboardRankingService.getRankedList(top3);
		
		
		
		for (int i = 0; i < rankingList.size(); i++) {
			top3 = true;
			List<UserDTO> BadgeUpdateUsers = leagueboardRankingService.getRankedList(top3);
			System.out.println((BadgeUpdateUsers.get(i).getUserLeagueGrade()) +"등 유저Id : " + BadgeUpdateUsers.get(i).getUserId());
			
		}
		
		//모든 유저 rank 최신화
		mainService.updateUserLeagueGrade();
		
		LocalDateTime currentTime = LocalDateTime.now().withSecond(0).withNano(0);
		System.out.println(currentTime + " UserLeagueGrade 갱신");
	}
	
	
}

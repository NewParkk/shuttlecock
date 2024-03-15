package com.fp.shuttlecock.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class BadgeScheduler {
	
	@Autowired
	MainService mainService;
	
	@Scheduled(cron  = "0 0 0 * * ?")
	public void badgeupdate() {
		
		//commnity badge update
//		mainService.updateCommunityBadge();
		
		
	}
	
	
	
}

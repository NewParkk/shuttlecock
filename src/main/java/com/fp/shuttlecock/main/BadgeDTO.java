package com.fp.shuttlecock.main;

import lombok.Data;

@Data
public class BadgeDTO {
	
	private int badgeId;
	private String badgeName;
	private String badgeImage;
	private int minWriteCount;
	private int badgeType;
	
}

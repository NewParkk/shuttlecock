package com.fp.shuttlecock.leagueboard;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class LeagueRankDTO {
	private int idx;
	private int rankId;
	private String userId;
	private int wincount;
	private int losecount;
	private String insertdate;
	private String username;
	private int badgeId;
}


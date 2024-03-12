package com.fp.shuttlecock.leagueboard;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class LeagueboardRankingDTO {
	private String userId;
	private String username;
	private int wincount;
	private int losecount;
	private int winlate;
	private double winpercentage;
	
}

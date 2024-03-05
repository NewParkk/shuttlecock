package com.fp.shuttlecock.leagueboard;

import java.sql.Date;

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
public class LeagueboardDTO {
	private int leagueboardId;
	private String title;
	private String content;
	private Date writeDate;
	private Date updateDate;
	private String winner;
	private String loser;
	
}

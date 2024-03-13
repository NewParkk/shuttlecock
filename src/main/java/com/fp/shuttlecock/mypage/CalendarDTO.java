package com.fp.shuttlecock.mypage;

import java.sql.Date;

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
public class CalendarDTO {
	private int calendarId;
	private String title;
	private Date date;
	private String userId;
}

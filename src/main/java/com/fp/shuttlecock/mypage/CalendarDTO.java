package com.fp.shuttlecock.mypage;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@Setter
@ToString
public class CalendarDTO {
	private String title;
	private Date date;
	private String user_userId;
}

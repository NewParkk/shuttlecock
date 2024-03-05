package com.fp.shuttlecock.announcement;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Announcement {
	
	private int announcementNo;
	private String title;
	private String content;
	private Date writeDate;
	private Date updateDate;
	private int hit;
	private String user_userId;
	
}

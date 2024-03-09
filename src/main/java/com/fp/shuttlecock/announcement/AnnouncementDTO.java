package com.fp.shuttlecock.announcement;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AnnouncementDTO {
	
	private int announcementNo;
	private String title;
	private String content;
	private Date regdate;
	private int hit;
	private String userId;
	
}

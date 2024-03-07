package com.fp.shuttlecock.freeboard;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class FreeboardDTO {
	private int freeboardId;
	private String title;
	private String content;
	private int like;
	private int hit;
	private Timestamp regdate;
	private int commentCount;
	private int likeCount;
	private String user_userId; // 작성자 추가
	private List<MultipartFile> files = new ArrayList<>(); //첨부파일 List
}

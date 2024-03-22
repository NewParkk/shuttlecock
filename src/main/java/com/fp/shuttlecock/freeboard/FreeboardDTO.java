package com.fp.shuttlecock.freeboard;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*
`freeboardId` INT NOT NULL AUTO_INCREMENT,
`title` VARCHAR(225) NOT NULL,
`content` VARCHAR(4000) NULL DEFAULT NULL,
`like` INT NULL DEFAULT NULL,
`hit` INT NULL DEFAULT NULL,
`uploadPath` VARCHAR(100) ,
`fileLoca` VARCHAR(100) ,
`fileName` VARCHAR(50) ,
`realFilename` VARCHAR(50) ,
`regdate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
`commentCount` INT NULL DEFAULT NULL,
`likeCount` INT NULL DEFAULT NULL,
`delete_yn` VARCHAR(45) NULL,
`userId` VARCHAR(40) NOT NULL,

*/

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
	private int deleteYN;
	private String userId; // 작성자 추가
	private String imageName;
    
    // 뱃지 이미지 위해 추가
    private int badgeId;
	private String badgeName;
}

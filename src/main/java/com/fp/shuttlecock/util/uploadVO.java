package com.fp.shuttlecock.util;

import org.springframework.web.multipart.MultipartFile;

/*
 `attachmentfileId` INT NOT NULL AUTO_INCREMENT,
  `fileName` VARCHAR(255) NULL DEFAULT NULL,
  `fileOriginalName` VARCHAR(255) NULL DEFAULT NULL,
  `filePath` VARCHAR(255) NULL DEFAULT NULL,
  `fileSize` BIGINT NULL DEFAULT NULL,
  `regdate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `isEmpty` TINYINT(1) NOT NULL,
  `freeboardId` INT NOT NULL,
  `tradeboardId` INT NOT NULL,
  `recruitboardId` INT NOT NULL,

 */
public class uploadVO {
	
	private String name;
	private MultipartFile file;

	
}
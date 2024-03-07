package com.fp.shuttlecock.attachmentfile;

import java.math.BigInteger;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FileRequest {

	private int attachmentfileId;					// 파일번호
	private int freeboard_freeboardId;				// 게시글 번호
	private int tradeboard_tradeboardId;
	private int recruitboard_recruitboardId;
	private String fileName;						// 저장파일명	
	private String fileOriginalName;				// 원본파일명
	private long fileSize;					// 파일크기

	
	@Builder
    public FileRequest(String fileOriginalName, String fileName, long fileSize) {
        this.fileOriginalName = fileOriginalName;
        this.fileName = fileName;
        this.fileSize = fileSize;
    }
	
	
}

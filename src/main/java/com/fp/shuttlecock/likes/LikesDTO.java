package com.fp.shuttlecock.likes;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;

@Data
public class LikesDTO {
	
	private int likesId;
	private String userId;
	private int bno;
	private int likesType;
	private boolean deleteYN;
	
	public LikesDTO(String userId, int bno, int likesType) {
		this.userId=userId;
		this.bno=bno;
		this.likesType=likesType;
	}
}

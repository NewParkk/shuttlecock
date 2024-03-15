package com.fp.shuttlecock.likes;

import lombok.Data;
import lombok.Getter;

@Data
public class LikesDTO {
	private int likesId;
	private String userId;
	private int bno;
	private int likesType;
	private int deleteYN;
}

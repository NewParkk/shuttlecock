package com.fp.shuttlecock.likes;

import lombok.Data;

@Data
public class LikesDTO {
	private int likesId;
	private String userId;
	private int bno;
	private int likes_type;
	private int delete_yn;
}

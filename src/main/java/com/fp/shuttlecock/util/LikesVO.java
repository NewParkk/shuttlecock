package com.fp.shuttlecock.util;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LikesVO {
	private int likesId;
	private int freeboardId;
	private String userId;
//	private int freeboardLike;
	private int likeType; // 좋아요 눌러져있는지 상태여부
}

package com.fp.shuttlecock.mypage;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class LikesDTO {
	private int likesId;
	private String userId;
	private int likesType;
	private boolean deleteYN;
	private int bno;
}

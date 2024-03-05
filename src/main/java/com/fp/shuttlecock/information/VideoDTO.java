package com.fp.shuttlecock.information;

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
public class VideoDTO {
	private int videoId; 	//영상번호
	private String title;	//제목
	private String image;	//이미지
	private String url;		//링크
}

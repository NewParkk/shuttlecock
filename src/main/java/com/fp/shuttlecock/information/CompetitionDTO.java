package com.fp.shuttlecock.information;

import java.util.Date;

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
public class CompetitionDTO {
	private int competitionId; 		//대회번호
	private String region;			//대회카테고리(지역,전국)
	private String title;			//대회이름
	private Date startDate;			//대회시작일
	private Date endDate;			//대회종료일
	private String image;			//대회이미지
	private String url;				//대회관련링크
	private Date applicationStartDate;	//접수시작일
	private Date applicationEndDate;	//접수종료일
}

package com.fp.shuttlecock.admin;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;

@Data
public class PageRequestDTO {

	  // 현재 페이지 번호
	  private int pageNum;
	
	  // 페이지당 출력할 데이터 개수
	  private int amount;

	  // 검색 카테고리
	  private String category;

	  // 검색 키워드
	  private String searchKeyword;
	  
	  public PageRequestDTO() {
	    this(1, 5);
	  }
	  
	  public PageRequestDTO(int pageNum, int amount) {
		  super();
		  this.pageNum = pageNum;
		  this.amount = amount;
	  } 
	  
	  // 추가
	  @Builder
	  public PageRequestDTO(int pageNum, int amount, String searchKeyword) {
		    super();
		    this.pageNum = pageNum;
		    this.amount = amount;
		    this.category = category;
		    this.searchKeyword = searchKeyword;
	  }
}


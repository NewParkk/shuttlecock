package com.fp.shuttlecock.util;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageVO {

	//사용자가 선택한 페이지 정보를 담을 변수.
	private int pageNum; //pageNum
	private int countPerPage; //amount
	private int pagecnt; 
    public int getPageStart() {
	        return (pageNum-1)*countPerPage;
	    }
    
    // 정렬 기준을 나타내는 변수
    private int sort;
    
    private String userId;

	//검색에 필요한 데이터를 변수로 선언.
	private String keyword; //searchKeyword
	private String condition; //category
	
	public PageVO() {
        this.pageNum = 1;
        this.countPerPage = 10;
        this.sort = 0; // 기본 정렬 기준은 최신순
    }
	

}
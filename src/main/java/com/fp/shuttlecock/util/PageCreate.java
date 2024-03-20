package com.fp.shuttlecock.util;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageCreate {

	private int pageAmount;

    // 화면 시작/종료 페이지 번호
    private int startPage, endPage;

    // 이전/다음 페이지 이동
    private boolean prev, next;

    // 실제 마지막 페이지 번호
    private int realEnd;

    // 전체 데이터 개수 db : count
    private int total;
    
    private PageVO vo;

    public PageCreate(){}

    @Builder
    public PageCreate(int total, int pageAmount, PageVO vo) {
        this.total = total;
        this.pageAmount = pageAmount;
        this.vo = vo;

        this.endPage = (int)(Math.ceil(vo.getPageNum() * 1.0 / pageAmount)) * pageAmount;
        this.startPage = endPage - (pageAmount - 1);

        realEnd = (int)(Math.ceil(total * 1.0 / vo.getCountPerPage()));

        if(endPage > realEnd){
          this.endPage = realEnd;
        }

        this.prev = this.startPage > 1;
        this.next = this.endPage < realEnd;
    }

}	
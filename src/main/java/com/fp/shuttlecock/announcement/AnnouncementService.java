package com.fp.shuttlecock.announcement;

import java.util.List;

public interface AnnouncementService {
	// 모든 게시물 조회
	List<AnnouncementDTO> getboardList();
	// 게시물 상세
	AnnouncementDTO getpostDetailbypostId(int postId);
	// 글쓰기
	void insertPost(AnnouncementDTO post);
	// 글수정
	void updatePost(AnnouncementDTO post);
	// 글삭제
	boolean deletePostbypostId(int postId);

	// 총 게시물 수
	int countPosts();
	//검색된 게시물 수
	int searchedPostCount(String query);
	// 페이지당 게시물 리스트
	List<AnnouncementDTO> getPostbyPage(int page, int postperPage);
	//검색된 페이지당 게시물 리스트
	List<AnnouncementDTO> getSearchedPostbyPage(int page, int postperPage, String query);
	//검색된 전체 게시물 리스트
	List<AnnouncementDTO> searchedPostList(String query);
	//조회수 증가
	void hit(Integer postId);
	
	
}

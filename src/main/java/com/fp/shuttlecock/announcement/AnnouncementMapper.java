package com.fp.shuttlecock.announcement;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AnnouncementMapper {

	List<AnnouncementDTO> getboardList();

	AnnouncementDTO getpostDetailbypostId(int postId);

	void insertPost(AnnouncementDTO post);

	void updatePost(AnnouncementDTO post);

	int deletePostbypostId(Integer postId);

	List<AnnouncementDTO> getSearchedPostPage(Map<String, Object> params);

	List<AnnouncementDTO> getPostbyPage(Map<String, Object> params);

	int countPosts();

	int searchedPostCount(String query);

	List<AnnouncementDTO> searchedPostList(String query);

	void hit(Integer postId);

}

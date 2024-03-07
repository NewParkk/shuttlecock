package com.fp.shuttlecock.announcement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class AnnouncementServiceImpl implements AnnouncementService{
	
	@Autowired
	AnnouncementMapper announcementMapper;
	
	@Override
	public List<AnnouncementDTO> getboardList() {
		return announcementMapper.getboardList();
	}
	
	@Override
	public AnnouncementDTO getboardDetailbypostId(int postId) {
		return announcementMapper.getpostDetailbypostId(postId);
	}
	
	@Override
	public void insertPost(AnnouncementDTO post) {
		announcementMapper.insertPost(post);
	}
	
	@Override
	public void updatePost(AnnouncementDTO post) {
		announcementMapper.updatePost(post);
	}
	
	@Override
	public void deletePostbypostId(Integer postId) {
		announcementMapper.deletePostbypostId(postId);
	}
	
	@Override
	public int countPost() {
		return announcementMapper.countPosts();
	}

	@Override
	public int searchedPostCount(String query) {
		return announcementMapper.searchedPostCount(query);
	}

	@Override
	public List<AnnouncementDTO> getPostbyPage(int page, int postperPage) {
		return getPagePosts(page, postperPage, null);
	}
	
	@Override
	public List<AnnouncementDTO> getSearchedPostbyPage(int page, int postperPage, String query) {
		return getPagePosts(page, postperPage, query);
	}

	private List<AnnouncementDTO> getPagePosts(int page, int postperPage, String query) 
	{	
		int offset = (page - 1) * postperPage;
		Map<String, Object> params = new HashMap<>();
		params.put("offset", offset);
		params.put("postperPage", postperPage);
		if (query != null)
		{
			params.put("query", query);
			return announcementMapper.getSearchedPostPage(params);
		} else {
			return announcementMapper.getPostbyPage(params);
		}	
	}

	@Override
	public List<AnnouncementDTO> searchedPostList(String query) {
		return announcementMapper.searchedPostList(query);
	}

}

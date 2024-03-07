package com.fp.shuttlecock.announcement;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestParam;





@Controller
@RequestMapping("/Announcement")
public class AnnouncementController 
{
	
	@Autowired
	AnnouncementService announcementService;
	
	@GetMapping("/main")
	public String pagination(@RequestParam(value = "page", defaultValue = "1") int page, Model model)
	{	
		int postperPage = 10;
		int totalPost = announcementService.countPost();
		int totalPage = (int) Math.ceil((double) totalPost / postperPage);
		List<AnnouncementDTO> postList = announcementService.getPostbyPage(page, postperPage);
		
		model.addAttribute("postList", postList);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPage", totalPage);
		
		return "announcementList";
	}
	
	//@GetMapping("/writepost")
	//public String writepost() {	
	//	return "announcementForm";
	//}
	
	@GetMapping("/postList/search")
	public String searchedPostList(@RequestParam String query, @RequestParam(value = "page", defaultValue = "1") int page,
			Model model)
	{	
		int postperPage = 10;
		int totalPosts = announcementService.searchedPostCount(query);
		int totalPages = (int) Math.ceil((double) totalPosts / postperPage);
		List<AnnouncementDTO> searchResults = announcementService.getSearchedPostbyPage(page, postperPage, query);

		model.addAttribute("posts", searchResults);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);

		return "postListView";
	}
	
	
	@GetMapping("/postDetail/{postId}")
	public String getboardDetailbyboardId(@PathVariable Integer postId, Model model) 
	{
		AnnouncementDTO announcementDTO = announcementService.getboardDetailbypostId(postId);
		model.addAttribute("announcementDTO", announcementDTO);
		return "announcementDetail";
	}
	
	@PostMapping("/insertpost")
	public String insertpost(AnnouncementDTO post, HttpSession session) 
	{
		announcementService.insertPost(post);
		return "announcementList";
	}
	
	@PostMapping("/updatepost/{postId}")
	public String updatepost(@PathVariable Integer postId, AnnouncementDTO post, HttpSession session) 
	{
		
//		if (session.getAdmin == 1) 
//		{
//			String userId = (String) session.getAttribute("userId");
//			post.setUserId(userId);
//		}
		post.setAnnouncementNo(postId);
		announcementService.updatePost(post);
		return "redirect:/Announcement/postDetail/"+ postId;
	}
	
	@GetMapping("/deletepost/{postId}")
	public String deletepost(@PathVariable Integer postId, HttpSession session) {
		announcementService.deletePostbypostId(postId);
		return "announcementList";
	}
	
	
}

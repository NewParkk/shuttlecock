package com.fp.shuttlecock.announcement;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fp.shuttlecock.freeboard.FreeboardDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;






@Controller
@RequestMapping("/Announcement")
public class AnnouncementController 
{
	
	@Autowired
	AnnouncementService announcementService;
	
	@GetMapping("/")
	public String pagination(@RequestParam(value = "page", defaultValue = "1") int page, Model model)
	{	
		int postperPage = 10;
		int totalPost = announcementService.countPosts();
		int totalPage = (int) Math.ceil((double) totalPost / postperPage);
		List<AnnouncementDTO> postList = announcementService.getPostbyPage(page, postperPage);
//		System.out.println("totalPost : "+totalPost);
//		System.out.println("totalPage : "+totalPage);
//		System.out.println("postList : "+postList.toString());
		
		model.addAttribute("postList", postList);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPage", totalPage);
		
		return "/Announcement/announcementList";
	}
	
	@GetMapping("/register")
	public String writepost() {	
		return "/Announcement/announcementRegister";
	}
	
	@GetMapping("/postList/search")
	public String searchedPostList(@RequestParam String query, @RequestParam(value = "page", defaultValue = "1") int page,
			Model model)
	{	
		int postperPage = 10;
		int totalPost = announcementService.searchedPostCount(query);
		int totalPage = (int) Math.ceil((double) totalPost / postperPage);
		List<AnnouncementDTO> searchResults = announcementService.getSearchedPostbyPage(page, postperPage, query);

		model.addAttribute("postList", searchResults);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPage", totalPage);

		return "/Announcement/announcementList";
	}
	
	
	@GetMapping("/postDetail/{postId}")
	public String getpostDetailbyboardId(@PathVariable Integer postId, Model model) 
	{
		AnnouncementDTO post = announcementService.getpostDetailbypostId(postId);
		announcementService.hit(postId);
		model.addAttribute("post", post);
//		System.out.println("postDetail : " + post);
		return "/Announcement/announcementDetail";
	}
	
	
	@PostMapping("/insertpost")
	public String insertpost(AnnouncementDTO post, HttpSession session) 
	{	
		String userId = (String) session.getAttribute("userId");
		post.setUserId(userId);
		announcementService.insertPost(post);
		return "redirect:/Announcement/";
	}
	
	@GetMapping("/update/{postId}")
	public String updateFree(@PathVariable int postId, AnnouncementDTO post, Model model) {
		AnnouncementDTO updatepost = announcementService.getpostDetailbypostId(postId);
		System.out.println("updatepost : " + updatepost);
		model.addAttribute("post", updatepost);
		return "/Announcement/announcementUpdate";
	}
	
	
	@PostMapping("/updatepost")
	public String updatepost(AnnouncementDTO post, HttpSession session) 
	{
		String userId = (String) session.getAttribute("userId");
		System.out.println("title : " + post.getTitle());
		post.setUserId(userId);
		post.setAnnouncementNo(post.getAnnouncementNo());

		announcementService.updatePost(post);
		return "redirect:/Announcement/postDetail/"+ post.getAnnouncementNo();
	}
	
	
	@DeleteMapping("/deletepost/{postId}")
	public ResponseEntity<String> deletepost(@PathVariable Integer postId, HttpSession session) 
	{
		boolean result = announcementService.deletePostbypostId(postId);
		if (result) {
			return ResponseEntity.ok("게시글 삭제 성공");
		}else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("게시글 삭제 실패");
		}
	}
	
	
	
	
	
	
}

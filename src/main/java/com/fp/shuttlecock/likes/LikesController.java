package com.fp.shuttlecock.likes;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;


@Controller
public class LikesController {
	@Autowired
	LikesServiceImpl likeservice;
	
	
	@PostMapping("/likes")
	public ResponseEntity<String> likes(@ModelAttribute LikesDTO like, HttpSession session) {
		System.out.println(like);
		if(session.getAttribute("userId") != null) {
			like.setUserId(String.valueOf(session.getAttribute("userId")));
			if(likeservice.checkLikesList(like)) {
				likeservice.likesCancel(like);
				likeservice.likesDecrease(like);
			} else {
				likeservice.likesIncrease(like);
				likeservice.insertLikes(like);
			}
			return ResponseEntity.ok("좋아요");
		} else {
			return ResponseEntity.status(403).body("권한 없음");
		}
	}
	
}

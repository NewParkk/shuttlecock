package com.fp.shuttlecock.comments;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

@Controller
public class CommentsController {
	@Autowired
	CommentsServiceImpl commentService;
	
	@PostMapping(value = "/comments/insert")
	public ResponseEntity<String> insertComment(CommentsDTO comment, HttpSession session) {
		System.out.println(comment);
		if(session.getAttribute("userId") != null) {
			comment.setUserId(String.valueOf(session.getAttribute("userId")));
		//try {
			boolean result = commentService.insertComment(comment);
			if(result) {
				commentService.increaseCommentCount(comment);
				return ResponseEntity.ok("삽입성공"); 
			}
		}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
		return ResponseEntity.status(500).body("삽입실패");
	}
	
	@DeleteMapping(value = "/comments/{commentsId}")
	public ResponseEntity<String> deleteComment(@PathVariable int commentsId, HttpSession session) {
		CommentsDTO comment = commentService.getCommentByCommentsId(commentsId); 
		System.out.println("코멘트 아이디 : " + commentsId);
	    if (session.getAttribute("userId") != null && 
	    		String.valueOf(session.getAttribute("userId")).equals(comment.getUserId()) ||
	    		(boolean)session.getAttribute("isAdmin") == true) {
	        //try {
	            boolean result = commentService.deleteComment(commentsId);
	            if (result) {
	            	commentService.decreaseCommentCount(comment);
	                return ResponseEntity.ok("댓글 삭제 성공");
	            } else {
	                return ResponseEntity.status(500).body("댓글 삭제 실패");
	            }
//	        } catch (SQLException e) {
//	            e.printStackTrace();
//	            return ResponseEntity.status(500).body("댓글 삭제 실패");
//	        }
	    }
	    return ResponseEntity.status(403).body("삭제 권한 없음");
	}
	
	@PostMapping("/comments/update")
	public String updateComment(CommentsDTO comment, HttpSession session) {
		System.out.println(comment);
		int commentBno = comment.getBno();
	    if (session.getAttribute("userId") != null && 
	    		String.valueOf(session.getAttribute("userId")).equals(comment.getUserId())) {
	        //try {
	            boolean result = commentService.updateComment(comment);
	            if (result) {
	            	if(comment.getCommentType() == 2) {
	            		return "redirect:/Freeboard/freeDetail" + commentBno;
	            	} else if(comment.getCommentType() == 3) {
	            		return "redirect:/Tradeboard/" + commentBno;
	            	} else if(comment.getCommentType() == 4) {
	            		return "redirect:/Recruitboard/" + commentBno;
	            	} else {
	            		return "error";
	            	}
	            	
	            } else {
	                return "error";
	            }
//	        } catch (SQLException e) {
//	            e.printStackTrace();
//	            return ResponseEntity.status(500).body("댓글 삭제 실패");
//	        }
	    }
	    return "error";
	}
}

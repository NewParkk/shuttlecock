package com.fp.shuttlecock.comments;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class CommentsController {
	@Autowired
	CommentsServiceImpl commentService;
	
	@PostMapping(value = "/comments/insert")
	public ResponseEntity<String> insertComment(CommentsDTO comment, HttpSession session) {
		if(session.getAttribute("userId") != null) {
			comment.setCommentId((String.valueOf(session.getAttribute("userId"))));
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
	
	@DeleteMapping("/comments/{commentsId}")
	public ResponseEntity<String> deleteComment(int commentsId, HttpSession session) {
		CommentsDTO comment = commentService.getCommentByCommentsId(commentsId); 
	    if (session.getAttribute("userId") != null && 
	    		String.valueOf(session.getAttribute("userId")).equals(comment.getCommentId()) ||
	    		(Integer)session.getAttribute("admin") == 1) {
	        //try {
	            boolean result = commentService.deleteComment(commentsId);
	            if (result) {
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
	public ResponseEntity<String> updateComment(int commentsId, HttpSession session) {
		CommentsDTO comment = commentService.getCommentByCommentsId(commentsId); 
	    if (session.getAttribute("userId") != null && 
	    		String.valueOf(session.getAttribute("userId")).equals(comment.getCommentId())) {
	        //try {
	            boolean result = commentService.updateComment(comment);
	            if (result) {
	                return ResponseEntity.ok("댓글 수정 성공");
	            } else {
	                return ResponseEntity.status(500).body("댓글 수정 실패");
	            }
//	        } catch (SQLException e) {
//	            e.printStackTrace();
//	            return ResponseEntity.status(500).body("댓글 삭제 실패");
//	        }
	    }
	    return ResponseEntity.status(403).body("수정 권한 없음");
	}
}

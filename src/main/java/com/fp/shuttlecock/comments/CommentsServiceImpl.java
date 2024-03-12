package com.fp.shuttlecock.comments;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentsServiceImpl implements CommentsService {
	@Autowired
	CommentsMapper commentsmapper;
	
	public boolean insertComment(CommentsDTO comment) {
		int result = commentsmapper.insertComment(comment);
		if(result == 1) {
			return true;
		}
		return false;
	}

	public CommentsDTO getCommentByCommentsId(int commentsId) {
		return commentsmapper.getCommentByCommentsId(commentsId);
	}

	public boolean deleteComment(int commentsId) {
		int result = commentsmapper.deleteComment(commentsId);
		if(result == 1) {
			return true;
		}
		return false;
	}

	public boolean updateComment(CommentsDTO comment) {
		int result = commentsmapper.updateComment(comment);
		if(result == 1) {
			return true;
		}
		return false;
	}

	public List<CommentsDTO> getCommentList(int boardId, int comment_type) {
		Map<String, Integer> map = new HashMap<>();
		map.put("bno", boardId);
		map.put("comment_type", comment_type);

		return commentsmapper.getCommentList(map);
	}
	
	public void increaseCommentCount(CommentsDTO comment) {
		commentsmapper.increaseCommentCount(comment);
	}

	public void decreaseCommentCount(CommentsDTO comment) {
		commentsmapper.decreaseCommentCount(comment);
	}

}
package com.fp.shuttlecock.comments;

import java.util.List;

import io.lettuce.core.dynamic.annotation.Param;

public interface CommentsService {
	
	boolean insertComment(CommentsDTO comment);
	
	CommentsDTO getCommentByCommentsId(int commentsId);
	
	boolean deleteComment(int commentsId);
	
	boolean updateComment(CommentsDTO comment);
	
	List<CommentsDTO> getCommentList(String userId, int bno, int commentType);
	
	void increaseCommentCount(CommentsDTO comment);
	
	void decreaseCommentCount(CommentsDTO comment);
	
	boolean updateDeletedComment(int commentsId);
}

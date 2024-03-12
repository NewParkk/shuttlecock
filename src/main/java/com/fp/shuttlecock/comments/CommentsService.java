package com.fp.shuttlecock.comments;

import java.util.List;

public interface CommentsService {
	
	boolean insertComment(CommentsDTO comment);
	
	CommentsDTO getCommentByCommentsId(int commentsId);
	
	boolean deleteComment(int commentsId);
	
	boolean updateComment(CommentsDTO comment);
	
	List<CommentsDTO> getCommentList(int boardId, int comment_type);
	
	void increaseCommentCount(CommentsDTO comment);
	
	void decreaseCommentCount(CommentsDTO comment);
}

package com.fp.shuttlecock.comments;

import java.util.List;

public interface CommentsService {
	List<CommentsDTO> getCommentList(int boardId);
	
	boolean insertComment(CommentsDTO comment);
	
	CommentsDTO getCommentByCommentsId(int commentsId);
	
	boolean deleteComment(int commentsId);
	
	boolean updateComment(CommentsDTO comment);
	
	List<CommentsDTO> getCommentListByTradeboardId(int tradeboardId);
	
	List<CommentsDTO> getCommentListByFreeboardId(int freeboardId);
	
	List<CommentsDTO> getCommentListByRecruitboardId(int recruitboardId);
	
	void increaseCommentCount(CommentsDTO comment);
}

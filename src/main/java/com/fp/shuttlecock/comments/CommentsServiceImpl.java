package com.fp.shuttlecock.comments;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentsServiceImpl implements CommentsService {
	@Autowired
	CommentsMapper commentsmapper;
	
	public List<CommentsDTO> getCommentList(int boardId) {
		return commentsmapper.getCommentList(boardId);
	}
	
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

	public List<CommentsDTO> getCommentListByTradeboardId(int tradeboardId) {
		return commentsmapper.getCommentListByTradeboardId(tradeboardId);
	}
	
	public List<CommentsDTO> getCommentListByFreeboardId(int freeboardId) {
		return commentsmapper.getCommentListByFreeboardId(freeboardId);
	}
	
	public List<CommentsDTO> getCommentListByRecruitboardId(int recruitboardId) {
		return commentsmapper.getCommentListByRecruitboardId(recruitboardId);
	}

	public void increaseCommentCount(CommentsDTO comment) {
		commentsmapper.increaseCommentCount(comment);
	}

}
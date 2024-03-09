package com.fp.shuttlecock.comments;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentsMapper {

	List<CommentsDTO> getCommentList(int boardId);
	
	int insertComment(CommentsDTO comment);

	CommentsDTO getCommentByCommentsId(int commentsId);

	int deleteComment(int commentsId);

	int updateComment(CommentsDTO comment);

	void increaseCommentCount(CommentsDTO comment);

	List<CommentsDTO> getCommentListByTradeboardId(int tradeboardId);

	List<CommentsDTO> getCommentListByFreeboardId(int freeboardId);

	List<CommentsDTO> getCommentListByRecruitboardId(int recruitboardId);

}

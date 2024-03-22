package com.fp.shuttlecock.comments;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentsMapper {

	List<CommentsDTO> getCommentList(Map<String, Integer> map);
	
	int insertComment(CommentsDTO comment);

	CommentsDTO getCommentByCommentsId(int commentsId);

	int deleteComment(int commentsId);

	int updateComment(CommentsDTO comment);

	void increaseCommentCount(CommentsDTO comment);

	void decreaseCommentCount(CommentsDTO comment);

	int updateDeletedComment(int commentsId);

}

package com.fp.shuttlecock.comments;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import io.lettuce.core.dynamic.annotation.Param;

@Mapper
public interface CommentsMapper {

	List<CommentsDTO> getCommentList(@Param("userId") String userId,@Param("bno") int bno, @Param("commentType") int commentType);
	
	int insertComment(CommentsDTO comment);

	CommentsDTO getCommentByCommentsId(int commentsId);

	int deleteComment(int commentsId);

	int updateComment(CommentsDTO comment);

	void increaseCommentCount(CommentsDTO comment);

	void decreaseCommentCount(CommentsDTO comment);

	int updateDeletedComment(int commentsId);

}

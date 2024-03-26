package com.fp.shuttlecock.likes;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LikesMapper {

	void likesIncrease(LikesDTO like);

	void insertLikes(LikesDTO like);

	int checkLikesList(LikesDTO like);

	void likesCancel(LikesDTO like);

	void likesDecrease(LikesDTO like);

	
}

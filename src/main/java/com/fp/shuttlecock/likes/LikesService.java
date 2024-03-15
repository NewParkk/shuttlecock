package com.fp.shuttlecock.likes;

public interface LikesService {
	void likesIncrease(LikesDTO like);
	
	void insertLikes(LikesDTO like);
	
	boolean checkLikesList(LikesDTO like);
	
	void likesCancel(LikesDTO like);
	
	void likesDecrease(LikesDTO like);
}

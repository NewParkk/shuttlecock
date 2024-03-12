package com.fp.shuttlecock.likes;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LikesServiceImpl implements LikesService{
	@Autowired
	LikesMapper likesmapper;

	public void likesIncrease(LikesDTO like) {
		likesmapper.likesIncrease(like);
	}

	public void insertLikes(LikesDTO like) {
		likesmapper.insertLikes(like);
	}

	public boolean checkLikesList(LikesDTO like) {
		boolean result = false;
		if(likesmapper.checkLikesList(like) != 0) {
			result = true;
		}
		return result;
	}

	public void likesCancel(LikesDTO like) {
		likesmapper.likesCancel(like);
	}

	public void likesDecrease(LikesDTO like) {
		likesmapper.likesDecrease(like);
		
	}
}

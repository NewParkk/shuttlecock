package com.fp.shuttlecock.likes;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LikesServiceImpl implements LikesService {
	@Autowired
	LikesMapper likesmapper;

	@Override
	public void likesIncrease(LikesDTO like) {
		likesmapper.likesIncrease(like);
	}

	@Override
	public void insertLikes(LikesDTO like) {
		likesmapper.insertLikes(like);
	}

	@Override
	public boolean checkLikesList(LikesDTO like) {
	    int count = likesmapper.checkLikesList(like);
	    return count != 0;
	}

	@Override
	public void likesCancel(LikesDTO like) {
		likesmapper.likesCancel(like);
	}

	@Override
	public void likesDecrease(LikesDTO like) {
		likesmapper.likesDecrease(like);

	}
}

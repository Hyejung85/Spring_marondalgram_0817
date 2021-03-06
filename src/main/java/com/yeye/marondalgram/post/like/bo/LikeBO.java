package com.yeye.marondalgram.post.like.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yeye.marondalgram.post.like.dao.LikeDAO;
import com.yeye.marondalgram.post.like.model.Like;

@Service
public class LikeBO {

	@Autowired
	private LikeDAO likeDAO;	
	
	// 좋아요
	public int like(int postId, int userId) {
		return likeDAO.insertLike(postId, userId);
	}
	
	// 좋아요 했는지 확인 (PostController사용)
	public boolean existLike(int postId, int userId) {
		int count = likeDAO.selectCountLike(postId, userId);
				
		if(count >= 1) {
			return true;
		}else {
			return false;
		}
			
	}
	// 좋아요 갯수
	public int countLike(int postId) {
		return likeDAO.selectCountLikeByPostId(postId);
	}
	// 좋아요 취소
	public int dislike(int postId, int userId) {
		return likeDAO.deleteLike(postId, userId);
	}
	// 좋아요 삭제
	public int deleteLike(int postId) {
		return likeDAO.deleteLikeByPostId(postId);
	}
}

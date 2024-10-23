package com.pro.my.board.service;

import com.pro.my.board.dao.ILikesDAO;
import com.pro.my.board.vo.LikesVO;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LikesService {

    @Autowired
    private ILikesDAO likesDAO;

    // 좋아요 추가
    public int addLike(int postId, String memId) {
        return likesDAO.insertLike(postId, memId);
    }

    // 좋아요 삭제
    public int removeLike(int postId, String memId) {
        return likesDAO.deleteLike(postId, memId);
    }

    // 좋아요 상태 확인
    public boolean isLiked(int postId, String memId) {
        LikesVO like = likesDAO.checkLike(postId, memId);
        return like != null;
    }
    
    public int countLikes(int postId) {
        return likesDAO.countLikesByPostId(postId);
    }
    
    // 특정 게시물에 좋아요를 누른 memId 목록 조회
    public List<String> getLikeMemIdsByPostId(int postId) {
        return likesDAO.selectMemIdsByPostId(postId);
    }
}

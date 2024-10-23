package com.pro.my.board.service;

import com.pro.my.board.dao.IFavoriteDAO;
import com.pro.my.board.vo.FavoriteVO;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FavoriteService {

    @Autowired
    private IFavoriteDAO favoriteDAO;

    // 즐겨찾기 추가
    public int addFavorite(int postId, String memId) {
        return favoriteDAO.insertFavorite(postId, memId);
    }

    // 즐겨찾기 삭제
    public int removeFavorite(int postId, String memId) {
        return favoriteDAO.deleteFavorite(postId, memId);
    }

    // 즐겨찾기 상태 확인
    public boolean isFavorited(int postId, String memId) {
        FavoriteVO favorite = favoriteDAO.checkFavorite(postId, memId);
        return favorite != null;
    }

    // 즐겨찾기 수 가져오기
    public int countFavorites(int postId) {
        return favoriteDAO.countFavoritesByPostId(postId);
    }

    // 특정 게시물에 즐겨찾기를 한 memId 목록 조회
    public List<String> getFavoriteMemIdsByPostId(int postId) {
        return favoriteDAO.selectMemIdsByPostId(postId);
    }
}

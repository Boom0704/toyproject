package com.pro.my.board.dao;

import com.pro.my.board.vo.FavoriteVO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface IFavoriteDAO {

    // 게시글에 즐겨찾기 추가
    public int insertFavorite(@Param("postId") int postId, @Param("memId") String memId);

    // 게시글에서 즐겨찾기 삭제
    public int deleteFavorite(@Param("postId") int postId, @Param("memId") String memId);

    // 특정 게시글에 특정 사용자가 즐겨찾기를 했는지 확인
    public FavoriteVO checkFavorite(@Param("postId") int postId, @Param("memId") String memId);
    
    // 특정 게시물의 즐겨찾기 수 가져오기
    public int countFavoritesByPostId(@Param("postId") int postId);
    
    // 특정 게시물에 즐겨찾기한 사용자 ID 목록 조회
    public List<String> selectMemIdsByPostId(@Param("postId") int postId);
}

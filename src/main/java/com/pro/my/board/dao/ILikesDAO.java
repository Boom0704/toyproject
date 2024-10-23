package com.pro.my.board.dao;

import com.pro.my.board.vo.LikesVO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ILikesDAO {

    // 게시글에 좋아요 추가
	public int insertLike(@Param("postId") int postId, @Param("memId") String memId);

    // 게시글에서 좋아요 삭제
	public int deleteLike(@Param("postId") int postId, @Param("memId") String memId);

    // 특정 게시글에 특정 사용자가 좋아요를 눌렀는지 확인
	public LikesVO checkLike(@Param("postId") int postId, @Param("memId") String memId);
    
	public int countLikesByPostId(@Param("postId") int postId);
	
	public List<String> selectMemIdsByPostId(@Param("postId") int postId);
}

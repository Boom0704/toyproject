package com.pro.my.board.dao;

import com.pro.my.board.vo.CommentVO;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ICommentDAO {
    // 댓글 생성
    public int insertComment(CommentVO comment);

    // 댓글 삭제
    public void deleteComment(int id);

    // 특정 게시물의 댓글 목록 조회
    public List<CommentVO> selectCommentsByPostId(int postId);
}

package com.pro.my.board.service;

import com.pro.my.board.dao.ICommentDAO;
import com.pro.my.board.vo.CommentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {

    @Autowired
    private ICommentDAO commentDAO;

    // 댓글 생성
    public int insertComment(CommentVO comment) {
        return commentDAO.insertComment(comment);
    }

    // 댓글 삭제
    public void deleteComment(int id) {
        commentDAO.deleteComment(id);
    }


    // 특정 게시물의 댓글 목록 조회
    public List<CommentVO> selectCommentsByPostId(int postId) {
        return commentDAO.selectCommentsByPostId(postId);
    }
}

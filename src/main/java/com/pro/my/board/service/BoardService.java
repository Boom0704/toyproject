package com.pro.my.board.service;

import com.pro.my.board.dao.IBoardDAO;
import com.pro.my.board.vo.BoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardService {

    @Autowired
    private IBoardDAO boardDAO;

    // 게시물 생성
    public int insertBoard(BoardVO board) {
        return boardDAO.insertBoard(board);
    }

    // 게시물 삭제
    public void deleteBoard(int postId) {
        boardDAO.deleteBoard(postId);
    }

    // 게시물 조회 (by postId)
    public BoardVO selectBoardById(int postId) {
        return boardDAO.selectBoardById(postId);
    }

    // 게시물 목록 조회
    public List<BoardVO> selectAllBoards() {
        return boardDAO.selectAllBoards();
    }

    // 전체 게시물 조회 (관리자용)
    public List<BoardVO> selectAllBoardsAdmin() {
        return boardDAO.selectAllBoardsAdmin();
    }
}

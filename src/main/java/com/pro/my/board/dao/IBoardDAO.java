package com.pro.my.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pro.my.board.vo.BoardVO;
import com.pro.my.member.vo.MemberVO;

@Mapper
public interface IBoardDAO {
    // 게시물 생성
	public int insertBoard(BoardVO board);

    // 게시물 삭제
    public void deleteBoard(int postId);

    // 게시물 조회
    public BoardVO selectBoardById(int postId);

    // 게시물 목록 조회 (페이지네이션)
    public List<BoardVO> selectAllBoards();

    // 게시물 전체 조회 (관리자용 등)
    public List<BoardVO> selectAllBoardsAdmin();
}

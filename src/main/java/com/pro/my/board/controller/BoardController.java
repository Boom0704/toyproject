package com.pro.my.board.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pro.my.board.service.BoardService;
import com.pro.my.board.service.CommentService;
import com.pro.my.board.vo.BoardVO;
import com.pro.my.board.vo.CommentVO;

@Controller
public class BoardController {
	
    @Autowired
    private BoardService boardService;
    @Autowired
    private CommentService commentService;
    
	@RequestMapping("/boardView")
	public String boardView(Model model) {
		List<BoardVO> boardList = boardService.selectAllBoards();
	    model.addAttribute("boards", boardList);  // 모델 이름을 'boards'로 맞춤
		return "board/boardView";
	}
	
	@RequestMapping("/boardWriteView")
	public String boardWriteView() {
		return "board/boardWriteView";
	}
	
	 @RequestMapping("/boardDetailView/{id}")
	    public String boardDetailView(@PathVariable("id") int id, Model model) {
	        BoardVO board = boardService.selectBoardById(id);
	        List<CommentVO> comments = commentService.selectCommentsByPostId(id);
	        for(CommentVO c:comments) {
	        	System.out.println(c);
	        }
	        model.addAttribute("board", board);
	        model.addAttribute("comments", comments);

	        return "board/boardDetailView";
	    }
	
	
    // 게시물 작성 처리
    @RequestMapping(value = "/boardWriteDo", method = RequestMethod.POST)
    @ResponseBody
    public String boardWriteDo(@RequestBody Map<String, Object> requestData) {
        // 디버그 출력
        System.out.println("Received data: " + requestData);

        BoardVO board = new BoardVO();
        board.setTitle((String) requestData.get("title"));
        board.setContent((String) requestData.get("content"));
        board.setPhotoUrls(String.join(",", (List<String>) requestData.get("imageUrls")));
        board.setLatitude(Double.parseDouble(requestData.get("latitude").toString()));
        board.setLongitude(Double.parseDouble(requestData.get("longitude").toString()));
        board.setMemId((String) requestData.get("memId"));

        // 데이터 확인용 출력
        System.out.println("Board Data: " + board);

        // 게시물 생성
        int result = boardService.insertBoard(board);

        if (result > 0) {
            return "success"; // 성공 시 클라이언트에 성공 메시지 반환
        } else {
            return "failure"; // 실패 시 실패 메시지 반환
        }
    }

    // 게시물 조회
    @GetMapping("/selectBoardById/{postId}")
    public BoardVO selectBoardById(@PathVariable int postId) {
        return boardService.selectBoardById(postId);
    }

    // 게시물 목록 조회
    @GetMapping("/selectAllBoards")
    public List<BoardVO> selectAllBoards() {
    	return boardService.selectAllBoards();
    }


    @RequestMapping(value = "/deleteBoard/{postId}", method = RequestMethod.DELETE)
    public ResponseEntity<?> deleteBoard(@PathVariable int postId) {
        try {
            boardService.deleteBoard(postId); // 게시글 삭제 처리
            // 삭제 성공 시 상태 코드 200과 함께 게시판 목록 페이지로 리다이렉트 URL 반환
            return ResponseEntity.status(HttpStatus.OK).body("Board post deleted successfully. Redirecting to /boardView");
        } catch (Exception e) {
            // 삭제 실패 시 상태 코드 500과 함께 오류 메시지 반환
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to delete board post: " + e.getMessage());
        }
    }


}

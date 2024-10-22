package com.pro.my.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.pro.my.board.service.CommentService;
import com.pro.my.board.vo.CommentVO;

@RestController // RestController를 사용하여 JSON 반환
@RequestMapping("/comment") // 컨트롤러의 기본 경로 설정
public class CommentController {
    
    @Autowired
    private CommentService commentService;
    
    // 댓글 작성
    @PostMapping("/add")
    public String insertComment(@RequestBody CommentVO comment) {
        commentService.insertComment(comment);
        System.out.println(comment);
        return "Comment added successfully";
    }
    
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteComment(@PathVariable("id") int id) {
        try {
            commentService.deleteComment(id);
            return ResponseEntity.ok().build();  // 삭제 성공 시 응답
        } catch (Exception e) {
            return ResponseEntity.status(500).body("댓글 삭제 실패");  // 삭제 실패 시 응답
        }
    }
}
